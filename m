From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/3] Set cmdline globally, not in stop_here_user_resolve
Date: Tue, 1 Jun 2010 11:36:58 +0200
Message-ID: <AANLkTinY8Z-Y_1aFnJrojaAMs68FITt-whC0fLbpIR8h@mail.gmail.com>
References: <1275384022-12131-1-git-send-email-artagnon@gmail.com> 
	<1275384022-12131-2-git-send-email-artagnon@gmail.com> <4C04D268.6070908@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jun 01 11:37:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJNuf-0005cF-Qn
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 11:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754373Ab0FAJh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 05:37:29 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58831 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240Ab0FAJh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 05:37:28 -0400
Received: by vws11 with SMTP id 11so759917vws.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 02:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=ZgyAAn/qlWlGNUveR6LqTtI4hxl4y4WYEOJbBTj/2Fw=;
        b=D+zWp67qBZStycKa273uloqWh8p5iF8LvzmIDHFUGrdVUhi6oW9S1Zgd2p9O9oh5Qm
         2i9XyTdqlG5OB3CQUyioVCJxkABj3JrVUM+IzPWbg71zH25r73dik2DotxFgb7m/+lMU
         zplPf9zGnWQZzNBnDO/ls45epfeS3XvoHBB3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=stDSSZLr91cSsvF/V+udBLlKT2HPm9/D2LoiXcrMggLyzsZ8c+7SE4Q7llRqSKtFTc
         EFbVh4x4kV+Pi0DUNEmVDxzRn5s0i490PLLF9uRPXWQrj+qbx2MWrohD6tz5sl11Qu1H
         AvsEDCtf/ZTitfbopbuVNKJAZWLxF4tzd4bFA=
Received: by 10.229.238.72 with SMTP id kr8mr874872qcb.76.1275385038070; Tue, 
	01 Jun 2010 02:37:18 -0700 (PDT)
Received: by 10.229.50.3 with HTTP; Tue, 1 Jun 2010 02:36:58 -0700 (PDT)
In-Reply-To: <4C04D268.6070908@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148102>

Hi,

> Did you test this? "$0" prints the full path to git-am. This does not
> count as user-friendly in my book!

Doesn't it print out exactly the way you invoke the application ie.
either "./git-am.sh" or "git am"? Then again, when git-am is invoked
internally by git, it possibly uses the full path instead of relying
on $PATH, and this is quite ugly. I noticed that all the other other
shell scripts in git.git also hardcode the string, and there must be a
good reason for this. Therefore I think this particular change should
be dropped.

Thanks for pointing this out.

-- Ram
