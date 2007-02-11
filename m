From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: 'git status' is not read-only fs friendly
Date: Sun, 11 Feb 2007 23:28:52 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702112325310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
 <Pine.LNX.4.63.0702101517360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <e5bfff550702100631w1b6243e7i44039ceaa8d3fe93@mail.gmail.com>
 <Pine.LNX.4.63.0702101536090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <e5bfff550702100648p6db5fc67vb5e4a04d40771922@mail.gmail.com>
 <e5bfff550702100651j244e5a2flf02fb91dc71799b3@mail.gmail.com>
 <7v1wkykmj1.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702102135080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vbqk0cq7i.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702112305580.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Costalba <mcostalba@gmail.com>,
	GIT list <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 11 23:28:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGNBp-0003F5-QB
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 23:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbXBKW2z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 17:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932595AbXBKW2z
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 17:28:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:34774 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932594AbXBKW2y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 17:28:54 -0500
Received: (qmail invoked by alias); 11 Feb 2007 22:28:53 -0000
X-Provags-ID: V01U2FsdGVkX191+0hoiEB1f7auQeURaegLuqWVgh8XgNb9ca+YTx
	2KPA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.63.0702112305580.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39316>

On Sun, 11 Feb 2007, Johannes Schindelin wrote:

> On Sun, 11 Feb 2007, Junio C Hamano wrote:
> 
> > If NTFS driver in the Linux kernel is filling that [lstat information 
> > which Windows does not provide] with zeroes the same way then there 
> > won't be differences, right?
> 
> Maybe. Although I am quite certain that you'd break something by that.

Clarification: I am not a filesystem programmer, and as such do not know 
about this issue as much as I would like. But I am quite confident that 
inodes are an important tool to provide performance. Or something else.

Anyway, I think it is rarely advisable to imitate MS Windows, and as I 
made clean, Marco's particular situation does not seem relevant to me.

Ciao,
Dscho 
