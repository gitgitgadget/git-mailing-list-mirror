From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Understanding version 4 packs
Date: Tue, 27 Mar 2007 02:55:31 -0400
Message-ID: <20070327065531.GN13247@spearce.org>
References: <20070324202356.GA20734@bohr.gbar.dtu.dk> <alpine.LFD.0.83.0703241913110.18328@xanadu.home> <20070325083530.GA25523@bohr.gbar.dtu.dk> <20070325091806.GH25863@spearce.org> <e5bfff550703260516q5da5f46et8aab2ebadcd9cceb@mail.gmail.com> <alpine.LFD.0.83.0703261015110.3041@xanadu.home> <e5bfff550703261010u67aa1207j1c6f0200bb7744a@mail.gmail.com> <alpine.LFD.0.83.0703261417520.3041@xanadu.home> <e5bfff550703262346q54853791scca3bab217a043aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Peter Eriksen <s022018@student.dtu.dk>, git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 08:55:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW5au-0001OO-Kv
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 08:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185AbXC0Gzp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 02:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753162AbXC0Gzp
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 02:55:45 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59681 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185AbXC0Gzo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 02:55:44 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HW5ah-0000Uf-2I; Tue, 27 Mar 2007 02:55:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 001D120FBAE; Tue, 27 Mar 2007 02:55:31 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <e5bfff550703262346q54853791scca3bab217a043aa@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43235>

Marco Costalba <mcostalba@gmail.com> wrote:
> On 3/26/07, Nicolas Pitre <nico@cam.org> wrote:
> >Hence, the path component table would contain:
> >
> >        drivers
> >        usb
> >        host
> >        Kconfig
> >        Makefile
> >        ehci.h
> >        ehci-pci.c
> >        ohci-pci.c
> >        sched.c
> >
> >along with the mode bits for each of those path components, and this is
> >what the new tree object would index into for each tree record.
> 
> Just a question. So getting full paths does it requires some additional 
> work?

No.

Why?  Because Git already makes the full path by taking individual
path components from each tree object and joins them together
(adding a "/" between each component) before displaying it to an
application, or loading the path into the index file.  This is
because of the fundemental (and quite nice!) structure of a tree.

-- 
Shawn.
