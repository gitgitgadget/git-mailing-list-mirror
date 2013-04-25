From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH 5/7] git-log.txt: rewrite note on why "--" may be required
Date: Wed, 24 Apr 2013 17:02:51 -0700
Message-ID: <7vmwsn8ok4.fsf_-_@alter.siamese.dyndns.org>
References: <1366608631-21734-1-git-send-email-artagnon@gmail.com>
	<1366608631-21734-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 02:03:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV9eP-0004c6-H9
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 02:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758513Ab3DYAC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 20:02:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62605 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758416Ab3DYACz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 20:02:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9314196AA;
	Thu, 25 Apr 2013 00:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aQG7SYkHmBpxerrt428Eh5iGfZg=; b=fNe6oh
	XKzDHI6UPpB1wBEiZwidMjSUGYI5bcR3eZRDpR8GtUd6+IuxKdfvsx8Mwh3Tv60t
	o8PoShlSV2V8ykTYinJjEaoNHj6q79ytEjJAELO84+FpKAPKPCK1sFccBnydMbPl
	r7u5YZFhnv9aUxVWgHSADakD6jD6Ojye3NYN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RHaEuOifsO7skWB6EXNWXtVQTRobvKNE
	KdfrQvkAjuShUwT4/sizRf+6lF4QU9vTAmE4F7NBda95sHPVoWe3PWXMq0bewNj2
	YQzY1lrQlq8WhCrnpxYIPb2UxTpQc/ZqtTLIjOekvHkQ7niKQ/FmPlhpV69n+A7H
	5gmJpXDzCiQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BDD73196A9;
	Thu, 25 Apr 2013 00:02:53 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1360D196A8;
	Thu, 25 Apr 2013 00:02:52 +0000 (UTC)
In-Reply-To: <1366608631-21734-6-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Mon, 22 Apr 2013 11:00:29 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 79B1932E-AD3B-11E2-A600-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222338>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> In its current form, the note talks about separating options from
> "branch names" and "refnames" in the same sentence.  This is entirely
> inaccurate, as <revision range> need not be a set of branch names or
> ref names.  Rewrite it to use the word "revision range", to be
> consistent with the SYNOPSIS.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/git-log.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index 9576695..a976534 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -77,8 +77,8 @@ produced by --stat etc.
>  	Simplification" below for details and other simplification
>  	modes.
>  +
> -To prevent confusion with options and branch names, paths may need to
> -be prefixed with "\-- " to separate them from options or refnames.
> +Paths may need to be prefixed with "\-- " to separate them from
> +options or the revision range, when confusion arises.
>  
>  include::rev-list-options.txt[]

This is an explanation about an enumeration item:

	[\--] <path>...::

which corresponds to this in the synopsis:

        'git log' [<options>] [<revision range>] [[\--] <path>...]

But the synopsis looks incorrect to me.  It insists that if you were
to write "--", you have to give at least one <path>.

It should be more like this [*1*]:

	'git log' [<options>] [<revision range>] [--] [<path>...]

It may be better to split the item into two, keep the current
description of <path> under "<path>...::" heading, and have another
heading for "--::" that talks about the disambiguation.  The "--"
disambiguator is not solely for "your path might be mistaken as a
revision without it", but also for "your revision might be mistaken
as a path", but both the old and the new text are fuzzy about the
reason what "confusion" it is cautioning the reader.

Formatting doubts aside, one thing I am not so happy about the
suggested patch below (would apply on top of the patches from this
series) is that the explanation of a double-dash requires
understanding of _both_ what <revision range> and <path>... means to
the command, but for a reader who has read this page from top, the
latter has not been explained yet.  We could of course swap the
order and describe <path>... first and then "--", but that does not
sound quite right, either.  It has to be between these two.


[Footnote]

*1* We have many instances like "[--quiet]" in Documentation; do we
    need the backslash before these double-dash like "[\--]"?


 Documentation/git-log.txt | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index a976534..f5746e4 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -9,7 +9,7 @@ git-log - Show commit logs
 SYNOPSIS
 --------
 [verse]
-'git log' [<options>] [<revision range>] [[\--] <path>...]
+'git log' [<options>] [<revision range>] [--] [<path>...]
 
 DESCRIPTION
 -----------
@@ -71,14 +71,26 @@ produced by --stat etc.
 	ways to spell <revision range>, see the "Specifying Ranges"
 	section of linkgit:gitrevisions[7].
 
-[\--] <path>...::
+--::
+	On the command line, arguments that specify revision range
+	come first and then paths (see the next item).  A
+	double-dash can be used to mark the end of revision range
+	arguments when an argument can be otherwise ambiguous.
++
+For example, when there are a file called `master` and a branch with
+the same name, what `git log master` means is unclear.  It may be
+asking for the whole history leading to the current commit (i.e. no
+<revision range> is specified, defaulting to `HEAD`), limited to
+commits that touch a single path `master`.  Or it may be asking for
+the whole history leading to the tip of `master`, without any path
+limiting.  The former can be spelled `git log -- master`, while the
+latter can be spelled `git log master --`.
+
+<path>...::
 	Show only commits that are enough to explain how the files
 	that match the specified paths came to be.  See "History
 	Simplification" below for details and other simplification
 	modes.
-+
-Paths may need to be prefixed with "\-- " to separate them from
-options or the revision range, when confusion arises.
 
 include::rev-list-options.txt[]
 
