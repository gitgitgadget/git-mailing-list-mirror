From: Eugene Sajine <euguess@gmail.com>
Subject: git gc error - cannot lock ref 'RENAMED-REF..1'
Date: Thu, 1 Apr 2010 13:37:46 -0400
Message-ID: <j2k76c5b8581004011037rb81d80cdu1a4713cde31d4b56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 01 19:38:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxOLB-0008RS-A0
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 19:38:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757693Ab0DARhs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Apr 2010 13:37:48 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52270 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756683Ab0DARhr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Apr 2010 13:37:47 -0400
Received: by pwi5 with SMTP id 5so1233750pwi.19
        for <git@vger.kernel.org>; Thu, 01 Apr 2010 10:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=spRoWMU/DuOCvGx0n3p7Ilf9s4JKDeLc9bQm1TFUqcU=;
        b=fMOMsEaXSm8FbR/XCUoUknkQjhm4s6V56hNlW6Jui07A89uGuxWnGJa4ckbVGZnYVq
         WonrFmyUBmB8mF8ktF/UuypSE1Zz/uNSZuwScJ3ojB7LHTRr38oLwktv8sk4bo4oaTnY
         kgz1zQBG382DsWPS9pEQQ8B2i1vjnc62h61YE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=LVszSd3m+NAgGCa112wTNIMkgwu4yrMCnYWIcCU8m2mQbEkyMIt++hL3yCa2OxOROd
         0ij8p8UyFiiXkSFOh6w1aoDKSyUUYy0qPZrTyy3DDzUCOCaB4R2AfK3BmPSE6Z14f/nT
         COQas/Wka6GnSHDZfZvo2BNiR1aW8tafNtrG8=
Received: by 10.231.155.143 with HTTP; Thu, 1 Apr 2010 10:37:46 -0700 (PDT)
Received: by 10.114.237.20 with SMTP id k20mr1546721wah.185.1270143466256; 
	Thu, 01 Apr 2010 10:37:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143737>

I was running git gc weekly on my machine and today for some reason it
failed on one of my repos with an error saying

Error: cannot lock ref =E2=80=98RENAMED-REF..1=E2=80=99
Error: failed to run ref-log

The problem is I have no idea what it is talking about=E2=80=A6 =E2=80=9C=
git show-ref=E2=80=9D
doesn=E2=80=99t show anything even close to this name. Fools day joke?;=
)
Any advice?

Thanks in advance,
Eugene
