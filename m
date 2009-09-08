From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCHv5 00/14] git notes
Date: Tue, 8 Sep 2009 14:39:44 -0700
Message-ID: <20090908213944.GX1033@spearce.org>
References: <1252376822-6138-1-git-send-email-johan@herland.net> <200909080512.34634.johan@herland.net> <7vd462qdeg.fsf@alter.siamese.dyndns.org> <200909081054.02523.johan@herland.net> <alpine.DEB.1.00.0909081100020.4330@intel-tinevez-2-302> <7vocplxjov.fsf@alter.siamese.dyndns.org> <20090908211046.GV1033@spearce.org> <fabb9a1e0909081436x72c71b0bv51d8f198cd82f289@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 23:40:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml8Q0-0008TY-F2
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 23:40:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376AbZIHVjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 17:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752360AbZIHVjn
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 17:39:43 -0400
Received: from george.spearce.org ([209.20.77.23]:52497 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358AbZIHVjm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 17:39:42 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1571D3815E; Tue,  8 Sep 2009 21:39:45 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <fabb9a1e0909081436x72c71b0bv51d8f198cd82f289@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128040>

Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Tue, Sep 8, 2009 at 23:10, Shawn O. Pearce<spearce@spearce.org> wrote:
> > So most commits (66%) would have only 1 version (and 1 note)
> > related to them in the note tree, but if I use the same note tree
> > for final commits as individual revisions considered, at least 18%
> > of the commits in the final history of the project would actually
> > have two notes, and 7.5% would have 3 notes.
> 
> You could however store all that information in one note, yes? Since
> the 'latest version' is the one committed, you can include the notes
> for all the previous ones at commit time?

Uh, but the natural way to index those is by commit, and each
different revision of a change is a different commit.  Why delete
the prior revision information and move it to the final commit note?
Someone who has the prior revisions in their reflog and is doing
`git log -g --notes` might want to see that annotation.

-- 
Shawn.
