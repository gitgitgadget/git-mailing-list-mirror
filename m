From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: Use 'First Paragraph' instead of 'First
 Line'.
Date: Thu, 13 Sep 2012 11:25:47 -0700
Message-ID: <7vehm593v8.fsf@alter.siamese.dyndns.org>
References: <5051D4A0.4060608@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeremy White <jwhite@codeweavers.com>
X-From: git-owner@vger.kernel.org Thu Sep 13 20:26:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCE6y-0005JS-4a
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 20:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755981Ab2IMSZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 14:25:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46851 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752387Ab2IMSZu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 14:25:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A2869240;
	Thu, 13 Sep 2012 14:25:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8IWTbE878H0EEq5MrUiWjluS1BQ=; b=JXJFT8
	A7lrHjV53kNFc/vwiTQ3OR+pFI68eNfItmj9OoyZchdOqbxbzQq3tVwkOuBoq2Pi
	Kz7aWmMQBJ1VAeB797MJHZUOaMWvNp6tBOplj2DiQQhoE1FzIJAgvCRLlsxERnJP
	yThHx4BJ0vEgScTpK3ghLVAsnUb6iX14hX63s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R2maaVn5efkec/27e+dVKt9r99OUJSrc
	l3BCfH/S/WPN9btGIZFOgRTV5IhY7RNSUwPSsxzaQKlpdocC6Do80ul0o09/lMMP
	H8evNROVuaSKVsa0Ru86RXi4WKPdlDqwN7b8c5+CJyz9xQW2GLz7yqZ6hezp2vL9
	7/veLAfG8c8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55820923F;
	Thu, 13 Sep 2012 14:25:49 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88E94923E; Thu, 13 Sep 2012
 14:25:48 -0400 (EDT)
In-Reply-To: <5051D4A0.4060608@codeweavers.com> (Jeremy White's message of
 "Thu, 13 Sep 2012 07:42:08 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 70D249E4-FDD0-11E1-BBCB-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205404>

Jeremy White <jwhite@codeweavers.com> writes:

> The discussion of email subject throughout the documentation is
> misleading; it indicates that the first line will become the subject.
> In fact, the first and second and third lines will become the subject,
> up until the first full blank line.  Describing it as the first paragraph
> is more accurate.
>
> Signed-off-by: Jeremy White <jwhite@codeweavers.com>
> ---
>  Documentation/git-commit.txt       |    2 +-
>  Documentation/git-for-each-ref.txt |    2 +-
>  Documentation/git-format-patch.txt |    8 +++++---
>  Documentation/git-shortlog.txt     |    2 +-
>  Documentation/gitcore-tutorial.txt |    2 +-
>  Documentation/gittutorial.txt      |    2 +-
>  Documentation/user-manual.txt      |    2 +-
>  7 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index e99bb14..a61bca9 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -349,7 +349,7 @@ DISCUSSION
>  Though not required, it's a good idea to begin the commit message
>  with a single short (less than 50 character) line summarizing the
>  change, followed by a blank line and then a more thorough description.
> -Tools that turn commits into email, for example, use the first line
> +Tools that turn commits into email, for example, use the first paragraph
>  on the Subject: line and the rest of the commit in the body.

This is a good change, as the previous sentence says the norm for
the first paragraph is a single line.

> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index 7e83288..499c26a 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -100,7 +100,7 @@ Fields that have name-email-date tuple as its value (`author`,
>  `committer`, and `tagger`) can be suffixed with `name`, `email`,
>  and `date` to extract the named component.
>  
> -The first line of the message in a commit and tag object is
> +The first paragraph of the message in a commit and tag object is
>  `subject`, the remaining lines are `body`.  The whole message
>  is `contents`.

This may need a bit more explanation.  Just saying "First Paragraph"
without saying that for all commits in a sane project it is the same
as "First Line" will make the reader wonder "What happens to the
second and subsequent lines?" (the answer is that the first paragraph 
is made into a single looooooong line).

> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 9674f9d..e6f6d0e 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -57,10 +57,12 @@ output, unless the `--stdout` option is specified.
>  If `-o` is specified, output files are created in <dir>.  Otherwise
>  they are created in the current working directory.
>  
> -By default, the subject of a single patch is "[PATCH] First Line" and
> +By default, the subject of a single patch is "[PATCH] First Paragraph" and
>  the subject when multiple patches are output is "[PATCH n/m] First
> +Paragraph". Note that "First Paragraph" consists of text in the commit message
> +prior to the first completely blank line (see the DISCUSSION section
> +in linkgit:git-commit[1]).  To force 1/1 to be added for a single patch,
> +use `-n`.  To omit patch numbers from the subject, use `-N`.

Ditto.

> diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
> index dfd4d0c..9464932 100644
> --- a/Documentation/git-shortlog.txt
> +++ b/Documentation/git-shortlog.txt
> @@ -15,7 +15,7 @@ DESCRIPTION
>  -----------
>  Summarizes 'git log' output in a format suitable for inclusion
>  in release announcements. Each commit will be grouped by author and
> -the first line of the commit message will be shown.
> +the first paragraph of the commit message will be shown.

Ditto.

> diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
> index f7815e9..92f97e6 100644
> --- a/Documentation/gitcore-tutorial.txt
> +++ b/Documentation/gitcore-tutorial.txt
> @@ -956,7 +956,7 @@ $ git show-branch --topo-order --more=1 master mybranch
>  ------------------------------------------------
>  
>  The first two lines indicate that it is showing the two branches
> -and the first line of the commit log message from their
> +and the first paragraph of the commit log message from their
>  top-of-the-tree commits, you are currently on `master` branch
>  (notice the asterisk `\*` character), and the first column for
>  the later output lines is used to show commits contained in the

Ditto.

> diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
> index 1c16066..a1bc56c 100644
> --- a/Documentation/gittutorial.txt
> +++ b/Documentation/gittutorial.txt
> @@ -139,7 +139,7 @@ A note on commit messages: Though not required, it's a good idea to
>  begin the commit message with a single short (less than 50 character)
>  line summarizing the change, followed by a blank line and then a more
>  thorough description.  Tools that turn commits into email, for
> -example, use the first line on the Subject: line and the rest of the
> +example, use the first paragraph on the Subject: line and the rest of the
>  commit in the body.

This is a good change, as it is clear that you are expected to write
a single line in the first paragraph in the previous sentence.

> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index fe6fb72..dd2f985 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -1126,7 +1126,7 @@ Though not required, it's a good idea to begin the commit message
>  with a single short (less than 50 character) line summarizing the
>  change, followed by a blank line and then a more thorough
>  description.  Tools that turn commits into email, for example, use
> -the first line on the Subject line and the rest of the commit in the
> +the first paragraph on the Subject line and the rest of the commit in the
>  body.

Ditto.
