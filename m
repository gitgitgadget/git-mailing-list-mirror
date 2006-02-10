From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Fri, 10 Feb 2006 16:04:01 -0500
Message-ID: <20060210210401.GA1604@spearce.org>
References: <20060210195914.GA1350@spearce.org> <20060210204143.GA18784@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 22:04:54 2006
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1F7fRl-00027F-00
	for <gcvg-git@gmane.org>; Fri, 10 Feb 2006 22:04:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWBJVEv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 16:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbWBJVEu
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 16:04:50 -0500
Received: from [64.38.20.226] ([64.38.20.226]:58319 "EHLO corvette.plexpod.net")
	by vger.kernel.org with ESMTP id S932194AbWBJVEu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2006 16:04:50 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1F7fRD-00064X-Ru; Fri, 10 Feb 2006 16:04:21 -0500
Received: by asimov.spearce.org (Postfix, from userid 1000)
	id 72DC920FBA0; Fri, 10 Feb 2006 16:04:01 -0500 (EST)
To: Greg KH <greg@kroah.com>
Mail-Followup-To: Greg KH <greg@kroah.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060210204143.GA18784@kroah.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15883>

Greg KH <greg@kroah.com> wrote:
> On Fri, Feb 10, 2006 at 02:59:14PM -0500, Shawn Pearce wrote:
> > I just posted the first public version of pg, a GIT porcelain for
> > managing patches.  Think StGIT, but better in some ways:
> > 
> > Feature Summary:
> 
> Hm, is there any way to import an existing patch into pg?

Doh!  I haven't needed to do that yet.  I'll code up a pg-import
later tonight.  But since git and pg play nice together you can
do this:

	pg-new Patch-Name
	git-apply the-patch-file.patch
	pg-ci -m"Importing the-patch-file.patch..."

or even:

	pg-new Patch-Name
	git-am mbox

and keep the 'history' stored in the mailbox.

So pg-import won't amount to a very long script.  :-|
