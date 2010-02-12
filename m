From: Petr Baudis <pasky@suse.cz>
Subject: Re: web-based client for Git, was Re: GSoC 2010
Date: Fri, 12 Feb 2010 13:18:44 +0100
Message-ID: <20100212121844.GK4159@machine.or.cz>
References: <fabb9a1e1002101223o6a00f7eavb84567c1119c8ebc@mail.gmail.com>
 <20100211214833.GU9553@machine.or.cz>
 <201002120502.43565.chriscool@tuxfamily.org>
 <e72faaa81002120222p19db9c75u737e2615c14930b1@mail.gmail.com>
 <e72faaa81002120226y5e4b1c28tbaf6a7dccb9634dc@mail.gmail.com>
 <alpine.DEB.1.00.1002121149470.20986@pacific.mpi-cbg.de>
 <20100212113538.GV9553@machine.or.cz>
 <e72faaa81002120355t4c8596d0q66da4aeb4cce3a94@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 13:19:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfuUQ-0001OO-WB
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 13:19:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756514Ab0BLMSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 07:18:49 -0500
Received: from w241.dkm.cz ([62.24.88.241]:46754 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756488Ab0BLMSr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 07:18:47 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id B71A886208A; Fri, 12 Feb 2010 13:18:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <e72faaa81002120355t4c8596d0q66da4aeb4cce3a94@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139693>

  Hi!

On Fri, Feb 12, 2010 at 05:25:02PM +0530, Pavan Kumar Sunkara wrote:
> sorry but my mails aren't reaching the mailing list. So it would be
> helpful if you forward this mail to the mailing list

  I'm quoting it in full here. :-)

> I would be happy to elaborate this.

  Thanks a lot!

> First of all, this is not another gitweb or gitorious.
> This is a client to use git. I mean, you could use this to work on git
> repositories. (even editing files)

  Aha, I see. Are you aware of "gist" [http://gist.github.com/]? It is
in a sense the first attempt to do this, albeit quite rudimentary in
some ways. And it's also closed-source, I'm not personally aware of an
open-source alternative, so this would certainly be useful! Actually,
I can say I would certainly like to add this functionality to repo.or.cz
for creating commits on the mob branches over the web directly.

> This program can be used in 2 ways. One, hosted in a website for many users
> and Two use it locally
> 
> It's structure will be like this:
> * When you start this program by typing gittor in terminal, A new window
> will be opened with your preferred browser
> * It will take you directly to you repositories overview whose file paths
> have been previously provided by you.
> * Now after selecting a repository, you can explore among the commits,
> diffs, blames, trees (similiar to git web)
> * But also you will have other options like
>   # Edit file: Opens a browser based syntax highlighted file editor.
>   # See status: See the status of current working repository(git status)
>   # See diff: See diffs
>   # Create and/or Change branches
>   # Add/Remove files.
>   # Show functionalities
>   # Commit with log messages
>   # Push/Pull remote repositories
>   # Garbage collection
>   # And all other major functionalities while using git on a working
> repository
> 
> So, as u see, it is a combination of gitweb and GUI client to use git.
> This opens in a internet browser, because it's easy to write GUI for
> it.(HTML)

  However, I'm a bit unsure if you aren't loading too much on yourself,
seeing how much effort it took the other projects to implement *just the
read-only parts* properly. So I still wonder why it wouldn't be better
to focus purely on the editing and commit creation, while relying on
an existing web interface to provide the history browsing, diffs, etc.

  This could be done in several ways - simply taking a client and adding
your code to provide the extra functionality there, OR creating a
standalone project that would be cross-linked with a given web
interface. The latter option is interesting since your extension could
work easily with the web interfaces of choice (and e.g. modifying gitweb
to provide the appropriate links is trivial, to a degree even possible
purely from config file).

  P.S.: I could volunteer to mentor such a project, if no more active
Git hacker shows interest. Perhaps Jakub Narebski might be interested?

-- 
				Petr "Pasky" Baudis
A great many people think they are thinking when they are merely
rearranging their prejudices. -- William James
