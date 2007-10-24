From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: UI and git-completion.sh
Date: Wed, 24 Oct 2007 11:20:07 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710241113190.25221@racer.site>
References: <20071023234617.45a4fc64@paolo-desktop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 12:21:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkdMA-0000pe-1w
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 12:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753670AbXJXKUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 06:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753655AbXJXKUg
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 06:20:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:52698 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752218AbXJXKUg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 06:20:36 -0400
Received: (qmail invoked by alias); 24 Oct 2007 10:20:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp058) with SMTP; 24 Oct 2007 12:20:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+QfGtRefyQrAp9CgpM47D4Y3LAqVbG0gjT40/sCN
	HAA/m+61zoWvqp
X-X-Sender: gene099@racer.site
In-Reply-To: <20071023234617.45a4fc64@paolo-desktop>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62204>

Hi,

On Tue, 23 Oct 2007, Paolo Ciarrocchi wrote:

> Using the git-completation script it all boils down to 48 commands.
> 
> paolo@paolo-desktop:~/git$ git 
> add                   fetch                 rebase 
> am                    filter-branch         rebase--interactive 
> annotate              format-patch          relink 
> apply                 fsck                  remote 
> archive               gc                    repack 
> bisect                get-tar-commit-id     request-pull 
> blame                 grep                  reset 
> branch                gui                   resolve 
> bundle                imap-send             revert 
> checkout              init                  rm 
> checkout-index        instaweb              send-email 
> cherry                log                   shortlog 
> cherry-pick           lost-found            show 
> citool                ls-files              show-branch 
> clean                 ls-remote             show-ref 
> clone                 ls-tree               stash 
> commit                merge                 status 
> config                mergetool             submodule 
> convert-objects       mv                    tag 
> count-objects         name-rev              var 
> describe              pickaxe               verify-pack 
> diff                  pull                  whatchanged 
> diff-stages           push

diff-stages just struck my eye.  It is no longer in git...  But AFAICS it 
is no longer in git-completion.bash either.

Besides, I think that the number of commands could be reduced further.  
For example, I think that a regular user does not want to see

checkout-index, citool, convert-objects, filter-branch, get-tar-commit-id, 
imap-send, instaweb, lost-found, ls-tree, name-rev, rebase--interactive, 
relink, repack, request-pull, show-ref, var, verify-pack and whatchanged.

This list was not vs the quoted list, but my current list (pretty much tip 
of Shawn's "next".

Note: I would like to complete the _options_ when one of these subcommands 
was specified, but I just do not want to see them when entering 
"git<SPACE><TAB>".

BTW Pierre's idea of generating many (if not all) of these completions on 
the fly (maybe with "--help-completion"?) is intriguing.

Ciao,
Dscho
