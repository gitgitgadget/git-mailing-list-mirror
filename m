From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Add `struct object_hash`
Date: Sun, 18 Feb 2007 12:43:06 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702181241090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702171838150.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vtzxjj24j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Mike Coleman <tutufan@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 18 12:43:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIkRk-0005YC-Ai
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 12:43:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbXBRLnJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 06:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbXBRLnI
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 06:43:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:53775 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750740AbXBRLnH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 06:43:07 -0500
Received: (qmail invoked by alias); 18 Feb 2007 11:43:06 -0000
X-Provags-ID: V01U2FsdGVkX19wYl14scVwBhaUcVKpiV+/r6F2VGaNCDffkqQDXH
	aeVQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vtzxjj24j.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40073>

Hi,

On Sun, 18 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Using object_hash, you can store interesting information about
> > objects in a private hash map. This makes up for the lack of a
> > `util` member of `struct object`.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >
> > 	We should have done that earlier. Now, git.git already
> > 	contains two specialised versions of an object hash map:
> > 	obj_hash and refs_hash.
> >
> > 	obj_hash is not really a hash map, but rather a hash set,
> > 	but there is no excuse for refs_hash having its own little
> > 	private implementation nobody else can reuse.
> 
> Ok, having now looked at it more, I can say:
> 
>  - I hate it.
> 
> I dislike it intensely, because it's so _close_ to being usable.

Seeing your patch I know why. I could not think of a sane method to 
condense the two pointers into one. Thank you for pointing out one.

I have not had a close look at it, that will have to wait for tomorrow.

Ciao,
Dscho
