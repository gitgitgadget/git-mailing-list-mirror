From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: easy way to make tracking branches?
Date: Sun, 18 Jan 2009 15:37:01 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngn6j4t.9he.sitaramc@sitaramc.homelinux.net>
References: <20090118105530.GG11992@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 18 16:38:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOZjQ-0005uh-2p
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 16:38:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765565AbZARPhM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 10:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765060AbZARPhL
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 10:37:11 -0500
Received: from main.gmane.org ([80.91.229.2]:35358 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764878AbZARPhK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 10:37:10 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LOZi2-0000eQ-4A
	for git@vger.kernel.org; Sun, 18 Jan 2009 15:37:10 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Jan 2009 15:37:10 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Jan 2009 15:37:10 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106227>

On 2009-01-18, Stephan Beyer <s-beyer@gmx.net> wrote:
> Now I want to make "foo" a tracking branch for "bar".
> I do:
>
> 	git config branch.foo.remote srv
> 	git config branch.foo.merge refs/heads/bar

I just do a "git pull srv" when the tracking is *not* setup,
and git reminds me what commands to use.

> And to get a comfortable git-push, I do:
>
> 	git config --add remote.srv.push foo:bar

This one you'll just have to remember, I guess :-)

> 	git checkout -b foo2 srv/bar
> 	git branch -d foo
> 	git branch -m foo
>
> which is suboptimal because deleting foo can remove some
> other settings for the branch, e.g. mergeoptions.

it also doesn't seem to set remote.srv.push, as far as I can
tell.
