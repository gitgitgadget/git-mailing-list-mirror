From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: using the same repo with different OS
Date: Sun, 25 Feb 2007 18:34:14 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702251829530.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <906f26060702250913g41658be6mffea613f25f9a847@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Stefano Spinucci <virgo977virgo@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 25 18:34:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLNGM-0005LS-Kj
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 18:34:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbXBYReQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 12:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbXBYReQ
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 12:34:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:40615 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965026AbXBYReP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 12:34:15 -0500
Received: (qmail invoked by alias); 25 Feb 2007 17:34:14 -0000
X-Provags-ID: V01U2FsdGVkX18zNExk7SEz0ONRQOhjt38wpJAh9cxfyCOu5yMkPA
	YR6Q==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <906f26060702250913g41658be6mffea613f25f9a847@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40558>

Hi,

On Sun, 25 Feb 2007, Stefano Spinucci wrote:

> I have my repos on a USB key (fat32 fs) and I work with git under
> linux and windows (maybe also Solaris in the future).
> 
> Considering also the new MinGW port, should I use a different repo for 
> every OS I work with???

You don't need to. But remember that the stat informations are likely to 
be borked. For example, when you do a "git-status" on a sizable working 
tree on that stick, it will take a long, long time whenever you switch 
OSes. Basically the same amount of time as if git did not have an index!

> Are planned/expected OS-specific files in the repo preventing me to use 
> the same whenever I'm working???

It could be possible that the index is saved in a slightly different 
format, due to different alignment strategies. Maybe 64-bit vs 32-bit has 
differences there. I have no idea.

Ciao,
Dscho
