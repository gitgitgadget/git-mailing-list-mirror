From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What is not in git.git
Date: Wed, 04 Feb 2009 14:49:00 -0800
Message-ID: <7vy6wllswz.fsf@gitster.siamese.dyndns.org>
References: <20090205054918.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, ecashin@coraid.com, arjen@yaph.org,
	joey@kitenet.net, benny.kra@googlemail.com, pw@padd.com,
	simon@lst.de, jidanni@jidanni.org, dirker@gmail.com,
	hoxu@users.sf.net
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 23:50:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUqZw-0002lq-PV
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 23:50:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756815AbZBDWtS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Feb 2009 17:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756476AbZBDWtR
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 17:49:17 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54251 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755994AbZBDWtR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Feb 2009 17:49:17 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CAFDF2A72C;
	Wed,  4 Feb 2009 17:49:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A83011CE63; Wed, 
 4 Feb 2009 17:49:02 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0CA40F00-F30E-11DD-95FC-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108451>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> You keep mentioning 1.6.2 and I take it as a hint that the project is
> approaching the pre release freeze. There are some patches sent to th=
e
> list that are not in git.git, and I am wondering what their statuses =
are.
>
>  1. From: ecashin@coraid.com
>     Subject: [PATCH] git-describe documentation: --match pattern is g=
lob
>     Date: Thu, 22 Jan 2009 11:21:53 -0500
>     Message-ID: <dfa634dbd8def9e205bbe219217179ca@coraid.com>
>
>     I thought this was correct, but was missing a sign-off. Perhaps i=
t was
>     dropped on the floor because it was sent in a wrong format that i=
s
>     harder to apply?

Mostly correct, but because we consider refnames like filesystem paths =
and
the use of globs when matching them is shared as the same basic design
across commands, I do not think the manual page for each individual
command is the right place to say it.

>  2. From: Arjen Laarhoven <arjen@yaph.org>
>     Subject: [PATCH 2/2] git-log: Follow file copies with 'git log --=
follow -C -C'
>     Date: Thu, 22 Jan 2009 17:37:25 +0100
>     Message-ID: <1232642245-94405-2-git-send-email-arjen@yaph.org>
>
>     Junio seemed to like the patch but asked a question; I did not se=
e a
>     response nor updated patch (sorry, I do not read C and cannot com=
ment
>     on the correctness of the patch).

Thanks for a reminder, and no, don't be sorry.  This type of "project
secretary" help is very much appreciated, and you are demonstrating tha=
t
you do not have to know the code very intimately to do this, which is a=
lso
very good.

>  3. From: Joey Hess <joey@kitenet.net>
>     Subject: [PATCH] gitweb: support the rel=3Dvcs microformat
>     Date: Tue, 6 Jan 2009 23:25:18 -0500
>     Message-ID: <20090107042518.GB24735@gnu.kitenet.net>
>
>     A few exchanges of review comments and responses, and then this t=
opic
>     went dark.

This is in "The author will come back if he feels strongly enough, so I
can safely forget about it. I am not qualified to take over as the prim=
ary
promoter of the topic if the author abandones it anyway" (aka "not mine=
")
category.

>     From: Benjamin Kramer <benny.kra@googlemail.com>
>     Subject: [PATCH] Makefile: Use libc strlcpy on OSX
>     Date: Sat, 24 Jan 2009 16:41:30 +0100
>     Message-ID: <7f978c810901240741k201f954dx1c0470186094ae24@mail.gm=
ail.com>
>
>     My reading of the thread is that the only remaining issue was to =
limit
>     the change to specific versions, and I think people who use OSX c=
an help
>     polish this topic to completion.

Likewise.

>  4. From: Pete Wyckoff <pw@padd.com>
>     Subject: [PATCH] git-p4: avoid syncing duplicate changes
>     Date: Wed, 28 Jan 2009 08:45:40 -0800
>     Message-ID: <20090128164540.GA2137@padd.com>
>
>     Nobody commented on this as far as I can tell. Do people not care
>     about p4? Simon Hausmann seem to be the most recent active contri=
butor
>     and perhaps he can comment on this patch.

Likewise.

>  5. From: jidanni@jidanni.org
>     Subject: [PATCH] Documentation/git-show-branch.txt: compact -g
>     Date: Tue,  6 Jan 2009 11:14:02 +0800
>     Message-Id: <1231211642-14463-1-git-send-email-jidanni@jidanni.or=
g>
>
>     I couldn't figure out what "compact -g" meant but other than that=
 I
>     think this patch is correct. Perhaps Junio has the author in his =
mail
>     ignore list?

I do not have anybody in my killfile.  I think this patch is Ok with a
minor fix to log as you say.  How about

	git-show-branch doc: show -g as synonym to --reflog in the list

>  6. From: Alexander Potashev <aspotashev@gmail.com>
>     Subject: [PATCH] Replace deprecated dashed git commands in usage
>     Date: Sun,  4 Jan 2009 21:39:27 +0300
>     Message-ID: <1231094367-8831-1-git-send-email-aspotashev@gmail.co=
m>
>
>     This should have been in 1.6.0 already but it is still not.
>     Forgotten?

I haven't looked at it.  As long as it only touches the messages and no=
t
strings used to invoke other commands with their names, there shouldn't=
 be
any downside.

>  7. From: Dirk H=C3=B6rner <dirker@gmail.com>
>     Subject: [PATCH] git-cvsimport: add support for cvs pserver passw=
ord scrambling.
>     Date: Fri, 28 Nov 2008 20:06:40 +0200
>     Message-ID: <5794AED2-43FF-4441-8292-0C9BFB3139A2@gmail.com>
>
>     I think Johannes Schindelin commented but then nothing happened t=
o
>     this patch. Is there any more work necessary for its inclusion?

Again, this is in "not mine" category.

>  8. From: Heikki Hokkanen <hoxu@users.sf.net>
>     Subject: [PATCH] git show-ref: add --remotes option.
>     Date: Mon, 13 Oct 2008 22:23:47 +0300
>     Message-ID: <48F3A043.5070406@users.sf.net>
>
>     I saw no comments but it is consistent with how git-rev-list allo=
ws
>     you say branches and tags. Is there anything wrong with the patch=
?

Hmm, ... goes to the archive ... I guess this shouldn't hurt.

Thanks.  I wish there were more like you.
