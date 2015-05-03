From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] git help: group common commands by theme
Date: Sun, 03 May 2015 10:16:35 -0700
Message-ID: <xmqq7fspwpho.fsf@gitster.dls.corp.google.com>
References: <554405D5.9080702@gmail.com>
	<xmqqk2wqwg9f.fsf@gitster.dls.corp.google.com>
	<55462895.8080108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?S=C3=A9bastien?= Guimmara <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 03 19:16:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoxVT-0001iY-PJ
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 19:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbbECRQk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 May 2015 13:16:40 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63606 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750779AbbECRQi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 May 2015 13:16:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6291E4D682;
	Sun,  3 May 2015 13:16:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FjJxCQFf/43+
	iyjytOeHP89OH3k=; b=v36BeFr8DX40klm1Ap1+cUfJwdb6/9v3oBXJ058wHCGE
	8KpTTVCIMtlA378pOq70UnNY3xMcX0NtZK8yRLzWU0t5la4BvZsEEw7Or9z2s4l6
	u47aZCp9mfaBkAqoq1bJu8OZ6gqPYHiFVtCFWBdpGG4Eq1W1iZeKE9LWxUX6PYg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=bTihXs
	SY78QYe2JbTMf6lwqQF/Iv/vCf4qECBexVHC7eD3QoLV/aFuJA64DQHR7Cx9zTGL
	GKu1c1iO41b7unfkaFOXI5zgzHQfIJX840ytQ9uI+wtC3c4DQKVpQx+rUpj6qUQ2
	RyKRk8G0XDmUudNZaGX55A2djDgGFhUPJvezw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5BDA74D680;
	Sun,  3 May 2015 13:16:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D8EE44D67E;
	Sun,  3 May 2015 13:16:36 -0400 (EDT)
In-Reply-To: <55462895.8080108@gmail.com> (=?utf-8?Q?=22S=C3=A9bastien?=
 Guimmara"'s message of
	"Sun, 03 May 2015 15:54:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 279FAEEA-F1B8-11E4-B9C8-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268274>

S=C3=A9bastien Guimmara  <sebastien.guimmara@gmail.com> writes:

> We could then display headers this way:
>
> The most commonly used git commands are:
>    * starting a working area:
>       clone      Clone a repository into a new directory
>       init       Create an empty Git repository or reinitialize an ex=
isting one
>     * examining the history and state:
>       diff       Show changes between commits, commit and working tre=
e, etc
>       log        Show commit logs
>       show       Show various types of objects
>       status     Show the working tree status
>       bisect     Find by binary search the change that introduced a b=
ug
>       grep       Print lines matching a pattern
>
>    * working on the current change:
>       add        Add file contents to the index
>       checkout   Checkout a branch or paths to the working tree
>       reset      Reset current HEAD to the specified state
>       rm         Remove files from the working tree and from the inde=
x
>       mv         Move or rename a file, a directory, or a symlink
>     * growing, marking and tweaking your history:
>       commit     Record changes to the repository
>       rebase     Forward-port local commits to the updated upstream h=
ead
>       tag        Create, list, delete or verify a tag object signed w=
ith GPG
>     * working with others:
>       fetch      Download objects and refs from another repository
>       pull       Fetch from and integrate with another repository or =
a local branch
>       push       Update remote refs along with associated objects
>     * branching and merging histories:
>       branch     List, create, or delete branches
>       merge      Join two or more development histories together
>
> This raises a few questions:
>
> 1. Is 'bisect' really a common command (from the target audience stan=
dpoint)

That is a good question, but so are many other commands.

I think that (1) it is a good idea to list commands in groups, (2)
having group-head is necessary if we list commands in groups, but
(3) because group-heads consume valuable vertical space in the
output, we may have to have fewer commands in the list.

=46or example, "mv" and "rm" are very questionable things to have in
the "most commonly used" list.  All you need to start with Git is
"add" and "commit -a".

"clone" and "init" are "once per working area for a project you deal
with" kind of thing, and cannot be in the "commonly used and you
benefit from a gentle nudge to read about it more in the manual to
learn Git" category by definition.

"rebase" should be with "merge" and "branch", but I wouldn't have
"branching and merging" as a separate category---they are all part
of "growing and tweaking".  And "branch" itself may be questionable
for those who are starting with Git.

Do we care about the ordering of the items within groups, by the way?

> 2. Does 'Forward-port local commits to the updated upstream head' rea=
lly help
>    to grok the idea of 'rebase' ? There are 3 words in this sentence =
that
>    an unfamiliar git user may not be comfortable with...

"Rebuild the history on a branch on top of a new commit", perhaps?

But this brings us back to "what the target audience?" question.

My answer to the question has always been "the list is a gentle
nudge to guide the user to read about it more in the manual to
learn."  The sooner users are guided to graduate from the "not be
comfortable" state, the more productive they will be.

=46or that to happen, we would need to (1) strongly suggest that the
subcommand is what the user wants to use, and (2) carefully avoid
giving an impression that the user learned everything there is to
know in order to use the command effectively from that single line.

Of course, an argument can be made that the single-line should aim
to teach everything there is to know in order to use the command
effectively, but because I do not think that is feasible I would
aim for the second best, which is why we want to keep the last two
lines about "git help <command> for a specific subcommand".
