From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Running parse cvs
Date: Fri, 16 Jun 2006 14:47:29 -0400
Message-ID: <9e4733910606161147m403a3f36r6657bd7b620958f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jun 16 20:48:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrJM8-0007Fo-16
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 20:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWFPSrb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 14:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWFPSrb
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 14:47:31 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:38111 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751422AbWFPSra (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jun 2006 14:47:30 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1107658nze
        for <git@vger.kernel.org>; Fri, 16 Jun 2006 11:47:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rlk2dr+L78TmCpebEaYWiwLI8dWmDBO91YyFrt3RvoF/a0u1YEf4WzIJQuyrP/5Q43HJz/cqL4pN6uDJXIQFUu5Mt16cPGUMIvEObi/VGciRKj634Qb9yn2bsRCHtbbGP4aoSQlEu5sS+HH2B1B6m2NIdR2iFPvavUYN7A+bnQs=
Received: by 10.36.48.8 with SMTP id v8mr85108nzv;
        Fri, 16 Jun 2006 11:47:29 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Fri, 16 Jun 2006 11:47:29 -0700 (PDT)
To: git <git@vger.kernel.org>, "Keith Packard" <keithp@keithp.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21964>

I am running the latest parsecvs from your git tree. I am hitting a quick gpf.

oad: sible/src/html/nsHTMLLinkAccessible *....................   253 of 100111
Load: essible/src/html/nsHTMLLinkAccessib *....................   254 of 100111
Load: ble/src/html/nsHTMLSelectAccessible *....................   255 of 100111
*** glibc detected *** /home/jonsmirl/workspace/parsecvs/parsecvs:
munmap_chunk(): invalid pointer: 0x08fd1db0 ***

In the call stack I am in git_rev_list_pack line 619 doing a free.
Called from parsecvs.c at 776

-- 
Jon Smirl
jonsmirl@gmail.com
