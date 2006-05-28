From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [SCRIPT] chomp: trim trailing whitespace
Date: Sun, 28 May 2006 12:00:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605281157330.1862@wbgn013.biozentrum.uni-wuerzburg.de>
References: <4477B905.9090806@garzik.org> <46a038f90605270828u7842ea48hda07331388694db2@mail.gmail.com>
 <Pine.LNX.4.64.0605270905190.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 28 12:00:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkI4I-00057Q-0W
	for gcvg-git@gmane.org; Sun, 28 May 2006 12:00:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWE1KAI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 06:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWE1KAI
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 06:00:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:23983 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750704AbWE1KAH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 May 2006 06:00:07 -0400
Received: (qmail invoked by alias); 28 May 2006 10:00:06 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp034) with SMTP; 28 May 2006 12:00:06 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605270905190.5623@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20877>

Hi,

On Sat, 27 May 2006, Linus Torvalds wrote:

> Well, git-stripspace actually does something slightly differently, in that 
> it also removes extraneous all-whitespace lines from the beginning, the 
> end, and the middle (in the middle, the rule is: two or more empty lines 
> are collapsed into one).
> 
> Ie it's a total hack for parsing just commit messages (and it is in C, 
> because I can personally write 25 lines of C in about a millionth of the 
> time I can write 3 lines of perl).

But there is no good reason not to add some code and a command line 
switch, so that this tool with a very generic name actually performs what 
a normal person would expect from that name.

Ciao,
Dscho
