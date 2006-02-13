From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Fix object re-hashing
Date: Mon, 13 Feb 2006 01:31:23 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602130130360.22638@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0602120956130.3691@g5.osdl.org>
 <Pine.LNX.4.64.0602121006360.3691@g5.osdl.org> <7vaccwbf6v.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602121037460.3691@g5.osdl.org> <Pine.LNX.4.64.0602121101040.3691@g5.osdl.org>
 <Pine.LNX.4.63.0602130007320.9507@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0602121614340.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 13 01:31:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8Rcw-0008M7-PW
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 01:31:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWBMAb2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 19:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbWBMAb2
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 19:31:28 -0500
Received: from mail.gmx.de ([213.165.64.21]:45759 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751101AbWBMAb2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Feb 2006 19:31:28 -0500
Received: (qmail invoked by alias); 13 Feb 2006 00:31:26 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp037) with SMTP; 13 Feb 2006 01:31:26 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602121614340.3691@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16032>

Hi,

On Sun, 12 Feb 2006, Linus Torvalds wrote:

> On Mon, 13 Feb 2006, Johannes Schindelin wrote:
> > 
> > Make hashtable resizing more robust AKA do not resize in-place
> 
> You forgot to release the old array afterwards.

D'oh! I am going to bed now.

> Anyway, I think the in-place version is fine now, even if it has a few 
> subtleties. So this isn't needed, but keep it in mind if we find another 
> bug, or if somebody wants to shrink the hash table less aggressively than 
> with doubling it every time.

Sounds fine to me.

Good night,
Dscho
