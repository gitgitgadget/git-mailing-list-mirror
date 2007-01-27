From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/4] Teach git-describe to display distances from tags.
Date: Sat, 27 Jan 2007 13:50:51 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701271348330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <a23c4e55ca5c09f742fa2a047e45613e7797e720.1169880681.git.spearce@spearce.org>
 <20070127065413.GC10380@spearce.org> <7v4pqcluum.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jan 27 13:51:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAn1Y-0000VL-2h
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 13:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbXA0Muy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 07:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751748AbXA0Muy
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 07:50:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:56600 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751724AbXA0Mux (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 07:50:53 -0500
Received: (qmail invoked by alias); 27 Jan 2007 12:50:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 27 Jan 2007 13:50:52 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v4pqcluum.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37950>

Hi,

On Sat, 27 Jan 2007, Junio C Hamano wrote:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > The + format is much easier to read and understand than the - format 
> > original proposed by Junio.
> 
> I tend to disagree (I do not claim + is _less_ easier to read, though).
> 
> They are of comparable readability, and I think plus breaks 
> GIT-VERSION-GEN (the primary reason it replaces '-' to '.' is to work 
> around RPM limitation IIRC, and I do not know what '+' does to RPM 
> offhand).

Note that scripts using git-describe to name archives break also on 
challenged file / operating systems. IIRC on DOS/FAT32 '+' has problems 
with it.

> But I do not have a strong feeling either way.

Neither have I.

Ciao,
Dscho
