From: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
Subject: Re: [ANNOUNCE] TopGit v0.3
Date: Thu, 11 Sep 2008 10:03:12 +0200
Organization: lilypond-design.org
Message-ID: <1221120192.8962.7.camel@heerbeest>
References: <20080909231009.GD10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Sep 11 12:15:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdjD5-0006bt-PT
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 12:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754635AbYIKKOA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 06:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754617AbYIKKN7
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 06:13:59 -0400
Received: from edu-smtp-01.edutel.nl ([88.159.1.221]:54061 "EHLO
	edu-smtp-01.edutel.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754557AbYIKKN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 06:13:58 -0400
Received: from heerbeest (unknown [88.159.206.46])
	by edu-smtp-01.edutel.nl (Postfix) with ESMTP id E230767880;
	Thu, 11 Sep 2008 12:13:56 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by heerbeest (Postfix) with ESMTP id 8A789DC08A;
	Thu, 11 Sep 2008 12:13:56 +0200 (CEST)
In-Reply-To: <20080909231009.GD10544@machine.or.cz>
X-Mailer: Evolution 2.23.91 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95600>

On wo, 2008-09-10 at 01:10 +0200, Petr Baudis wrote:

Hi,

> I decided not to consider the 'tg depend' work by Jan Nieuwenhuiz for
> this release yet, since it will probably take me a bit of time yet to
> fully understand his approach; so far, I have an uneasy feel about it.

Ah, good.  It is still an experiment, as far as I'm concerned.  Alas,
I haven't gotten round to look at it, really.

We were discussing this, Jonathan Nieder had two more suggestions/ideas

    http://kerneltrap.org/mailarchive/git/2008/8/15/2954214
    http://kerneltrap.org/mailarchive/git/2008/8/15/2952004

and Bert reported a bug

    http://kerneltrap.org/mailarchive/git/2008/9/1/3152864

The last implementation would just recreate a branch with all new
dependencies, which is quite inefficient when you're just removing
or adding one (and the list of dependencies is long, say ~100).

It would be nice if my previous cherry-pick & revert logic would be
combined with git read-tree to create the new dependencies-base.
That could be much faster and hopefully git read-tree could fix 
the multiple add/remove issue.

Greetings,
Jan.

-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org
