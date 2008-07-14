From: vb <vb@vsbe.com>
Subject: Syncing up to a tree with a numeric EXTRAVERSION
Date: Mon, 14 Jul 2008 12:24:33 -0700
Message-ID: <f608b67d0807141224v258172a7pfe655a0ceb0f8efd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 21:25:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KITfy-0005cy-Cs
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 21:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754463AbYGNTYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 15:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754386AbYGNTYf
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 15:24:35 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:17079 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753659AbYGNTYf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 15:24:35 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1551371nfc.21
        for <git@vger.kernel.org>; Mon, 14 Jul 2008 12:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=7VjZG+WpWdPsJOWAwQjlTbPoqqW8a5X29MKxhVZWy7I=;
        b=mNLR/zJZxC/iuAU94omcnbTtABTTz0r+tqnNEr9GTutrxUQ6hz4/+mJI4aZUIpL7mR
         JDxbirkmkoUNvsOLc45rI3gqXpK486f1vcYDw7xs0+1mBQIVl8HNntL7EptqKPV4uFUP
         gLd/RsoT/SSYQu3g0irdiMqHxQqpvH06NyKBM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=d5qrvrN372S6u/hH5vZW7z4yRU3alid4Jo6ZcucvbS4602jbyzQLUfZqkFpWezC5li
         EQjm9BTvx3jMokBF4ctiGEeLLOxPvp9N25kBJ7cnGKpd4FDaO8AwIGRgPa0/wFhC/Zx3
         KfhubsDjMfW68kQ9KXXwJkG0hA5aCYRFAeCWc=
Received: by 10.210.125.13 with SMTP id x13mr9174687ebc.88.1216063473639;
        Mon, 14 Jul 2008 12:24:33 -0700 (PDT)
Received: by 10.210.79.13 with HTTP; Mon, 14 Jul 2008 12:24:33 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: ceb643456f13683d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88452>

I have vendor provided linux tree which includes some vendor specific
code. The tree's top level Makefile has this header:

VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 19
EXTRAVERSION = .2
NAME=Avast! A bilge rat!


so, this is what I want to pull from the repository to see what's
different. The thing is that when I go to the Makefile history in the
master git repository
(http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=history;f=Makefile;h=e3c5eb66ec52dee13127e3b2b83f84c3184bd8be;hb=bce7f793daec3e65ec5c5705d2457b81fe7b5725;pg=1)
I don't see a tag for this version, all which is there between 19-rc6
and 20-rc1 are

2006-12-14 	Linus Torvalds 	Linux v2.6.20-rc1  v2.6.20-rc1
2006-12-13 	Jeff Dike 	[PATCH] Fix crossbuilding checkstack
2006-12-12 	Samuel Tardieu 	Use consistent casing in help message
2006-12-10 	Oleg Verych 	[PATCH] kbuild: fix-rR-is-now-default
2006-11-29 	Linus Torvalds 	Linux 2.6.19 v2.6.19
2006-11-16 	Linus Torvalds 	Linux 2.6.19-rc6 v2.6.19-rc6

so, the question is where do I find the tree with the Makefile
EXTRAVERSION set to .2?


TIA,
vadim
