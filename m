From: Nicolas Pitre <nico@cam.org>
Subject: Re: Efficiency of initial clone from server
Date: Sun, 11 Feb 2007 20:38:09 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702112022430.1757@xanadu.home>
References: <9e4733910702111153p1691ad99nda97325b34b7a13f@mail.gmail.com>
 <20070211225326.GC31488@spearce.org>
 <9e4733910702111525x176053d3y9fd6d809ac447c0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 12 02:38:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGQ97-0001Hm-H8
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 02:38:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932825AbXBLBiM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 20:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932929AbXBLBiM
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 20:38:12 -0500
Received: from relais.videotron.ca ([24.201.245.36]:42950 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932825AbXBLBiL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 20:38:11 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDB00F2ATVL5KO0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 11 Feb 2007 20:38:09 -0500 (EST)
In-reply-to: <9e4733910702111525x176053d3y9fd6d809ac447c0a@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39348>

On Sun, 11 Feb 2007, Jon Smirl wrote:

> On 2/11/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> > Jon Smirl <jonsmirl@gmail.com> wrote:
> > > remote: Total 63, written 63 (delta 0), reused 63 (delta 0)
> > > 100% (63/63) done
> > > fatal: pack: not a valid SHA1
> > > New branch: 0953670fbcb75e26fb93340bddae934e85618f2e
> >
> > What version of git is this?  That looks like we're assuming the word
> > pack was an object, but I'm not sure why we would do such a thing...

This "pack" comes from pack-index when providing the name of the pack.
It is either "pack" or "keep" and specifies the name of the .keep file 
to remove in the later case.
This is caught by git-fetch.sh with some code identified with a comment 
that reads: "# special line coming from index-pack with the pack name"

> jonsmirl@jonsmirl:/usr/local/bin$ git --version
> git version 1.5.0.rc2.g53551-dirty

You must have conflicting vintage of GIT installations on your machine 
with missing support for the "pack" and "keep" stuff described above.


Nicolas
