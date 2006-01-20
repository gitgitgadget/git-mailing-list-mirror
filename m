From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: StGIT: "stg new" vs "stg new --force"
Date: Fri, 20 Jan 2006 13:22:55 -0500
Message-ID: <20060120182255.GD32177@fieldses.org>
References: <1137144291.20073.104.camel@dv> <b0943d9e0601160018x206faf9ck@mail.gmail.com> <1137517300.20556.26.camel@dv> <20060117215752.GH32585@nowhere.earth> <1137539762.12454.11.camel@dv> <20060118193717.GI32585@nowhere.earth> <1137631749.13853.22.camel@dv> <20060119213838.GA27397@nowhere.earth> <1137738224.27911.26.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <ydirson@altern.org>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git <git@vger.kernel.org>, Charles Lever <cel@citi.umich.edu>
X-From: git-owner@vger.kernel.org Fri Jan 20 19:23:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F00ug-00017x-MT
	for gcvg-git@gmane.org; Fri, 20 Jan 2006 19:23:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWATSXD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jan 2006 13:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWATSXD
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jan 2006 13:23:03 -0500
Received: from mail.fieldses.org ([66.93.2.214]:62922 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1751135AbWATSXB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2006 13:23:01 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1F00uV-0001t3-IX; Fri, 20 Jan 2006 13:22:55 -0500
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1137738224.27911.26.camel@dv>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14973>

On Fri, Jan 20, 2006 at 01:23:44AM -0500, Pavel Roskin wrote:
> On Thu, 2006-01-19 at 22:38 +0100, Yann Dirson wrote:
> > That command could be "cat" to get the current "refresh" behaviour, or
> > an editor wrapper acting on stdin/out, or a wrapper to filterdiff, or
> > whatever clever filter one would want to use.
> > 
> > Does it sound better ?
> 
> Yes.  The first step would be to fix "stg refresh --edit --showpatch" to
> actually respect edits made to the patch.

I tend to use stg refresh -es as a quick (well, not quite as quick as
I'd like) way to look at the current patch.  Often I leave it up while
I'm working (editing the patched files).  So if exiting from stg refresh
-es suddenly started overwriting my working files, I'd be very
unhappy....

--b.
