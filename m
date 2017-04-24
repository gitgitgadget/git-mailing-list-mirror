Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 382F0207BD
	for <e@80x24.org>; Mon, 24 Apr 2017 01:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164074AbdDXB4G (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 21:56:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62577 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1164064AbdDXB4E (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2017 21:56:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B386880767;
        Sun, 23 Apr 2017 21:55:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7clvHP5vshJZ
        gg3XicAxsWtnlKU=; b=Ela3a0sU8WyRaDy8v5Rr7aZNIhyOHSu9HiBNM5ChsilA
        4DimsPWQ7bL8geYX0U0EMDzNvDmPcJw694rf9Xj/C5ESxilxzzf9pzq/KNp+BFZt
        6pyCfHJWyZxPfQoYUCuhYpAdSSNQ003Ou4OgsPFuQ3Nj+Dy1a68MjEaJtsKhv6k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=kcA7+w
        h8l2XfVTRp3HMVV2rKPTwxY/H64YFevOv/CkWJR9BLKyxlWYh7lmGREq9qVjXmRh
        fQao3qk0fDgi2p3MkxmrzcKg0sWB1Ma+S5PG5X0n0Z7DxlRypWmRIP1vH1qP0IcL
        ggYZh+QbnLlJJ7XycFDNKNpBFY2TsbPJdWSEY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AB09E80766;
        Sun, 23 Apr 2017 21:55:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 15F1C80764;
        Sun, 23 Apr 2017 21:55:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christoph Michelbach <michelbach94@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Documentation/git-checkout: make doc. of checkout <tree-ish> clearer
References: <1492287435.14812.2.camel@gmail.com>
        <9535BE255A654CADB7B0AE7599A6FA96@PhilipOakley>
        <1492347718.19687.14.camel@gmail.com>
        <2DCA89C3FDFF41E5B3651018BF837267@PhilipOakley>
        <1492368692.22852.9.camel@gmail.com>
        <DF5E72F5BD2F4BB99D8EC4DF1B4543F7@PhilipOakley>
        <1492380399.19991.13.camel@gmail.com>
        <5EBADDE444D141918F6873BE8456E026@PhilipOakley>
        <1492452173.11708.22.camel@gmail.com>
        <5FD0803E166B4D2F9F64D8D21AC23EB3@PhilipOakley>
        <xmqqa87eimje.fsf@gitster.mtv.corp.google.com>
        <1492518377.5720.47.camel@gmail.com>
        <xmqq1sspdvjk.fsf@gitster.mtv.corp.google.com>
        <1492881136.7368.3.camel@gmail.com>
Date:   Sun, 23 Apr 2017 18:55:55 -0700
In-Reply-To: <1492881136.7368.3.camel@gmail.com> (Christoph Michelbach's
        message of "Sat, 22 Apr 2017 19:12:16 +0200")
Message-ID: <xmqqo9vm36xg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 28638E34-2891-11E7-ABFC-C260AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christoph Michelbach <michelbach94@gmail.com> writes:

>> Care to send in a patch to update the documentation?

Thanks.  The attached patch text appears linewrapped, but I think
I'll be able to salvage, so forgetting about the formatting, here
are some comments.


> From: Christoph Michelbach <michelbach94@gmail.com>
> Date: Sat, 22 Apr 2017 18:49:57 +0200
> Subject: [PATCH] Doc./git-checkout: correct doc. of checkout
> <pathspec>...
>
> The previous documentation states that the named paths are
> updated both in the index and the working tree. This is not
> correct as those paths can point to folders which are not
> updated to what they are in the given tree-ish. Rather,
> the files pointed to by the pathspecs are copied from the

s/pointed to by/that match/

> tree-ish to the index and working tree One difference being

Missing full-stop after "tree".

> that one can name paths which are not present in the working
> tree ...

That one is not a difference, I would think.  If your current index
and working tree lack F, you give pathspec that match F, and the
tree-ish has that path F, that named path _is_ updated both in the
index and in the working tree.

> ... and another being that only files which are already
> present in the given tree-ish are affected.

This one indeed was missing piece of information.

> Signed-off-by: Christoph Michelbach <michelbach94@gmail.com>
> ---
> =C2=A0Documentation/git-checkout.txt | 16 +++++++++-------
> =C2=A01 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-
> checkout.txt
> index 8e2c066..f74f237 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -81,13 +81,15 @@ Omitting <branch> detaches HEAD at the tip of the
> current branch.
> =C2=A0'git checkout' [-p|--patch] [<tree-ish>] [--] <pathspec>...::
> =C2=A0
> =C2=A0	When <paths> or `--patch` are given, 'git checkout' does *not*
> +	switch branches.=C2=A0=C2=A0It copies the files matching the pathspec=
s in
> +	<tree-is> (i.e. a commit, tag, or tree) to the index and

<tree-ish> is misspelled here.  Drop (i.e. ...) as (1) it is not
correct (a tag may not point at a tree-ish) and (2) "checkout" is
not a place to learn what a tree-ish is (glossary is).

> +	subsequently to the working directory, overwriting changes

Do we need to say "subsequently" when we are aiming to be more
intelligible by not describing the order of execution?  The end
result is that the blobs named by the pathspecs from the tree-ish
are checked out to the index and to the working tree at the same
time.

> +...	Note that because the index is updated, the
> +	changes introduced by this command are automatically staged.

This is redundant and unnecessary, I would say.  If you absolutely
need to say this, at least drop "automatically".  There is nothing
automatic about it.  The user is asking to checkout the named blobs
out of the tree-ish to the index and to the working tree, and Git is
merely doing as it was told.

In addition the description is fuzzy; what are "changes introduced
by this command" relative to?  If you did "checkout HEAD path" after
editing path in the working tree, is "reverting my edit" the
"changes introduced by this command"?  If you did "checkout HEAD
path" after editing path, "git add path" and then editing path
further, what are the "changes introduced by this command"?
