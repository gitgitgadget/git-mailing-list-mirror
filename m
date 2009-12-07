From: Greg Price <price@ksplice.com>
Subject: Re: Unapplied patches reminder
Date: Sun, 6 Dec 2009 22:03:59 -0500
Message-ID: <20091207030359.GK30538@dr-wily.mit.edu>
References: <7voco4gtxd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geoffrey Thomas <geofft@mit.edu>, git@vger.kernel.org,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 04:04:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHTti-0001nD-O4
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 04:04:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934461AbZLGDEC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 22:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934457AbZLGDEB
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 22:04:01 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:52457 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934455AbZLGDEA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Dec 2009 22:04:00 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id nB733Wp1018020;
	Sun, 6 Dec 2009 22:03:32 -0500 (EST)
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id nB7348nB008160;
	Sun, 6 Dec 2009 22:04:08 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7voco4gtxd.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134707>

Junio wrote:
> > From: Geoffrey Thomas <geofft@mit.edu>
> > Subject: [PATCH] diffcore-order: Default the order file to .git/info/order.
> > Date: Sat, 12 Sep 2009 19:49:48 -0400
> > Message-ID: <1252799388-16295-1-git-send-email-geofft@mit.edu>
> >
> >     Since order files tend to be useful for all operations in the
> >     project/repository, add a default location for the order file, so that
> >     you don't have to specify -O<orderfile> on every diff or similar
> >     operation.
>
> Except that "$GIT_DIR/info/order" is a bit too generic a name ("eh,
> 'order'?  Order of what?"), I do not think this will hurt, as no existing
> repositories would have such a file that would cause any behaviour change
> to existing users.  The reason I did not queue it was because there wasn't
> any discussion on it (not even the filename being too generic) which was
> an indication that not many people are interested in such a feature.
>
> That of course can be remedied by interested people speaking out.

I never use the -O option, but if this feature were available I think
I would use it.  It would make it possible to configure a helpful
order once -- for example, putting a changelog file first in order to
compare it with the commit message -- and then always use it without
effort.

A less generic name might be 'difforder'.

Greg
