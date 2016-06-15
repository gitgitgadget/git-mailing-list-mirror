From: Gerrit Pape <pape@smarden.org>
Subject: Re: unexpected git-cherry-pick conflict
Date: Mon, 25 Jun 2007 07:18:19 +0000
Message-ID: <20070625071819.8091.qmail@5e4088a43a10fd.315fe32.mid.smarden.org>
References: <20070405071615.2915.6837.reportbug@acer> <20070607074357.27760.qmail@69aef7b888effd.315fe32.mid.smarden.org> <6b8a91420706070252y3fd581a3w427d91e5b982d29d@mail.gmail.com> <20070613091624.26463.qmail@353090644b4917.315fe32.mid.smarden.org> <Pine.LNX.4.64.0706131354250.4059@racer.site> <20070613134336.13661.qmail@c61f4fed932273.315fe32.mid.smarden.org> <Pine.LNX.4.64.0706131543140.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 25 09:27:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2iyv-0001Va-Qu
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 09:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbXFYH11 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 03:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752156AbXFYH10
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 03:27:26 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:39372 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751698AbXFYH1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 03:27:25 -0400
Received: (qmail 8092 invoked by uid 1000); 25 Jun 2007 07:18:19 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0706131543140.4059@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50871>

On Wed, Jun 13, 2007 at 03:43:48PM +0100, Johannes Schindelin wrote:
> On Wed, 13 Jun 2007, Gerrit Pape wrote:
> > On Wed, Jun 13, 2007 at 01:58:51PM +0100, Johannes Schindelin wrote:
> > > On Wed, 13 Jun 2007, Gerrit Pape wrote:
> > > >  $ git checkout master
> > > >  Switched to branch "master"
> > > >  $ git cherry-pick 8ddc4d5
> > > >  CONFLICT (file/directory): There is a directory with name link in
> > > >  8ddc4d5... file. Added link as link~HEAD
> > > 
> > > Here you _still_ have the file in master. So that conflict is really 
> > > expected, since a cherry-pick will only do a three-way merge.
> > 
> > git-cherry-pick(1) states
> >  Given one existing commit, apply the change the patch introduces, and
> >  record a new commit that records it. This requires your working tree to
> >  be clean (no modifications from the HEAD commit).
> > 
> > The patch introduced by the commit that's cherry-pick'ed has nothing to
> > do with the link or new directory, it just changes 'file'
> > 
> >  $ git show 8ddc4d5
> >  commit 8ddc4d59444a362261e10a3b22324818f5dd2fa7
> >  Author: Gerrit Pape <pape@smarden.org>
> >  Date:   Wed Jun 13 09:10:30 2007 +0000
> >  
> >      file
> >  
> >  diff --git a/file b/file
> >  index 257cc56..3bd1f0e 100644
> >  --- a/file
> >  +++ b/file
> >  @@ -1 +1,2 @@
> >   foo
> >  +bar
> >  $ 
> > 
> > The patch applies to master just fine.  Where's my thinking wrong?
> 
> Hmm. Indeed. Thanks for clearing that up. Will work on it later.

Hi, did you get to this yet?, not to stress you, just to make sure we
don't forget about it.

Thanks, Gerrit.
