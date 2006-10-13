From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-fetch: Allow branch."branchname".remote=.
Date: Fri, 13 Oct 2006 14:53:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610131448390.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87y7rk3b9n.fsf@gmail.com> <7vpscwd4ya.fsf@assigned-by-dhcp.cox.net>
 <8aa486160610130208s67ea0746o8a54910860b3fb78@mail.gmail.com>
 <Pine.LNX.4.63.0610131324090.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <ego1ea$tsn$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?iso-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 13 14:53:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYMXj-0001vn-I4
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 14:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbWJMMxe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 08:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbWJMMxe
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 08:53:34 -0400
Received: from mail.gmx.de ([213.165.64.20]:12763 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751670AbWJMMxd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Oct 2006 08:53:33 -0400
Received: (qmail invoked by alias); 13 Oct 2006 12:53:32 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 13 Oct 2006 14:53:32 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ego1ea$tsn$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28838>

Hi,

On Fri, 13 Oct 2006, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> 
> > There is a subtle problem here. Up until now, "remote" meant a short cut. 
> > You either had a file with that name in .git/remotes/ or .git/branches, or 
> > an entry in the config (remote.<name>.url).
> 
> Not exactly. "git-pull . <branch>" and "git-peek-remote ." meant use
> _current_ repository. "." as remote name means "current", i.e. local 
> repository.

>From Documentation/git-pull.txt:

	SYNOPSIS
	--------
	'git-pull' <options> <repository> <refspec>...

It says "repository", not "remote". As for the name "git-peek-remote": 
yes, it is a short cut for "remote repository".

The thing is, if you say you pull "from a remote", then it is not 
sufficient to specify just a URL of a repository. You also have to specify 
a branch.

For git-peek-remote and git-ls-remote, you only need a URL.

If you mix the usage, people get as confused as with the terms "pull", 
"update" and "merge".

Ciao,
Dscho
