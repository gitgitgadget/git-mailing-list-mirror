From: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
Subject: Re: [TopGit PATCH] tg redepend: New command.
Date: Mon, 01 Sep 2008 12:11:45 +0200
Organization: lilypond-design.org
Message-ID: <1220263905.6278.13.camel@heerbeest>
References: <1218808427.25300.2.camel@heerbeest>
	 <36ca99e90809010231o439ab4acsaa3027366c551ff6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Jan Holesovsky <kendy@suse.cz>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 12:13:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka6PA-00012Z-IJ
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 12:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbYIAKLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 06:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751843AbYIAKLt
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 06:11:49 -0400
Received: from edu-smtp-01.edutel.nl ([88.159.1.221]:55477 "EHLO
	edu-smtp-01.edutel.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbYIAKLs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 06:11:48 -0400
Received: from heerbeest (unknown [88.159.206.46])
	by edu-smtp-01.edutel.nl (Postfix) with ESMTP id BCEB4677A1;
	Mon,  1 Sep 2008 12:11:46 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by heerbeest (Postfix) with ESMTP id 239EDDC07A;
	Mon,  1 Sep 2008 12:11:46 +0200 (CEST)
In-Reply-To: <36ca99e90809010231o439ab4acsaa3027366c551ff6@mail.gmail.com>
X-Mailer: Evolution 2.23.90 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94557>

On ma, 2008-09-01 at 11:31 +0200, Bert Wesarg wrote:

Hi Bert,

> 
> On Fri, Aug 15, 2008 at 15:53, Jan Nieuwenhuizen <janneke-list@xs4all.nl> wrote:
> > As discussed previously
> >
> >    http://kerneltrap.org/mailarchive/git/2008/8/13/2925144
> >
> > Change a topgit branch's dependencies by doing a rebase-by-merge.
> >
> >
> is this script in use by you, or is it abandoned in favor of another idea?

I haven't had the time to digest the several new takes on this, esp.
http://kerneltrap.org/mailarchive/git/2008/8/15/2954214 and combining
my previous attempt's use of git revert and git cherry-pick with git
read-tree to make for a much faster adding or removal of
dependencies.

> Anyway, I have tried it today but it looks like the top-bases wasn't
> updated to the new deps.

How odd.  It also looks like "redeps" contains the new set of
dependencies, which is written to .topdeps.  I guess that most of
this script will be abandoned anyway, but a nice bug report ie: how to
reproduce this error never hurts ;-)

> IMHO all these "| tr '\n' ' '" aren't needed. bash do the right thing
> here.

Thanks, I'll have a look.  You did try --add, --remove and "new dep
list" right? 

Greetings,
Jan.

-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org
