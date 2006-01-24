From: Pavel Roskin <proski@gnu.org>
Subject: Re: StGIT: "stg new" vs "stg new --force"
Date: Tue, 24 Jan 2006 13:17:51 -0500
Message-ID: <1138126671.24415.28.camel@dv>
References: <b0943d9e0601160018x206faf9ck@mail.gmail.com>
	 <1137517300.20556.26.camel@dv> <20060117215752.GH32585@nowhere.earth>
	 <1137539762.12454.11.camel@dv> <20060118193717.GI32585@nowhere.earth>
	 <1137631749.13853.22.camel@dv> <20060119213838.GA27397@nowhere.earth>
	 <1137738224.27911.26.camel@dv> <20060120182255.GD32177@fieldses.org>
	 <1138080623.15105.51.camel@dv>  <20060124175443.GA29670@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Yann Dirson <ydirson@altern.org>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git <git@vger.kernel.org>, Charles Lever <cel@citi.umich.edu>
X-From: git-owner@vger.kernel.org Tue Jan 24 19:18:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1Sk6-0005Ek-F1
	for gcvg-git@gmane.org; Tue, 24 Jan 2006 19:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbWAXSSA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jan 2006 13:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbWAXSSA
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jan 2006 13:18:00 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:55225 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932481AbWAXSR7
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2006 13:17:59 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1F1Sjo-0004jp-BL
	for git@vger.kernel.org; Tue, 24 Jan 2006 13:17:52 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1F1Sjo-0002PN-6o; Tue, 24 Jan 2006 13:17:52 -0500
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20060124175443.GA29670@fieldses.org>
X-Mailer: Evolution 2.5.4 (2.5.4-10) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15104>

On Tue, 2006-01-24 at 12:54 -0500, J. Bruce Fields wrote:
> On Tue, Jan 24, 2006 at 12:30:23AM -0500, Pavel Roskin wrote:
> > On Fri, 2006-01-20 at 13:22 -0500, J. Bruce Fields wrote:
> > > I tend to use stg refresh -es as a quick (well, not quite as quick as
> > > I'd like) way to look at the current patch.  Often I leave it up while
> > > I'm working (editing the patched files).  So if exiting from stg refresh
> > > -es suddenly started overwriting my working files, I'd be very
> > > unhappy....
> > 
> > If I understand correctly, "stg refresh" only modifies the repository,
> > not the files in the local directory.
> 
> Well, yeah, but the reason that makes sense is that it's modifying the
> repository to bring it up to date with the working directory.

Yes.  As it stands now, the update is made using the local state after
editing.  If the patch becomes editable, the update will use the local
state before editing.  It would still fit the original semantic as you
described it.

> > This shouldn't change.
> 
> So after you hand-edit the diff and exit "stg refresh -es", the top of
> the current patch will no longer agree with the state of the working
> directory.  What are you going to do on the next refresh?

Put remaining changes to the repository.

>   Or on the
> next push or pop?

Right now - protest loudly about local changes.  In the future - proceed
cautiously if there are no conflicts.

>  This seems a little confusing.

Try removing the whole repository while "stg refresh" is running.  THAT
would be confusing :-)

Seriously, it would be nice to have an editor that would allow to edit
the patch and see the resulting file and vice versa.  Maybe emacs could
be hacked to do it.

-- 
Regards,
Pavel Roskin
