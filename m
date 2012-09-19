From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-blame.txt: --follow is a NO-OP
Date: Tue, 18 Sep 2012 21:38:32 -0700
Message-ID: <7v627aiq47.fsf@alter.siamese.dyndns.org>
References: <20120906151317.GB7407@sigill.intra.peff.net>
 <1348022905-10048-1-git-send-email-n1xim.email@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitList <git@vger.kernel.org>, <Matthieu.Moy@imag.fr>,
	<andy@aeruder.net>, <chriscool@tuxfamily.org>,
	<dmellor@whistlingcat.com>, <dpmcgee@gmail.com>, <fonseca@diku.dk>,
	<freku045@student.liu.se>, <kevin@sb.org>, <marius@trolltech.com>,
	<namhyung@gmail.com>, <peff@peff.net>,
	<rene.scharfe@lsrfire.ath.cx>, <s-beyer@gmx.net>,
	<trast@inf.ethz.ch>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 06:38:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEC3h-0006DR-FJ
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 06:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389Ab2ISEih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 00:38:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47914 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752053Ab2ISEig (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 00:38:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E9809F3E;
	Wed, 19 Sep 2012 00:38:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D80XHX2aTHmROaT2mBGJgsB+eWU=; b=I7iPFi
	wzwhPm02PBczP8DjqEB8bKig6QrBGkcfEhlvPSZc9adYicrgn6StbR+5+8wNOQ7n
	dui0uCuglRbyThn+xnZ974IVKciZL03cTmNJm1Vh8vt/Ispc2dcGmOQ3qHc14rj+
	cOmaWf5UBiM7OUf8xY9c9/10MYa10AwUcOxZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iy9TN0eVkOb2ylRtdYR72qq6KWUK/INX
	544NAsrPpekJEJviX2tXF/PSehVXkY7ano72EqbJpwsxWSIWfV1LbRqKhR6hkiYf
	6gGXVNqaCPyEnKqjEpKEFhrrRZ293o2fc7US4rPtitsrtphKBez6W9qOumV94o1l
	Okz3sTdQj0g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39D8E9F3D;
	Wed, 19 Sep 2012 00:38:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 652589F3B; Wed, 19 Sep 2012
 00:38:34 -0400 (EDT)
In-Reply-To: <1348022905-10048-1-git-send-email-n1xim.email@gmail.com> (Drew
 Northup's message of "Tue, 18 Sep 2012 22:48:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DF1122BC-0213-11E2-A3B0-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205907>

Drew Northup <n1xim.email@gmail.com> writes:

> Make note that while the --follow option is accepted by git blame it does
> nothing.
>
> Signed-off-by: Drew Northup <n1xim.email@gmail.com>
> ---
>  Documentation/git-blame.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
> index 7ee9236..7465bd8 100644
> --- a/Documentation/git-blame.txt
> +++ b/Documentation/git-blame.txt
> @@ -9,7 +9,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w] [--incremental] [-L n,m]
> -	    [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>] [--abbrev=<n>]
> +	    [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>] [--abbrev=<n>] [--follow]
>  	    [<rev> | --contents <file> | --reverse <rev>] [--] <file>
>  
>  DESCRIPTION
> @@ -78,6 +78,9 @@ include::blame-options.txt[]
>  	abbreviated object name, use <n>+1 digits. Note that 1 column
>  	is used for a caret to mark the boundary commit.
>  
> +--follow::
> +        NO-OP accepted due to using the option parser also used by
> +        'git log'

This is triply questionable.  If it is a useless NO-OP, it shouldn't
be advertised in the SYNOPSIS section to begin with.

Your "--follow is a no-op for blame" is technically correct, but I
think the only ones that can appreciate that technical correctness
are those like you who know why we can get away by having a
seemingly no-op "--follow" option without losing functionality.

"git blame" follows the whole-file renames correctly [*1*], without
any -M/-C options.  There is no _need_ to use the "keep one global
filename to follow, and switch to a different filename when it
disappears" hack the "--follow" code uses.  That is the reason why
"blame" pays no attention to the "--follow" option.  You know that,
and that is why you think it is a sane thing to describe it in
technically correct way.

But I think most of the readers of the documentation are not aware
of that true reason why it can be a "No-op".  Worse yet, they may
have heard of the "--follow" option that the "log" command has from
any of the numerous misguided web pages, and are led to believe that
the "--follow" option is a true feature, not a checkbox hack.

If readers come from that background, thinking "--follow" is the way
to tell Git to follow renames, what message does your description
send them?  I would read it as "git blame accepts --follow from the
command line, but it is a no-op.  There is no way to make it follow
renames."

That is a totally wrong message to send.  You failed to teach the
reader that there is no need to do anything special to tell the
command to follow per-line origin across renames.

So if anything, I would phrase it this way instead:

    --follow::
          This option is accepted but silently ignored.  "git blame"
	  follows per-line origin across renames without any special
	  options, and there is no reason to use this option.

It does not matter to the reader why it is accepted by the parser at
the mechanical level (your description of the parser being shared
with the log family).  What matters to the readers is that it is
accepted as a courtesy (as opposed to being rejected as an error),
but it is unnecessary to give it in the first place.

If you followed the logic along, you would agree that it is a crime
to list it in the SYNOPSIS section.


[Footnote]

*1* Unlike "--follow" checkbox hack, which follows renames correctly
only in a strictly linear history, "blame" maintains the filename
being tracked per history traversal path and will follow a history
like this:

    ----A----B
         \    \
          C----D

where you originally had your file as fileA, one side of the fork
renamed it to fileB while the other side of the fork renamed it to
fileC, and a merge coalesced it to fileD.  "git blame fileD" will
find the line-level origin across all these renames.

Try this:

    git init
    printf "%s\n" a a a a a >fileA
    git add fileA
    git commit -m A
    git branch side
    printf "%s\n" a b b a a >fileB
    git add fileB
    rm fileA
    git commit -a -m B
    git checkout side
    printf "%s\n" a a c c a >fileC
    git add fileC
    rm fileA
    git commit -a -m C
    git merge master
    git rm -f fileA fileB fileC
    printf "%s\n" a b d c a >fileD
    git add fileD
    git commit -a -m D

and then in the resulting history

    git blame fileD
