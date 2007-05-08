From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How to set git commit timestamp
Date: Tue, 8 May 2007 13:29:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705081328420.4167@racer.site>
References: <Pine.LNX.4.64.0705061759210.8165@bianca.dialin.t-online.de>
 <200705062151.40261.robin.rosenberg.lists@dewire.com> <20070508013833.GB11311@spearce.org>
 <f1ol0d$tcd$1@sea.gmane.org> <20070508015702.GE11311@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 08 13:29:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlNsj-0005Wf-Bk
	for gcvg-git@gmane.org; Tue, 08 May 2007 13:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934516AbXEHL3O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 07:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934519AbXEHL3O
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 07:29:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:39357 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934516AbXEHL3N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 07:29:13 -0400
Received: (qmail invoked by alias); 08 May 2007 11:29:12 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp051) with SMTP; 08 May 2007 13:29:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18599Fohzg5/3wycDuU9Ga4MS4PsxH7Qy+d/qFm9f
	4VD/ZGn+skRfI/
X-X-Sender: gene099@racer.site
In-Reply-To: <20070508015702.GE11311@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46568>

Hi,

On Mon, 7 May 2007, Shawn O. Pearce wrote:

> Jakub Narebski <jnareb@gmail.com> wrote:
> > By the way, is there fast-import version of git-quiltimport?
> 
> No, and I don't think its easy.  Isn't a quilt patchstack stored as a 
> series of patch files?  So "importing" it into Git requires applying the 
> patch to the base tree, then writing that base tree to the ODB.  
> fast-import doesn't know how to run git-apply, though Junio and I did 
> kick it around (generally) a few months ago on #git.

You'd have to pretend that all of these patches are branches. Well, in the 
end they are...

Ciao,
Dscho
