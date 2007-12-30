From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Force new line at end of commit message
Date: Sun, 30 Dec 2007 16:50:17 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0712301648300.14355@wbgn129.biozentrum.uni-wuerzburg.de>
References: <87ve6ub3u7.fsf@gollum.intra.norang.ca> <8763yof9lg.fsf@gollum.intra.norang.ca>
 <Pine.LNX.4.64.0712241835210.14355@wbgn129.biozentrum.uni-wuerzburg.de>
 <20071225044202.GO14735@spearce.org> <7v4pe5nt8m.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0712291426500.14355@wbgn129.biozentrum.uni-wuerzburg.de>
 <7vodc99gpy.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0712301124510.14355@wbgn129.biozentrum.uni-wuerzburg.de>
 <7v63yga20u.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0712301201570.14355@wbgn129.biozentrum.uni-wuerzburg.de>
 <7vprwo8kzd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Bernt Hansen <bernt@alumni.uwaterloo.ca>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 30 16:50:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J90R6-0006rq-0n
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 16:50:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419AbXL3PuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 10:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755983AbXL3PuV
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 10:50:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:44411 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753071AbXL3PuU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 10:50:20 -0500
Received: (qmail invoked by alias); 30 Dec 2007 15:50:18 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp046) with SMTP; 30 Dec 2007 16:50:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ycNRM4T6yADzhhKfrZoHYfSW9w/4hi8cwbp0NCV
	EyZjLEPBrd1RfN
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vprwo8kzd.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69367>

Hi,

[Bernt, your mail filter is less than intelligent and rejects my mails.]

On Sun, 30 Dec 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Not that I care too deeply, but does that not add a newline regardless 
> > whether it is needed or not?
> 
> Heh, I can see that you do not care---the original did not even
> add a newline when necessary (and that is why we have this
> thread).

Umm.  It was on purpose, since I found the empty lines between the commit 
messages and the comment more pleasing than no empty space.

> The patch just moves that unconditional "echo"; instead of adding one to 
> the end of the first commit (and only the first one), it adds before the 
> new commit's title message.

Well, ACK from me, then.

Ciao,
Dscho
