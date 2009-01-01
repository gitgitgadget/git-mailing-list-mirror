From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: shallow clone, shallow fetch?
Date: Thu, 1 Jan 2009 09:25:13 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrnglp2vp.4qn.sitaramc@sitaramc.homelinux.net>
References: <87vdt24zz4.fsf@jidanni.org> <877i5fohwr.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 01 10:26:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIJpL-0000tS-2s
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 10:26:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755564AbZAAJZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 04:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755434AbZAAJZ3
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 04:25:29 -0500
Received: from main.gmane.org ([80.91.229.2]:33993 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755168AbZAAJZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 04:25:28 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LIJnv-0002wq-1u
	for git@vger.kernel.org; Thu, 01 Jan 2009 09:25:23 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Jan 2009 09:25:23 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Jan 2009 09:25:23 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104294>

On 2009-01-01, jidanni@jidanni.org <jidanni@jidanni.org> wrote:
> Last week I did git-clone --depth 1 This week I wanted to freshen my
> repository, with the same goal: "I don't care about history, just
> fast forward me with the least bytes transfered." But all I can find
> is just plain git pull. Did I achieve my goal?
> $ git pull
> remote: Counting objects: 7007, done.
> remote: Compressing objects: 100% (3057/3057), done.
> remote: Total 7007 (delta 4280), reused 6076 (delta 3625)
> Receiving objects: 100% (7007/7007), 2.96 MiB | 26 KiB/s, done.
> Resolving deltas: 100% (4280/4280), done.
> From git://git.kernel.org/pub/scm/git/git
>    2fa431b..bbbb865  html       -> origin/html
>    a9012e3..936b705  maint      -> origin/maint
>    dfd79c7..794d84e  man        -> origin/man
>    159c88e..c32f76f  master     -> origin/master
>    3b9b952..6f67462  next       -> origin/next
>  + b14a7fb...89bdc19 pu         -> origin/pu  (forced update)

The hashes certainly agree with what I have (just did a pull
this minute), except I also have a new branch called
"origin/todo" at SHA1=6670008 which you seem to be missing.

I'm not familiar enough with shallow clones to draw any
conclusions though :-(
