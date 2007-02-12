From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Efficiency of initial clone from server
Date: Mon, 12 Feb 2007 12:45:29 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702121241130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910702111153p1691ad99nda97325b34b7a13f@mail.gmail.com>
 <20070211225326.GC31488@spearce.org> <9e4733910702111525x176053d3y9fd6d809ac447c0a@mail.gmail.com>
 <Pine.LNX.4.64.0702112022430.1757@xanadu.home> <7vd54gau3r.fsf@assigned-by-dhcp.cox.net>
 <9e4733910702112029k6ef3fb7bl3bdb134a787512e8@mail.gmail.com>
 <7v4ppsatbr.fsf@assigned-by-dhcp.cox.net> <9e4733910702112053q2c196ddcr970a062281d332b7@mail.gmail.com>
 <9e4733910702112101h256b1468j5de65c6e89109a22@mail.gmail.com>
 <7vzm7k9c3c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Smirl <jonsmirl@gmail.com>, Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 12 12:45:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGZcl-00026v-6t
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 12:45:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbXBLLpb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 06:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbXBLLpb
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 06:45:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:34998 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964873AbXBLLpb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 06:45:31 -0500
Received: (qmail invoked by alias); 12 Feb 2007 11:45:29 -0000
X-Provags-ID: V01U2FsdGVkX1/5DuMuzHH5MrMeKICmgpphpXqnQZWVnOdCJjluzA
	h1JQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vzm7k9c3c.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39395>

Hi,

On Sun, 11 Feb 2007, Junio C Hamano wrote:

> You are assuming everybody does initial clone all the time.  I do not 
> think that holds true in practice.

It depends how you interpret "all the time". What you (Junio) are 
suggesting is that the count of initial clones is relatively small as 
compared to the total number of fetches.

However, you can interpret "all the time" in terms of "time". Most fetches 
are really small. They even often end up in no objects pulled at all. 
These are cheap for the server. The initial clones take a long time. They 
are expensive.

I'd be interested to learn how much of the CPU time is actually spent in 
initial clones, rather than other types of fetches. It might make sense 
yet to optimize initial clones.

Ciao,
Dscho
