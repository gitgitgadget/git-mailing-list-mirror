From: Jan Hudec <bulb@ucw.cz>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 15:15:51 +0200
Message-ID: <20061021131551.GC29843@artax.karlin.mff.cuni.cz>
References: <845b6e870610190002u420118b8ud634bb9594572c48@mail.gmail.com> <46d6db660610190149x32442596we4112cdd044185a@mail.gmail.com> <45373E27.3050209@op5.se> <vpqwt6wsmb5.fsf@ecrins.imag.fr> <72877ab10610190757u3d2b4df0o204c6ffd73af69b4@mail.gmail.com> <45379A02.1010105@utoronto.ca> <72877ab10610192014o3a7f66c6v79f94f48615e08f4@mail.gmail.com> <45384B0F.4040901@utoronto.ca> <20061021123027.GB29843@artax.karlin.mff.cuni.cz> <ehd5u7$c5g$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 15:15:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbGhb-0005mW-TL
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 15:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993007AbWJUNPq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 09:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993008AbWJUNPq
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 09:15:46 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:44979 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S2993007AbWJUNPp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 09:15:45 -0400
Received: by artax.karlin.mff.cuni.cz (Postfix, from userid 17196)
	id 3AD9C48FB; Sat, 21 Oct 2006 15:15:51 +0200 (CEST)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <ehd5u7$c5g$1@sea.gmane.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29609>

On Sat, Oct 21, 2006 at 03:05:22PM +0200, Jakub Narebski wrote:
> Jan Hudec wrote:
> 
> > On Fri, Oct 20, 2006 at 12:05:35AM -0400, Aaron Bentley wrote:
> >> Tim Webster wrote:
> >> > Also svn does not allow files in the same directory to live in
> >> > multiple repos
> >> 
> >> It would surprise me if many SCMs that support atomic commit also
> >> support intermixing files from multiple repos in the same directory.
> > 
> > In fact I think svk would. You would have to switch them by setting
> > an environment variable, but it's probably doable. That is because
> > unlike other version control systems, it does not store the information
> > about checkout in the checkout, but in the central directory and that
> > can be set. I don't know git well enough to tell whether git could do
> > the same by setting GIT_DIR.
> 
> You can very simply embed one "clothed" repository into another in GIT,
> like shown below
> 
>   project/.git
>   project/subdir/
>   project/subdir/file
>   project/subproject/
>   project/subproject/.git
>   project/subproject/file
>   ...
> 
> It depends on circumstances if one wants files belonging to subdirectory
> be ignored by top repository. You would want to ignore .git/ directory,
> though.

Yes, you can do that with bzr and most other tools I know of as well.
But I understand the original question as requesting the working trees
to be rooted at the same place (ie. all in /etc), because each has some
files and some directories that have to be placed next to each other.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
