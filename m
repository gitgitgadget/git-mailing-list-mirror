From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] diff --stat: sometimes use non-linear scaling.
Date: Wed, 27 Sep 2006 09:36:51 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609270929590.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vfyeejakq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Linus Torvalds <torvalds@osdl.org>,
	Adrian Bunk <bunk@stusta.de>
X-From: git-owner@vger.kernel.org Wed Sep 27 09:37:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSTyX-0001Xu-2N
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 09:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965428AbWI0Hgz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 03:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965429AbWI0Hgz
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 03:36:55 -0400
Received: from mail.gmx.de ([213.165.64.20]:32202 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965428AbWI0Hgx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Sep 2006 03:36:53 -0400
Received: (qmail invoked by alias); 27 Sep 2006 07:36:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 27 Sep 2006 09:36:52 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyeejakq.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27886>

Hi,

On Tue, 26 Sep 2006, Junio C Hamano wrote:

> When some files have big changes and others are touched only
> slightly, diffstat graph did not show differences among smaller
> changes that well.  This changes the graph scaling to non-linear
> algorithm in such a case.

I want to say something about the purpose of the patch, not some totally 
unimportant superficialities.

In your example, a three line change has more than three plusses, and I 
find that wrong.

But I would actually find another change very useful: still linear, but 
such that if lines were added, at least one plus should be shown, and 
likewise with minus. (Often I ask myself, was this file removed, or just 
dramatically reduced, when I only see minusses).

Ciao,
Dscho
