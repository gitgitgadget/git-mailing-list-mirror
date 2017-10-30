Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76CC1202A0
	for <e@80x24.org>; Mon, 30 Oct 2017 04:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751699AbdJ3E2I (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 00:28:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53209 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750750AbdJ3E2H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 00:28:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4E3195060;
        Mon, 30 Oct 2017 00:28:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gDWpqNV58yPESBSBVpdr+E6bJmw=; b=fbUnDV
        cz3BxRYuY4O8AftjsUQMIDWDE3oCF+Tu7PibdtrVArtFtxQlUwaFgrWiWq8JJW3u
        +6yX13nGkslyy1bWa9Ze4kMZZHs3ybOzaXCT69b3AfbmscxxqWJKccFJ99A24HFG
        vfTcKPUYK8QGczvCVHKNVdRlWmOt1wATO0Zus=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DBmbU84dtekGFSK6JmThLhNYZF0FH8Wd
        OsitnY7ZpQvmZfvTNeSySI3SQY6y5NvkcFJJ1/NLz9fcyaufVz/Hr18m6wUThneq
        dR53F109xUK8plxUQwOtOTwGZjr9sL7ipWVbHJ+a5IwxB7WwlG1NYc/dxBm5FJzf
        dc6JjZqzoQk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BC2659505F;
        Mon, 30 Oct 2017 00:28:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3E2D39505E;
        Mon, 30 Oct 2017 00:28:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] Documentation: convert SubmittingPatches to AsciiDoc
References: <20171029211308.272673-1-sandals@crustytoothpaste.net>
        <20171029211308.272673-3-sandals@crustytoothpaste.net>
Date:   Mon, 30 Oct 2017 13:28:05 +0900
In-Reply-To: <20171029211308.272673-3-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 29 Oct 2017 21:13:08 +0000")
Message-ID: <xmqqa8096yzu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9DDB47E-BD2A-11E7-8F13-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

Thanks.  I personally prefer the plain-text original, but I do
understand the need to have a version with ids that you can tell
others to visit in their browsers.  Assuming that this goes in the
right direction, here are a few comments.

> @@ -58,8 +65,9 @@ differs substantially from the prior version, are all good things
>  to have.
>  
>  Make sure that you have tests for the bug you are fixing.  See
> -t/README for guidance.
> +'t/README' for guidance.

I am guessing that, from the way you updated 'next' to `next'
etc. in the previous hunk, you are typesetting in <tt> anything a
reader may type literally without substitution.

Should this be `t/README`, as it is a part of something a reader may
type literally (as in "less t/README")?

> @@ -84,41 +92,45 @@ turning en_UK spelling to en_US).  Obvious typographical fixes are much
> ...
>  changes do not trigger errors with the sample pre-commit hook shipped
> -in templates/hooks--pre-commit.  To help ensure this does not happen,
> -run "git diff --check" on your changes before you commit.
> +in templates/hooks{litdd}pre-commit.  To help ensure this does not happen,
> +run `git diff --check` on your changes before you commit.

The pathname templates/hooks--pre-commit is typeset just like any
body text?

> @@ -154,8 +173,10 @@ sending out, please make sure it cleanly applies to the "master"

Out of context, but "master" we see above should probably be
`master` here, to be in line with what you did in an earlier hunk.
So should "next" we see below in the pre-context of this hunk.

> -(4) Sending your patches.
> +[[send-patches]]
> +=== Sending your patches.
> +:1: footnote:[The current maintainer: gitster@pobox.com]
> +:2: footnote:[The mailing list: git@vger.kernel.org]

Having to see these footnotes upfront is somewhat distracting for
those of us who prefer to use this file as a text document.  I see
these become part of the footnotes section at the very end of the
document (as opposed to the end of this section), so even with the
rendered output it does not look ideal.

I am not sure how much these two points matter, though.

> @@ -191,7 +212,7 @@ not ready to be applied but it is for discussion, [PATCH v2],
> ..
>  Send your patch with "To:" set to the mailing list, with "cc:" listing
>  people who are involved in the area you are touching (the output from
> -"git blame $path" and "git shortlog --no-merges $path" would help to
> ++git blame _$path_+ and +git shortlog {litdd}no-merges _$path_+ would help to
>  identify them), to solicit comments and reviews.

The +fixed width with _italics_ mixed in+ mark-up is something not
exactly new, but it is rarely used in our documentation set, so I
had to double check by actually seeing how it got rendered, and it
looked alright.

>  After the list reached a consensus that it is a good idea to apply the
> -patch, re-send it with "To:" set to the maintainer [*1*] and "cc:" the
> -list [*2*] for inclusion.
> +patch, re-send it with "To:" set to the maintainer{1} and "cc:" the
> +list{2} for inclusion.
>  
>  Do not forget to add trailers such as "Acked-by:", "Reviewed-by:" and
>  "Tested-by:" lines as necessary to credit people who helped your
>  patch.

Should these "Foo-by:" all be `Foo-by:`?

> @@ -302,85 +325,86 @@ D-C-O.  Indeed you are encouraged to do so.  Do not forget to
> ...
> +. "Reported-by:" is used to credit someone who found the bug that
> +  the patch attempts to fix.
> +. "Acked-by:" says that the person who is more familiar with the area
> +  the patch attempts to modify liked the patch.
> +. "Reviewed-by:", unlike the other tags, can only be offered by the
> +  reviewer and means that she is completely satisfied that the patch
> +  is ready for application.  It is usually offered only after a
> +  detailed review.
> +. "Tested-by:" is used to indicate that the person applied the patch
> +  and found it to have the desired effect.

Ditto.

> -An ideal patch flow
> +[[patch-flow]]
> +== An ideal patch flow
>  
>  Here is an ideal patch flow for this project the current maintainer
>  suggests to the contributors:
>  
> - (0) You come up with an itch.  You code it up.
> +. You come up with an itch.  You code it up.
>  
> - (1) Send it to the list and cc people who may need to know about
> -     the change.
> +. Send it to the list and cc people who may need to know about
> +  the change.
> ++
> +The people who may need to know are the ones whose code you
> +are butchering.  These people happen to be the ones who are
> +most likely to be knowledgeable enough to help you, but
> +they have no obligation to help you (i.e. you ask for help,
> +don't demand).  +git log -p {litdd} _$area_you_are_modifying_+ would
> +help you find out who they are.
>  
> -     The people who may need to know are the ones whose code you
> -     are butchering.  These people happen to be the ones who are
> -     most likely to be knowledgeable enough to help you, but
> -     they have no obligation to help you (i.e. you ask for help,
> -     don't demand).  "git log -p -- $area_you_are_modifying" would
> -     help you find out who they are.
> +. You get comments and suggestions for improvements.  You may
> +  even get them in a "on top of your change" patch form.
>  
> - (2) You get comments and suggestions for improvements.  You may
> -     even get them in a "on top of your change" patch form.
> +. Polish, refine, and re-send to the list and the people who
> +  spend their time to improve your patch.  Go back to step (2).

Not a complaint, but it is a shame that we have to spell out (2)
even though we are using auto-numbering feature here.

>  
> - (3) Polish, refine, and re-send to the list and the people who
> -     spend their time to improve your patch.  Go back to step (2).
> +. The list forms consensus that the last round of your patch is
> +  good.  Send it to the maintainer and cc the list.
>  
> - (4) The list forms consensus that the last round of your patch is
> -     good.  Send it to the maintainer and cc the list.
> -

By the way, to those of us who are interested in "readble diffs" may
find this hunk a bit interesting to study.  We should be able to
pair "-deleted" blocks of lines with corresponding "+added" blocks
more sensibly.

> @@ -452,23 +475,24 @@ should come after the three-dash line that signals the end of the
> ...
> +=== Pine
>  
>  (Johannes Schindelin)
>  
> +....
>  I don't know how many people still use pine, but for those poor
>  souls it may be good to mention that the quell-flowed-text is
>  needed for recent versions.
>  
>  ... the "no-strip-whitespace-before-send" option, too. AFAIK it
>  was introduced in 4.60.
> +....
>  (Linus Torvalds)
>  
>  And 4.58 needs at least this.

This line alone in the entire section for pine is done in regular
text, which looked somewhat strange.

