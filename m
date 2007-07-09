From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: merge-one-file, was Re: [PATCH] merge-tree: sometimes, d/f conflict
 is not an issue
Date: Mon, 9 Jul 2007 16:06:44 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707091604030.5546@racer.site>
References: <20070405071615.2915.6837.reportbug@acer>
 <20070607074357.27760.qmail@69aef7b888effd.315fe32.mid.smarden.org>
 <6b8a91420706070252y3fd581a3w427d91e5b982d29d@mail.gmail.com>
 <20070613091624.26463.qmail@353090644b4917.315fe32.mid.smarden.org>
 <Pine.LNX.4.64.0706131354250.4059@racer.site>
 <20070613134336.13661.qmail@c61f4fed932273.315fe32.mid.smarden.org>
 <Pine.LNX.4.64.0706131543140.4059@racer.site>
 <20070625071819.8091.qmail@5e4088a43a10fd.315fe32.mid.smarden.org>
 <Pine.LNX.4.64.0707080148370.4093@racer.site> <7vabu765r0.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0707080248320.4093@racer.site> <7v644v5tr3.fsf@assigned-by-dhcp.cox.net>
 <7vwsxb4e2q.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707081353560.4248@racer.site>
 <7v8x9q1x5t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org,
	=?utf-8?Q?R?= =?utf-8?Q?=C3=A9mi?= Vanicat <vanicat@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 17:14:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7uwU-00088c-RK
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 17:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbXGIPOX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 11:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753221AbXGIPOX
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 11:14:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:49287 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750929AbXGIPOW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 11:14:22 -0400
Received: (qmail invoked by alias); 09 Jul 2007 15:14:20 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp001) with SMTP; 09 Jul 2007 17:14:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19pRy4rGxhpc3gTEI7xZUWU03k79hegg5SqgdAfwU
	PCmpF5kqNr1s1U
X-X-Sender: gene099@racer.site
In-Reply-To: <7v8x9q1x5t.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52000>

Hi,

On Sun, 8 Jul 2007, Junio C Hamano wrote:

> [PATCH] Fix merge-one-file for our-side-added/our-side-removed cases

FWIW I have a patch series in my local repo, which makes merge-one-file a 
builtin, and even avoids fork()+exec()ing the program when called from 
unpack_trees().  However, I never came around to understand all the corner 
cases, and therefore did not write tests for it.  Therefore, I am not 
really sure if it works as intended.  So I'd be very grateful if you could 
write tests while you are touching it anyway...

Ciao,
Dscho
