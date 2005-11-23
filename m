From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Problem merging
Date: Tue, 22 Nov 2005 18:50:01 -0800 (PST)
Message-ID: <20051123025001.15527.qmail@web31812.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Nov 23 03:51:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EekiQ-0006CW-JK
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 03:50:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbVKWCuG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 21:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbVKWCuG
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 21:50:06 -0500
Received: from web31812.mail.mud.yahoo.com ([68.142.207.75]:59301 "HELO
	web31812.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932459AbVKWCuF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 21:50:05 -0500
Received: (qmail 15530 invoked by uid 60001); 23 Nov 2005 02:50:01 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=WZddM8UI7SjAIFbJQs66nWSwPYgpe3OCXM8sxDdg5BjBkyN18E3tntjWjZulvY86Ayo9hnMOZjvFxcC+FtX1RY+qI/WBOyk5sXfHn9a33543Jgf7tN3I9w9N/qkFUt+ee5UdZ/l3v7Ev/hc7Y3CVw1lco1vvpDMZvW3QDwITy08=  ;
Received: from [70.144.190.34] by web31812.mail.mud.yahoo.com via HTTP; Tue, 22 Nov 2005 18:50:01 PST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12597>

Ok, background:

I've two branches of the same .git, _but_ they live in
different directories (bearing the branches' names)
with different index caches, but with the same identical
objects directory (different HEADs of course).
(in effect, I have both branches "checked out")

Branch A is the "trunk", branch B is trunk+my changes.
I do:

branchA: git pull <remote>
branchA: cd ../branchB/
branchB: git resolve HEAD branchA "merge trunk"

And I get:

Trying to merge 4b4a27dff4e2d4cc2eac1cde31aede834a966a48 into
e1ef47b54d7e7e477f7f1eb3251a9d37f38e0469 using 989e4d6cbc69191c41ddf4b1c492457410376b43.
Simple merge failed, trying Automatic merge
Removing include/asm-um/ldt.h
fatal: merge program failed
Automatic merge failed, fix up by hand

This is with git HEAD: 
2392ee98eb76aa821de53c93c9e36acb18d27fc0 -- latest as
of now.

Is this a bug in git?  Since this process has always worked
before.

Thanks,
    Luben
