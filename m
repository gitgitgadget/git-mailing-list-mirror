Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	T_DKIM_INVALID shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A2DC1F859
	for <e@80x24.org>; Tue,  9 Aug 2016 18:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255AbcHISTO (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 14:19:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50133 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751774AbcHISTN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Aug 2016 14:19:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A234325A3;
	Tue,  9 Aug 2016 14:19:12 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=lD758ESUU32+
	H7fUw6FAzmOhbmk=; b=tr1UUITJ3zeJIiMfSxYB51qPf5Qx3cGJUeTLHqiBBoJw
	B+1OfZ+iSfN1fZzE5v+2QGGMGCdSfRHl2zqINTT2QO1p8wtQSMoPB+xOS2OZhH6q
	uYhORkFw/jhXgYG5pTioy52X+luE/LVfMW3lT95KfJ0ceDqKw2OtxQPoHvDS2yM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Xbzler
	FN7BjaQTW85kqufz10++Ds8szfvsa6sFY9BnO4Q2hyJuMWb5KZCT4SL25FWLcWWM
	swIDAkDmChKVnxH9RB/xitgdFgXYvlN/xU4m+264d5MJ1FeKNe/dBSAZv7y6W4Lc
	WA5bXD6xOBz3HllfczvyR4iNG8LRBLG+Hy0u0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 30C73325A2;
	Tue,  9 Aug 2016 14:19:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AA397325A0;
	Tue,  9 Aug 2016 14:19:11 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Ville =?utf-8?Q?Skytt=C3=A4?= <ville.skytta@iki.fi>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] Spelling fixes
References: <1470732818-408-1-git-send-email-ville.skytta@iki.fi>
Date:	Tue, 09 Aug 2016 11:19:09 -0700
In-Reply-To: <1470732818-408-1-git-send-email-ville.skytta@iki.fi> ("Ville
	=?utf-8?Q?Skytt=C3=A4=22's?= message of "Tue, 9 Aug 2016 11:53:38 +0300")
Message-ID: <xmqqpophajqa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C555F190-5E5D-11E6-9FA1-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Ville Skyttä <ville.skytta@iki.fi> writes:

> Signed-off-by: Ville Skyttä <ville.skytta@iki.fi>
> ---
>  Documentation/RelNotes/2.3.10.txt           | 2 +-
>  Documentation/RelNotes/2.4.10.txt           | 2 +-
>  Documentation/RelNotes/2.5.4.txt            | 2 +-
>  Documentation/RelNotes/2.6.1.txt            | 2 +-
>  Documentation/git-remote-fd.txt             | 2 +-
>  Documentation/gitattributes.txt             | 2 +-
>  Documentation/gitmodules.txt                | 2 +-
>  contrib/hooks/multimail/README              | 4 ++--
>  contrib/mw-to-git/.perlcriticrc             | 2 +-
>  contrib/mw-to-git/git-remote-mediawiki.perl | 2 +-
>  contrib/subtree/t/t7900-subtree.sh          | 2 +-
>  git-p4.py                                   | 2 +-
>  sha1_file.c                                 | 2 +-
>  t/README                                    | 2 +-
>  t/t1006-cat-file.sh                         | 2 +-
>  t/t3101-ls-tree-dirname.sh                  | 2 +-
>  t/t6018-rev-list-glob.sh                    | 2 +-
>  t/t6030-bisect-porcelain.sh                 | 2 +-
>  t/t7001-mv.sh                               | 8 ++++----
>  t/t7810-grep.sh                             | 2 +-
>  t/t9401-git-cvsserver-crlf.sh               | 2 +-
>  upload-pack.c                               | 2 +-
>  22 files changed, 26 insertions(+), 26 deletions(-)

Wow, that's a lot of typos.  I asked "git show --word-diff" what got
changed, which told me this:

    <BAD>                     <CORRECTED>

    accidently                accidentally
    commited                  committed
    dependancy                dependency
    emtpy                     empty
    existance                 existence
    explicitely               explicitly
    git-upload-achive         git-upload-archive
    hierachy                  hierarchy
    intial                    initial
    mulitple                  multiple
    non-existant              non-existent
    precendence.              precedence.
    priviledged               privileged
    programatically           programmatically
    psuedo-binary             pseudo-binary
    soemwhere                 somewhere
    successfull               successful
    unkown                    unknown
    usefull                   useful
    writting                  writing

and then looked at all lines in the patch.  They all looked
reasonable.

There are two "commited" you seem to have missed, though,

t/t3420-rebase-autostash.sh:    echo uncommited-content >file0 &&
t/t3420-rebase-autostash.sh:    echo uncommited-content >expected &&

which I'll queue on top of this patch to be later squashed (i.e. no
need to resend the whole thing only to add these two).

Thanks.
