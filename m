From: "Loeliger Jon-LOELIGER" <jdl@freescale.com>
Subject: RE: clarify git clone --local --shared --reference
Date: Fri, 8 Jun 2007 08:57:31 -0700
Message-ID: <AF0367BA48C55940A43CCF08DF35553C013C76BF@az33exm24.fsl.freescale.net>
References: <4664A5FE.30208@nrlssc.navy.mil> <20070605045008.GC9513@spearce.org> <46658F98.6020001@nrlssc.navy.mil> <20070606051111.GF9513@spearce.org> <466701E0.4000108@nrlssc.navy.mil> <20070608053750.GB18521@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	"Brandon Casey" <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Jun 08 17:57:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwgqR-00036j-IT
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 17:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030670AbXFHP5n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 11:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030661AbXFHP5m
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 11:57:42 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:51046 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761755AbXFHP5l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2007 11:57:41 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id l58FvW5B009875
	for <git@vger.kernel.org>; Fri, 8 Jun 2007 08:57:32 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net [10.64.32.14])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l58FvWlK016190
	for <git@vger.kernel.org>; Fri, 8 Jun 2007 10:57:32 -0500 (CDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <20070608053750.GB18521@spearce.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: clarify git clone --local --shared --reference
Thread-Index: AcepjzGm2e0ZaomESlC/w+t2IvCnCQAVCnew
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49481>

Shawn O. Pearce wrote:
> 
> Brandon Casey <casey@nrlssc.navy.mil> wrote:
> > ok. I just want to make sure this is not really about prune'ing.
> > 
> > In the following, source and --shared repos are identical except...
> > 1) Source repo contains loose objects which are new commits.
> >    --shared repo does git-pull.
> >    we fast-forward, copying very little.
> >    success.
> 
> Copying nothing actually.  All of the objects required are in the
> source repository, so --shared needs nothing additional.

So the thing I find myself wanting to do is
A "crib from local copy".  That is, the network
Cost is large, so when cloning point to a local
(ie, already on same Filesystem) clone that is
Similar, use it as a reference, but, in the end,
Create a complete copy into the new repository.

I don't want it hard linked with --local.
I don't want it shared with --shared.
I don't want it as an altrnate source with --reference.

What I want is a new, clean, complete, unshared repository.

But for efficiency reasons, I want to grab objects
From a different, filesystem-local clone if possible.

Does that work?

jdl
