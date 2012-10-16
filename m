From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [RFC/PATCH 3/4v2] test-lib: provide lazy TIME_COMMAND prereq
Date: Tue, 16 Oct 2012 20:28:25 +0200
Message-ID: <507DA749.30509@gmail.com>
References: <007001cdaba8$5afc6c00$10f54400$@schmitz-digital.de> <28ca29e59c5905ba7232dcdbe4661f37ef90cac5.1350399860.git.git@drmicha.warpmail.net> <m2mwzmxtyb.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Joachim Schmitz <jojo@schmitz-digital.de>,
	Junio C Hamano <gitster@pobox.com>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 20:28:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOBsg-0005Mh-GZ
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 20:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754999Ab2JPS2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 14:28:32 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:34682 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754387Ab2JPS2b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 14:28:31 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so3177353bkc.19
        for <git@vger.kernel.org>; Tue, 16 Oct 2012 11:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=oBTEWHKl+ut0hux1aDrQDEVMP2T2ZaEyCg2GlfbLpoE=;
        b=ciUOA3TwipV4hwS/FAjAJpLs4NcFZM/hXWSJpb0/fYYNCnF7l97Kh66s6qZEGq1Qo+
         3fiCR3E1v08NOTA3yZZ/5EMZjTtuxuC+7xe9mfw6pS9kcplp/+TcDjnEOajx3F1w7YPA
         Kl3bk0gR3BuZcGEfLgbzaDPPYvaDlnNA4uC0zrKgPZjWoKxC3bTJq6BjlQt1TIc4UN6Q
         xipj05pFOeGlpLQqgdMEVvRfgBynG5W13vbZS+jwKrK43k03kGwhrveJkZi/IGfBXB61
         68/p/ETlKuRvND1MpNFneRR01EEZ3P8iPA6fxYf1krkGEgljKw43OtBrnad7zUCiJqpV
         Lsjw==
Received: by 10.204.12.205 with SMTP id y13mr4536325bky.46.1350412109849;
        Tue, 16 Oct 2012 11:28:29 -0700 (PDT)
Received: from [192.168.178.21] (host127-93-dynamic.7-79-r.retail.telecomitalia.it. [79.7.93.127])
        by mx.google.com with ESMTPS id e13sm11522195bkw.12.2012.10.16.11.28.26
        (version=SSLv3 cipher=OTHER);
        Tue, 16 Oct 2012 11:28:29 -0700 (PDT)
In-Reply-To: <m2mwzmxtyb.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207867>

Hi Andreas.  I hope you don't mind my nitpickiness, but ...

On 10/16/2012 06:28 PM, Andreas Schwab wrote:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Some test want to use the time command (not the shell builtin) and test
>> for its availability at /usr/bin/time.
> 
> An alternative way to suppress the builtin meaning is to quote it, like
> \time.
>
... to be 100% precise, this quoting trick works because 'time' is a
shell keyword, rather than a builtin:

    $ type time
    time is a shell keyword

Regards,
  Stefano
