From: Stephen Bash <bash@genarts.com>
Subject: Re: can't install on OS X
Date: Fri, 2 Oct 2015 09:41:49 -0400 (EDT)
Message-ID: <136388305.2086780.1443793308932.JavaMail.zimbra@genarts.com>
References: <560E2936.6020101@prodsyse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Spencer Graves <spencer.graves@prodsyse.com>
X-From: git-owner@vger.kernel.org Fri Oct 02 15:48:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zi0hV-0003Z4-SG
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 15:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753326AbbJBNsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 09:48:35 -0400
Received: from hq.genarts.com ([173.9.65.1]:14181 "EHLO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753256AbbJBNsd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 09:48:33 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Oct 2015 09:48:33 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 4DB30BE1171;
	Fri,  2 Oct 2015 09:41:54 -0400 (EDT)
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 3r0OgsyUws6g; Fri,  2 Oct 2015 09:41:49 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 65894BE117E;
	Fri,  2 Oct 2015 09:41:49 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KT7bLe2QmxBx; Fri,  2 Oct 2015 09:41:49 -0400 (EDT)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 443CEBE1171;
	Fri,  2 Oct 2015 09:41:49 -0400 (EDT)
In-Reply-To: <2000572217.2086743.1443793295009.JavaMail.zimbra@genarts.com>
X-Mailer: Zimbra 8.5.1_GA_3056 (ZimbraWebClient - GC45 (Mac)/8.5.1_GA_3056)
Thread-Topic: can't install on OS X
Thread-Index: +aqTZn36s6HWeOgKgpthVjb3Kpci0w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278922>

----- Original Message -----
> From: "Spencer Graves" <spencer.graves@prodsyse.com>
> Sent: Friday, October 2, 2015 2:50:30 AM
> Subject: can't install on OS X
>
> I downloaded "git-2.5.3-intel-universal-mavericks.dmg" per
> instructions.  When I tried to install it, I first had trouble because
> it wasn't from the Mac App Store nor an "identified developer".

You can also right click on the installer and select "Open" for a very similar dialog, but one that gives you the opportunity to run the installer anyway.

> "README.txt" says I need "sudo mv /usr/bin/git /usr/bin/git-system".  I
> tried that and got, "mv: rename /usr/bin/git to /usr/bin/git-system:
> Operation not permitted" (after entering my password).  [My directory
> now includes "/usr/local/git", and "/usr/bin" includes git,
> git-cvsserver, git-receive-pack, git-shell, git-upload-archive, and
> git-upload-pack.]
> 
> Suggestions?

Sounds like you're running afoul of El Capitan's new System Integrity Protection (SIP) [1].  The git commands you're seeing there are probably Apple's thin wrappers that are mostly meant to provide instructions on installing XCode, but SIP is stopping you from modifying the /usr directory (ah, Apple's Infinite Wisdom).  There are discussions about working around SIP in the Apple forums [2] and Homebrew has some hints as well [3].

[1] https://developer.apple.com/library/prerelease/mac/releasenotes/MacOSX/WhatsNewInOSX/Articles/MacOSX10_11.html
[2] https://forums.developer.apple.com/thread/3981
[3] https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/El_Capitan_and_Homebrew.md#if-usrlocal-does-not-exist

HTH,
Stephen
