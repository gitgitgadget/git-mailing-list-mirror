From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: StGIT: "stg new" vs "stg new --force"
Date: Tue, 24 Jan 2006 12:54:43 -0500
Message-ID: <20060124175443.GA29670@fieldses.org>
References: <b0943d9e0601160018x206faf9ck@mail.gmail.com> <1137517300.20556.26.camel@dv> <20060117215752.GH32585@nowhere.earth> <1137539762.12454.11.camel@dv> <20060118193717.GI32585@nowhere.earth> <1137631749.13853.22.camel@dv> <20060119213838.GA27397@nowhere.earth> <1137738224.27911.26.camel@dv> <20060120182255.GD32177@fieldses.org> <1138080623.15105.51.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <ydirson@altern.org>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git <git@vger.kernel.org>, Charles Lever <cel@citi.umich.edu>
X-From: git-owner@vger.kernel.org Tue Jan 24 18:55:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1SNX-0007wf-2E
	for gcvg-git@gmane.org; Tue, 24 Jan 2006 18:54:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbWAXRys (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jan 2006 12:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWAXRys
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jan 2006 12:54:48 -0500
Received: from mail.fieldses.org ([66.93.2.214]:31649 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S932465AbWAXRyr
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2006 12:54:47 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1F1SNP-0007lh-70; Tue, 24 Jan 2006 12:54:43 -0500
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1138080623.15105.51.camel@dv>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15102>

On Tue, Jan 24, 2006 at 12:30:23AM -0500, Pavel Roskin wrote:
> On Fri, 2006-01-20 at 13:22 -0500, J. Bruce Fields wrote:
> > I tend to use stg refresh -es as a quick (well, not quite as quick as
> > I'd like) way to look at the current patch.  Often I leave it up while
> > I'm working (editing the patched files).  So if exiting from stg refresh
> > -es suddenly started overwriting my working files, I'd be very
> > unhappy....
> 
> If I understand correctly, "stg refresh" only modifies the repository,
> not the files in the local directory.

Well, yeah, but the reason that makes sense is that it's modifying the
repository to bring it up to date with the working directory.

> This shouldn't change.

So after you hand-edit the diff and exit "stg refresh -es", the top of
the current patch will no longer agree with the state of the working
directory.  What are you going to do on the next refresh?  Or on the
next push or pop?  This seems a little confusing.

--b.
