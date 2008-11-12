From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add maven distribution management info for the new
	snapshot repository
Date: Tue, 11 Nov 2008 17:01:02 -0800
Message-ID: <20081112010102.GV2932@spearce.org>
References: <4919EECB.7070408@wellfleetsoftware.com> <2c6b72b30811111337v2fe23c75v25251838f721a007@mail.gmail.com> <20081111214434.GS2932@spearce.org> <2c6b72b30811111401i3c995889n54407243a1072599@mail.gmail.com> <20081111231106.GT2932@spearce.org> <20081111234858.GA17662@diku.dk> <20081112005838.GU2932@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonas Fonseca <jonas.fonseca@gmail.com>,
	Farrukh Najmi <farrukh@wellfleetsoftware.com>,
	git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Wed Nov 12 02:02:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L047f-0005ij-Ul
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 02:02:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbYKLBBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 20:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbYKLBBE
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 20:01:04 -0500
Received: from george.spearce.org ([209.20.77.23]:50410 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbYKLBBD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 20:01:03 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id D01FA38200; Wed, 12 Nov 2008 01:01:02 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081112005838.GU2932@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100711>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Jonas Fonseca <fonseca@diku.dk> wrote:
> > +    <distributionManagement>
> > +        <snapshotRepository>
> > +            <id>jgit-maven-snapshot-repository</id>
> > +            <name>JGit Maven Snapshot Repository</name>
> > +            <url>dav:https://egit.googlecode.com/svn/maven/snapshot-repository/</url>
> 
> Shouldn't that be http:// and not https:// ?

Oh, wait, never mind me.

I guess this makes sense; https:// for the distribution upload,
but the wiki page you added uses plain http:// for download.

Patch applied.
 
-- 
Shawn.
