From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git add -e documentation: rephrase note
Date: Sun, 18 Oct 2009 22:38:46 -0700
Message-ID: <7vbpk4aqop.fsf@alter.siamese.dyndns.org>
References: <20091014222628.GK6115@genesis.frugalware.org>
 <20091014230434.GB29664@coredump.intra.peff.net>
 <20091019000900.GV6115@genesis.frugalware.org>
 <20091019043418.GD7170@coredump.intra.peff.net>
 <20091019050456.GA15706@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 19 07:39:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzkxW-0007Y5-IK
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 07:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395AbZJSFiz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Oct 2009 01:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752063AbZJSFiy
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 01:38:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43128 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029AbZJSFiy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Oct 2009 01:38:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 014F27D44D;
	Mon, 19 Oct 2009 01:38:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9xK/ICag95pl
	G5tdamrzcUFI9/k=; b=YVl7iZdSa64rkMGehR8RaQXtmYs4jR3LBzOSrXbDd/co
	hpTPap2PRmvo9GmVd4nfHSRyHolrRiz0nsnNAn9yuljrKYpJk81xtDhq94SqtnZG
	/9TyNHclzGKJyYUTDzpZ14jZI8BV4UY3yNjtcLdXVUxJXukzo4oINmfPo3EC6b0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=DIW3Ca
	3jFgy6Dmpw7lZpv9XIECKjM682iz2NqZxyjGjwbY4buqBLYwyKehh+nFGiENwWh+
	KgT7RFDGkgd6uTXC9RY70K8Sv0pkP72RELd74+kcbmjZxX0JMJHYkIIr9BYeznHg
	sd0JmkRY059hG5t3NbiiOXxzMOSI5ttN2wyt0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CE49A7D44C;
	Mon, 19 Oct 2009 01:38:53 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2504C7D44B; Mon, 19 Oct 2009
 01:38:47 -0400 (EDT)
In-Reply-To: <20091019050456.GA15706@coredump.intra.peff.net> (Jeff King's
 message of "Mon\, 19 Oct 2009 01\:04\:56 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B0038248-BC71-11DE-8F42-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130651>

Jeff King <peff@peff.net> writes:

> Hmph. Here is my attempt. The text is (I hope) more clear, but I am
> still having trouble with the formatting. It looks fine in the HTML
> version, and if I am reading the XML right, the XML is correct. But
> docbook seems to screw up converting the XML to roff, giving this:
>
>            =C2=B7   convert removal lines to context lines (don=E2=80=
=99t stage removal)
>                Similarly, your patch will likely not apply if you:
>
>            =C2=B7   add context or removal lines
>
> Am I missing something, or is it really a docbook bug? Does it render
> better for anybody else?

Not for me, and I have seen manpages lacking a blank line like the abov=
e
where I expect one in other places, so it is not very surprising.

> -- >8 --
> Subject: [PATCH] docs: give more hints about how "add -e" works
>
> The original text was not very descriptive about what you
> can and can't do; let's try to enumerate all cases.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/git-add.txt |   22 +++++++++++++++++++---
>  1 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index 45ebf87..b0a8420 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -86,9 +86,25 @@ OPTIONS
>  	edit it.  After the editor was closed, adjust the hunk headers
>  	and apply the patch to the index.
>  +
> -*NOTE*: Obviously, if you change anything else than the first charac=
ter
> -on lines beginning with a space or a minus, the patch will no longer
> -apply.
> +The intent of this option is to pick and choose lines of the diff to

I'd slightly prefer "patch" over "diff" in this context.

> +apply, or even to modify the contents of lines to be staged. There a=
re
> +three line types in a diff: addition lines (beginning with a plus),
> +removal lines (beginning with a minus), and context lines (beginning
> +with a space). In general, it should be safe to:
> ++
> +--
> +* remove addition lines (don't stage the line)

This is more like "don't add the line", isn't it?  Also if this "+" lin=
e
has corresponding "-" line (i.e. it is a "rewrite to this" line), remov=
al
of such a line would mean "instead of rewriting, remove it".

> +* modify the content of any addition lines (stage modified contents)

Would be "add differently".

> +* add new addition lines (stage the new line)

"Add more than what you have in the work tree"

While kibitzing like the above, I noticed that there is another thing t=
hat
may deserve warning even more.  Suppose you added lines and the patch
between HEAD and the work tree looks like this:

    diff --git a/t-f b/t-f
    index e69de29..d68dd40 100644
    --- a/t-f
    +++ b/t-f
    @@ -0,0 +1,4 @@
    +a
    +b
    +c
    +d

And you do "add -e" and edit the patch to:

    diff --git a/t-f b/t-f
    index e69de29..17c3f0b 100644
    --- a/t-f
    +++ b/t-f
    @@ -0,0 +1,3 @@
    +a
    +e
    +d

Obviously, the above patch is what "diff --cached" would show after suc=
h
an "add -e", but this does _not_ touch anything in the work tree (which=
 is
correct; add is about moving changed contents to the index and it shoul=
d
fundamentally not affect work tree).  As a result, "diff" between the
index and the work tree now would read like this:

    diff --git a/t-f b/t-f
    index 17c3f0b..d68dd40 100644
    --- a/t-f
    +++ b/t-f
    @@ -1,3 +1,4 @@
     a
    -e
    +b
    +c
     d

IOW, your request to "add -e" was "I do not want to put the addition of
'c' in the index at this point (that is why you removed '+c')" and "I d=
o
not want to put the addition of 'b' in the index; I want 'e' instead (t=
hat
is why you changed '+b' to '+e')".  After "add -e" granted both request=
s,
what is left in the work tree can confuse the user.  The "not at this
point" part of the first request is clearly visible that the leftover d=
iff
has an addition of '+c'.  But the user may expect that the second reque=
st,
"I don't want 'b', I want 'e'", would carry over to the work tree and n=
ot
see the apparent reversion of the wish (i.e. you changed it to add 'e'
instead of 'b' in "add -e" session, but it is reverted and "commit -a"
would record the version with 'b' instead).
