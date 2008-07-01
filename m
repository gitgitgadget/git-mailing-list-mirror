From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 3/7] Documentation: complicate example of "man
	git-command"
Date: Tue, 1 Jul 2008 12:23:58 -0400
Message-ID: <20080701162358.GA18305@fieldses.org>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu> <Pine.GSO.4.62.0806301706090.7190@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jon Loeliger <jdl@jdl.com>
To: Jonathan Nieder <jrnieder@uchicago.edu>
X-From: git-owner@vger.kernel.org Tue Jul 01 18:25:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDif9-0004oj-0C
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 18:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754678AbYGAQYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 12:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752521AbYGAQYE
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 12:24:04 -0400
Received: from mail.fieldses.org ([66.93.2.214]:33221 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753129AbYGAQYD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 12:24:03 -0400
Received: from bfields by fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1KDie6-0004vA-4X; Tue, 01 Jul 2008 12:23:58 -0400
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.62.0806301706090.7190@harper.uchicago.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87048>

On Mon, Jun 30, 2008 at 05:10:25PM -0500, Jonathan Nieder wrote:
> The manual page for the command invoked as "git clone" is named
> git-clone(1), and similarly for the rest of the git commands.
> Make sure our first example of this in tutorials makes it clear
> that it is the first two words of a command line that make up the
> command's name (that is: for example, the effect of "git svn
> dcommit" is described in git-svn(1)).

Is this confusion really common?

I can see how it might be possible in the case of a subcommand that
itself has subcommands, but it seems less likely in the two examples you
add below (where the third token is an option or a url).  I like your
"git svn" example better.  Or "git remote" might be good.

--b.

> 
> Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
> ---
> 	If I didn't make this change, consistency would mean
> 	saying "you can get documentation for a command such
> 	as `git-diff` with `man git-diff`", which might not be
> 	very enlightening.
> 
>  Documentation/gittutorial.txt |    4 ++--
>  Documentation/user-manual.txt |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
> index 3d16e3d..b833167 100644
> --- a/Documentation/gittutorial.txt
> +++ b/Documentation/gittutorial.txt
> @@ -20,10 +20,10 @@ for example, to test the latest version, you may prefer to start with
>  the first two chapters of link:user-manual.html[The Git User's Manual].
>  
>  First, note that you can get documentation for a command such as "git
> -diff" with:
> +log --graph" with:
>  
>  ------------------------------------------------
> -$ man git-diff
> +$ man git-log
>  ------------------------------------------------
>  
>  It is a good idea to introduce yourself to git with your name and
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index ca4363f..36ab372 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -18,7 +18,7 @@ People needing to do actual development will also want to read
>  Further chapters cover more specialized topics.
>  
>  Comprehensive reference documentation is available through the man
> -pages.  For a command such as "git clone", just use
> +pages.  For a command such as "git clone <repo>", just use
>  
>  ------------------------------------------------
>  $ man git-clone
> -- 
> 1.5.5.GIT
> 
> 
