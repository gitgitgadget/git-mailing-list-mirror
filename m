From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Fri, 19 Oct 2007 11:03:00 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710191058570.19446@xanadu.home>
References: <20071019062219.GA28499@coredump.intra.peff.net>
 <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com>
 <20071019073938.GN14735@spearce.org>
 <8aa486160710190303l4ce996daqf5c8025c857ea8@mail.gmail.com>
 <20071019113822.GB16726@thunk.org>
 <20071019143844.GB23765@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_3CMZVC1aqzd3F6gJvxiNdw)"
Cc: Theodore Tso <tytso@thunk.org>,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Symonds <dsymonds@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: =?ISO-8859-15?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 17:03:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IitNn-00074M-4I
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 17:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932856AbXJSPDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 11:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756409AbXJSPDO
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 11:03:14 -0400
Received: from relais.videotron.ca ([24.201.245.36]:51029 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755930AbXJSPDN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 11:03:13 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQ500DJYZ50Z4I0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 19 Oct 2007 11:03:02 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071019143844.GB23765@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61726>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_3CMZVC1aqzd3F6gJvxiNdw)
Content-type: TEXT/PLAIN; charset=iso-8859-1
Content-transfer-encoding: 8BIT

On Fri, 19 Oct 2007, Karl Hasselström wrote:

> On 2007-10-19 07:38:22 -0400, Theodore Tso wrote:
> 
> > Finally, one last question --- am I the only one who had to take a
> > second look at the whether the arrow should be <- or ->? The
> > question is whether we are saying "gitk is moving to include all of
> > spearce/gitk"; but I could also see it stated that we are assigning
> > refs/heads/gitk with refs/remotes/spearce/gitk, in which case the
> > arrow should be reversed. Or maybe:
> >
> > ==> git://repo.or.cz/git/spearce.git
> >  * branch gitk := spearce/gitk                (new)
> >  * branch maint := spearce/maint              1aa3d01..e7187e4
> >  * branch master := spearce/master            de61e42..7840ce6
> >  * branch next := spearce/next                895be02..2fe5433
> >  + branch pu := spearce/pu                    89fa332...1e4c517
> >  * branch todo := spearce/todo                (new)
> 
> I think the reasoning behind the "foo -> spearce/foo" syntax is that
> "(refs/heads/)foo" in the remote repository has been fetched to
> "(refs/remotes/)spearce/foo" in the local repository.

Well, the important thing is that the _content_ is moving from the 
remote repository to the local one.  That's how the arrow should be 
interpreted conceptually.  The fact that technically we end up assigning 
the local ref with the remote value is a technical issue.


Nicolas

--Boundary_(ID_3CMZVC1aqzd3F6gJvxiNdw)--
