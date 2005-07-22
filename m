From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: Re: [PATCH 0/2] apply.c: a fix and an enhancement
Date: Sat, 23 Jul 2005 00:42:33 +0200
Message-ID: <87d5pa1mzq.fsf@gmail.com>
References: <7vzmsewzik.fsf@assigned-by-dhcp.cox.net>
	<20050722181800.GU20369@mythryan2.michonline.com>
	<7vsly6vd2b.fsf@assigned-by-dhcp.cox.net> <42E1571B.8070108@gmail.com>
	<Pine.LNX.4.58.0507221340450.6074@g5.osdl.org>
	<7vhdempmgg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507221447420.6074@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 00:42:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw6Dd-0007VZ-Ii
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 00:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbVGVWmG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 18:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262209AbVGVWmG
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 18:42:06 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:52443 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S262108AbVGVWmF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jul 2005 18:42:05 -0400
Received: from bela (ifae-s1.ifae.es [192.101.162.148])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id j6MMfxA30212;
	Sat, 23 Jul 2005 00:42:00 +0200
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507221447420.6074@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 22 Jul 2005 14:53:41 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Think of something like a collection of projects, each under their own 
> subdirectory. We could eventually literally make them _look_ like one big 
> project, with cross-project commits grafted together, but they'd 
> technically be totally independent (think "git" vs "gitk" - rather than 
> having a very tight merge like I did, we could have tried to make it be a 
> more virtual graft instead).

One posibility for a collection of projects is to make them with a tree of
commits instead of a tree of trees and blobs.

    Santi
