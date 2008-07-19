From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] Support gitlinks in fast-import/export.
Date: Sat, 19 Jul 2008 03:22:16 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807190321040.3064@eeepc-johanness>
References: <200807182103.37272.angavrilov@gmail.com> <20080718204338.GB27528@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alexander Gavrilov <angavrilov@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jul 19 03:22:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KK19Z-0005fv-RW
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 03:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753629AbYGSBVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 21:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754144AbYGSBVb
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 21:21:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:34954 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753554AbYGSBVa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 21:21:30 -0400
Received: (qmail invoked by alias); 19 Jul 2008 01:21:28 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp015) with SMTP; 19 Jul 2008 03:21:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/LFVJJVyjL3dC7MD4YPvm/19wmu4kmgJgAQlM2LN
	9W0W13r5YUcL62
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080718204338.GB27528@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89096>

Hi,

On Fri, 18 Jul 2008, Shawn O. Pearce wrote:

> Alexander Gavrilov <angavrilov@gmail.com> wrote:
> 
> > 	I noticed that fast-export & fast-import cannot work with 
> > 	repositories using submodules: import complains about an invalid 
> > 	mode, and export fails while trying to open the SHA as a blob.
> > 
> > 	As I didn't see any particular reason for it to be so, I tried to 
> > 	implement support for gitlinks.
> > 
> > 	What I'm unsure of is, should fast-export try to reuse commit 
> > 	marks for gitlinks where it happened to recognize the object, or 
> > 	always output the SHA as it is stored in the tree?
> 
> Its unlikely that the commit objects are in the repository the export is 
> running in, so its unlikely you can use a mark.  Its fine to just always 
> output the SHA-1 I think.

Oh, I just realized that fast-import expects changes, instead of full 
snapshots.

So strike all my suggestions regarding gitlink marks.

Sorry,
Dscho
