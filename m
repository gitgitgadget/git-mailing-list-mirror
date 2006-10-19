From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Thu, 19 Oct 2006 02:31:02 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610190229270.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061018053647.GA3507@coredump.intra.peff.net>
 <Pine.LNX.4.64.0610180739230.3962@g5.osdl.org> <20061018185225.GU20017@pasky.or.cz>
 <20061018185907.GV20017@pasky.or.cz> <7vy7rd1m4q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610181510510.1971@xanadu.home> <20061018191834.GA18829@spearce.org>
 <Pine.LNX.4.64.0610181525410.1971@xanadu.home> <20061018204626.GA19194@spearce.org>
 <Pine.LNX.4.64.0610181358200.3962@g5.osdl.org> <20061018214143.GF19194@spearce.org>
 <7vwt6xxofi.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610181542160.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610181910440.1971@xanadu.home> <Pine.LNX.4.64.0610181655430.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 02:31:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaLod-0006Z3-Ma
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 02:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945922AbWJSAbH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 20:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945924AbWJSAbH
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 20:31:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:6347 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1945922AbWJSAbF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 20:31:05 -0400
Received: (qmail invoked by alias); 19 Oct 2006 00:31:03 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 19 Oct 2006 02:31:03 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610181655430.3962@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29308>

Hi,

On Wed, 18 Oct 2006, Linus Torvalds wrote:

> The silly thing is, the pack-file contains the number of entries in the 
> header.

You do not write this to stdout, right? Why not just come back and correct 
the number of objects? Of course, the SHA1 has to be calculated _after_ 
that.

Ciao,
Dscho
