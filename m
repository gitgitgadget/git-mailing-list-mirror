From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Wed, 31 Jan 2007 17:41:49 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701311733120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com>
 <7v8xfkz8oj.fsf@assigned-by-dhcp.cox.net> <3c6c07c20701301938u4d1503a2m3e0af51121b8e6db@mail.gmail.com>
 <Pine.LNX.4.64.0701302029460.3611@woody.linux-foundation.org>
 <7vodofx06s.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701310805500.3632@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 31 17:43:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCIWx-00015C-VR
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 17:41:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbXAaQlx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 11:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030262AbXAaQlx
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 11:41:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:57309 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030258AbXAaQlv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 11:41:51 -0500
Received: (qmail invoked by alias); 31 Jan 2007 16:41:50 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 31 Jan 2007 17:41:50 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0701310805500.3632@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38275>

Hi,

On Wed, 31 Jan 2007, Linus Torvalds wrote:

> So yeah, C is low-level. Yeah, you have to know how "pointers" work. And 
> yeah, it takes effort especially to get started. But once you have 
> gotten started, you realize that:
> 
>  - it may have been a lot more work to get over the hump, but once you 
>    did, you can find people who can work with you and help you.
> 
>  - yeah, you didn't really want to work with people who didn't know how a 
>    "pointer to a function returning a const pointer" really works.

Probably related to the second point:

- you do _not_ want to work with people who a scared of pointers. Most 
  such people are only scared of it, because they are not _able_ to clean 
  up after themselves. This leads _invariably_ to bad code.

For example, I have never ever seen so bad code as in Java. If you are not 
forced by the language to clean up the data structures, you tend to get 
lazy. You don't free memory (why should I? It's garbage collected anyway, 
right?), you don't close resources, you _waste_ time by using incorrect 
data-types or doing wholesale copying all the time.

Just look at Eclipse's source code. *tries not to vomit on the keyboard*

All this is a real pity, because when you see Java code by a guy who 
learnt the ropes in C, and learnt Java properly, it is just elegant and 
concise. And it gives a huge development boost, because you have so much 
infrastructure already.

> I agree that C is a really hard language for "prototyping".

That depends. I cannot do it, I am too stupid. But I saw a guy prototyping 
in assembler, using his assembler library. That was _fast_!

Oh well, I try to stop rambling for today, and do something productive 
again.

Ciao,
Dscho
