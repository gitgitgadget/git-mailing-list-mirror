From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 5/5] git-add: add ignored files when asked explicitly.
Date: Mon, 25 Dec 2006 14:57:22 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612251454040.18171@xanadu.home>
References: <7vbqlskz2u.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612251443230.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vslf3khsc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 25 20:57:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gyvwy-00038u-Vf
	for gcvg-git@gmane.org; Mon, 25 Dec 2006 20:57:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbWLYT5X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Dec 2006 14:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbWLYT5X
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Dec 2006 14:57:23 -0500
Received: from relais.videotron.ca ([24.201.245.36]:65407 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736AbWLYT5X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Dec 2006 14:57:23 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JAU00CNXI3MB900@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 25 Dec 2006 14:57:22 -0500 (EST)
In-reply-to: <7vslf3khsc.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35394>

On Mon, 25 Dec 2006, Junio C Hamano wrote:

> An alternative is to use the mechanism I added here to _detect_
> the attempt to add an ignored file with explicitly spelled out
> pathspec, and issue an info message that says something like:
> 
> 	Path 'xyzzy/filfre.o' is not being ignored by one of
> 	your .gitignore files.  If you really want to add it,
> 	please add this entry to .gitignore file:
> 
>         !/xyzzy/filfre.o

What about this instead:

	Path 'xyzzy/filfre.o' should be ignored according to one of
	your .gitignore files.  If you really want to add it, you must
	use the -f flag.


Nicolas
