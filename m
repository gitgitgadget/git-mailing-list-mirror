From: Adam Spiers <git@adamspiers.org>
Subject: git-rnotes: git-notes wrapper for sharing notes between repositories
Date: Mon, 29 Apr 2013 14:32:05 +0100
Message-ID: <20130429133205.GA4672@pacific.linksys.moosehall>
References: <20130427132118.GA25295@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 29 15:32:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWoBh-0004BP-Vx
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 15:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757007Ab3D2NcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 09:32:09 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:40107 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756956Ab3D2NcH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 09:32:07 -0400
Received: from localhost (5.a.1.1.6.d.5.2.6.0.7.e.c.a.8.2.0.d.3.7.6.a.1.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:11a6:73d0:28ac:e706:25d6:11a5])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 5957D2EAD2
	for <git@vger.kernel.org>; Mon, 29 Apr 2013 14:32:06 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130427132118.GA25295@pacific.linksys.moosehall>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222794>

On Sat, Apr 27, 2013 at 02:21:19PM +0100, Adam Spiers wrote:
> Hi all,
> 
> I just wrote a wrapper around git cherry which adds a splash of
> colour, and facilitates exclusion of commits which should never be
> upstreamed, by using a git-notes(1) namespace as a blacklist.
> 
> It's just a quick hack and Ruby probably won't be to everyone's taste,
> but I thought I'd mention it just in case it's of use / interest.
> 
>     https://github.com/aspiers/git-config/blob/master/bin/git-icing

[snipped]

I've just written another quick wrapper around 'git notes' which makes
it less painless to share notes to and from remote repositories:

    https://github.com/aspiers/git-config/blob/master/bin/git-rnotes

This makes sharing of notes as easy as:

    git rnotes $remote push
    git rnotes $remote fetch
    git rnotes $remote merge
    git rnotes $remote pull

and was born from this discussion:

    http://stackoverflow.com/questions/12055303/merging-git-notes-when-there-are-merge-conflicts-in-them/

Once the Great Refs Namespace Debate is resolved[0], would this kind
of UI would be a candidate for pushing into git-notes itself?

Cheers,
Adam

[0] Maybe it has been already; I haven't been following closely.
