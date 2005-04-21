From: "Andrew Timberlake-Newell" 
	<Andrew.Timberlake-Newell@AllianceOneInc.com>
Subject: RE: on when to checksum
Date: Thu, 21 Apr 2005 12:53:30 -0400
Message-ID: <002a01c54692$a723adb0$9b11a8c0@allianceoneinc.com>
References: <200504202225.PAA15992@emf.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Cc: <torvalds@osdl.org>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 21 18:51:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOesX-0000qI-04
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 18:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbVDUQyj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 12:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVDUQyj
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 12:54:39 -0400
Received: from mail.allianceoneinc.com ([65.213.221.36]:23058 "EHLO
	mail.allianceoneinc.com") by vger.kernel.org with ESMTP
	id S261544AbVDUQy3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 12:54:29 -0400
Received: from epa20012 [192.168.17.155] by mail.allianceoneinc.com with ESMTP
  (SMTPD32-8.14) id AA8B179500AA; Thu, 21 Apr 2005 12:53:31 -0400
To: "'Tom Lord'" <lord@emf.net>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <200504202225.PAA15992@emf.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-IMAIL-SPAM-VALFROM: (da8a179500aaf4dc)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Tom Lord graced us with:
> I think you have made a mistake by moving the sha1 checksum from the
> zipped form to the inflated form.  Here is why:
> 
> What you have set in motion with `git' is an ad-hoc p2p network for
> sharing filesystem trees -- a global distributed filesystem.  I
> believe your starter here has a good chance of taking off to be much,
> much larger than just a tool for the kernel.

This might rather be a call for a git derivative.

As Linus has already mentioned in this thread, git is optimized for his need
for local speed.  But while sacrificing local speed for network speed would
break git by stepping away from the git philosophy, a gitling with a
different philosophy but making use of gitish techniques could make that
change without being broken even though git itself can't.


