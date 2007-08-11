From: Dmitry Kakurin <dmitry.kakurin@gmail.com>
Subject: Re: msysgit: does git gui work?
Date: Fri, 10 Aug 2007 23:10:50 -0700
Message-ID: <ACBC67D9E9124ECFAAF6B0E20CE660C0@ntdev.corp.microsoft.com>
References: <3CD6111C-13B5-444C-A28C-A7445C8A199B@zib.de> <E886F099-5E9F-4785-A560-F9AAAA4E4C1F@zib.de> <20070810053158.GJ24573@spearce.org> <B6C82889-ABE0-4B3D-A455-A2EE1CE48297@zib.de> <Pine.LNX.4.64.0708101113380.21857@racer.site> <81b0412b0708100440l116f934ft22d3ac3c71e2e7cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 11 08:10:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJkBe-0004ok-Ek
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 08:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbXHKGKz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 02:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbXHKGKz
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 02:10:55 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:49046 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903AbXHKGKy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 02:10:54 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1124730wah
        for <git@vger.kernel.org>; Fri, 10 Aug 2007 23:10:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:to:cc:references:in-reply-to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=V8EvNWBLAw+IvXHPYwbW/sb662M7g19s0OhtFCjF/F3O85IBn4eL0q2aw88f6yak0lgPYp0r6kFjmwOqjwcY4KH48RgxonJwwaa7BB86+hp+6CBNygGE+scB+eICmZbFQJk5w7rtQbSMRCr7zjGPQGiryS3De7Bke3kASfGMSjg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:to:cc:references:in-reply-to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=Kndm59v75oFCy+5ArYhvtqRmX2gOuQU9SN+n+7YLF0HNF4lU8Q+wy0pu2IA5z20R0Ug2Imu8xXKLvwvSlxtqcYjr+QSxCT5ocqPrIo2UUK4scvc9AjBHVPyzvIi68Lzvxx3CbCo39j8/GMvi0HSRt7tPSIOpHtt17VFBh13ETIk=
Received: by 10.114.193.1 with SMTP id q1mr3274754waf.1186812653321;
        Fri, 10 Aug 2007 23:10:53 -0700 (PDT)
Received: from dmitrykl2 ( [71.112.20.227])
        by mx.google.com with ESMTPS id j39sm3874606waf.2007.08.10.23.10.52
        (version=SSLv3 cipher=OTHER);
        Fri, 10 Aug 2007 23:10:52 -0700 (PDT)
In-Reply-To: <81b0412b0708100440l116f934ft22d3ac3c71e2e7cf@mail.gmail.com>
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Windows Mail 6.0.6000.16480
X-MIMEOLE: Produced By Microsoft MimeOLE V6.0.6000.16480
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55589>

From: "Alex Riesen" <raa.lkml@gmail.com>
>> In my experience, Windows users (not Mac users forced to use Windows)
>> _expect_ "." to be in the PATH.
> 
> ...because they _cannot_ know otherwise. In Windows, you cannot remove "."
> from PATH, it is implicitly in it.
> It is actually worse than that: the system directories are in PATH
> too. Unconditionally.
> Yes, the same system directories all them programs put their .exes into.

This is not true:
C:\>where cmd.exe
C:\Windows\System32\cmd.exe

C:\>set path=

C:\>cmd
'cmd' is not recognized as an internal or external command,
operable program or batch file.

Also there is an option to exclude implicit '.' from path, but no one uses it because too many things will break.

- Dmitry
