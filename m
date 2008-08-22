From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: Re: [PATCH 3/3] git-add --intent-to-add (-N)
Date: Fri, 22 Aug 2008 00:32:01 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0808220015190.11259@harper.uchicago.edu>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>
 <alpine.LNX.1.00.0808181512160.19665@iabervon.org> <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0808181628420.19665@iabervon.org> <7viqtukbec.fsf@gitster.siamese.dyndns.org>
 <7v3akykb96.fsf_-_@gitster.siamese.dyndns.org>
 <Pine.GSO.4.62.0808211608020.26161@harper.uchicago.edu>
 <Pine.GSO.4.62.0808212304200.9108@harper.uchicago.edu>
 <alpine.LNX.1.00.0808220023170.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 07:33:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWPHD-0001kS-0E
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 07:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbYHVFc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 01:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbYHVFc1
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 01:32:27 -0400
Received: from smtp02.uchicago.edu ([128.135.12.75]:56876 "EHLO
	smtp02.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbYHVFc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 01:32:27 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp02.uchicago.edu (8.13.8/8.13.8) with ESMTP id m7M5W16a006522;
	Fri, 22 Aug 2008 00:32:01 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m7M5W1Rv011702;
	Fri, 22 Aug 2008 00:32:01 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <alpine.LNX.1.00.0808220023170.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93254>

Daniel Barkalow wrote:

> On Thu, 21 Aug 2008, Jonathan Nieder wrote:
[...]
> > 	$ git add -N a
> > 	$ git commit
> > 	error: invalid object e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
> > 	error: Error building trees
> > 
> > I think the first error comes from update_one, which creates a tree
> > object from the index.  It is complaining, because after all, that
> > object is not in any sha1 file.
> 
> I think [1/3] was supposed to make this not an issue, with that particular 
> object being implicitly in all objects databases.

Wait, is [1/3] meant to create that strong of an illusion?  That is,
should has_sha1_file pretend the object is present, too?

Jonathan
