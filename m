From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [PATCH] remove noise and inaccuracies from git-svn docs
Date: Tue, 19 Apr 2011 17:59:54 +0200
Message-ID: <BANLkTimJa5EDxXerwgZP7viLFPQRc=39uQ@mail.gmail.com>
References: <1303138000-27807-1-git-send-email-stsp@stsp.name>
	<vpqhb9vplu4.fsf@bauges.imag.fr>
	<7v39lfa1h5.fsf@alter.siamese.dyndns.org>
	<20110419093108.GA7440@ted.stsp.name>
	<4DAD6FC4.6060004@drmicha.warpmail.net>
	<20110419120031.GE4134@ted.stsp.name>
	<4DAD7EFB.2050507@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stefan Sperling <stsp@stsp.name>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Apr 19 18:00:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCDLM-0008Mk-LO
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 18:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827Ab1DSP7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 11:59:55 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49017 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135Ab1DSP7z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 11:59:55 -0400
Received: by vws1 with SMTP id 1so4353890vws.19
        for <git@vger.kernel.org>; Tue, 19 Apr 2011 08:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=2eq8oxeuz4K4NEPWr3tqWV1kqSp/IASy2/LAsog6AQI=;
        b=HT+d1cMAWSfTyT+cOYda7VVSyVgJbOTJbG01fNhViwVEWlURoF0OtGxgJzQDM0EpYs
         1uoM6wUNWtNfuVwqb64HKjUCjC+thlRa41bXouflFd0gd0RZl6x0PlVw46+y+yEyYvm3
         B2YtBEI3s0+pPrL91/4txCVtZijY5Y9vCE2kk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=SbZLAHX6F+iq15HBLoeVzwabWCAioP/OvzKqE+vdqmqUAqZHk3SN4Dh6pFGahiOEZ/
         ZkrnRgiuawN1P7+8Gl2aENuFge4fK3xlBkqHkfdSZX03QPcRvXs+vqAtikX/f7GHm/ct
         6Lz+PsZ0W3kkLdk7HmU7J89HCMpftgqvuuJEA=
Received: by 10.220.18.208 with SMTP id x16mr1879518vca.130.1303228794222;
 Tue, 19 Apr 2011 08:59:54 -0700 (PDT)
Received: by 10.220.61.205 with HTTP; Tue, 19 Apr 2011 08:59:54 -0700 (PDT)
In-Reply-To: <4DAD7EFB.2050507@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171799>

On Tue, Apr 19, 2011 at 2:24 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Stefan Sperling venit, vidit, dixit 19.04.2011 14:00:
>> On Tue, Apr 19, 2011 at 01:19:32PM +0200, Michael J Gruber wrote:
>>> But, git-svn.perl is basically in maintenance mode
>>> it seems, and more work is being done to implement a new svn remote helper.
>>
>> Is there already code for this new helper I can look at?
>
> Please look for "svn-fe".

svn-fe is a one-time conversion tool, isn't it? It's completely
different than git-svn,
which allows interactive working with existing svn repository.

BTW, sorry for hijacking the thread, but could someone with better knowledge of
git-svn look at this problem:
    http://thread.gmane.org/gmane.comp.version-control.git/171481

Thanks,

-- 
Piotr Krukowiecki
