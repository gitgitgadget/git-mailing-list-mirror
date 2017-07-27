Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C8B22047F
	for <e@80x24.org>; Thu, 27 Jul 2017 00:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751427AbdG0AX1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 20:23:27 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:57736 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751078AbdG0AX0 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 26 Jul 2017 20:23:26 -0400
X-AuditID: 12074413-66dff70000000aee-bc-5979327d040f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 0B.0D.02798.D7239795; Wed, 26 Jul 2017 20:23:25 -0400 (EDT)
Received: from mail-io0-f173.google.com (mail-io0-f173.google.com [209.85.223.173])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v6R0NOlg015573
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Wed, 26 Jul 2017 20:23:25 -0400
Received: by mail-io0-f173.google.com with SMTP id c74so73748141iod.4
        for <git@vger.kernel.org>; Wed, 26 Jul 2017 17:23:24 -0700 (PDT)
X-Gm-Message-State: AIVw112Alui6ojfeLihRfw+rXxnjc0lCzqjKgc6H3WFBjxOxKiotLONj
        nM6ejduqR9SHS1mkBgIu/+2Cl3ezZQ==
X-Received: by 10.107.174.138 with SMTP id n10mr2913628ioo.331.1501115004431;
 Wed, 26 Jul 2017 17:23:24 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 10.107.129.91 with HTTP; Wed, 26 Jul 2017 17:23:23 -0700 (PDT)
In-Reply-To: <CAMy9T_FmE=8xzjRJJRxLwQjoMStJx5sYO_xtODv2OEZm54DurA@mail.gmail.com>
References: <87ziclb2pa.fsf@gmail.com> <20170704071909.phs4bf5ybdord2lv@tigra>
 <87van8boe9.fsf@gmail.com> <20170705083611.jgxbp4sqogicfwdb@sigill.intra.peff.net>
 <xmqqshiaizhz.fsf@gitster.mtv.corp.google.com> <xmqqo9sxdwjp.fsf@gitster.mtv.corp.google.com>
 <CAMy9T_FmE=8xzjRJJRxLwQjoMStJx5sYO_xtODv2OEZm54DurA@mail.gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Wed, 26 Jul 2017 17:23:23 -0700
X-Gmail-Original-Message-ID: <CAMy9T_HA1LcAo2pi27gPaRd4KZzTdT3tSYzV_CC8UBkbtk78RA@mail.gmail.com>
Message-ID: <CAMy9T_HA1LcAo2pi27gPaRd4KZzTdT3tSYzV_CC8UBkbtk78RA@mail.gmail.com>
Subject: Fwd: Should "head" also work for "HEAD" on case-insensitive FS?
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42IRYndR1K01qow0WLrf1KLrSjeTA6PH501y
        AYxRXDYpqTmZZalF+nYJXBnLH/1kK3ikWvFhYxNLA+MtuS5GTg4JAROJtRO3MIPYQgI7mCQa
        fup2MXIB2U+ZJL51fWaBcPoZJR639DBCdORL7LyzkgXCLpX4+vYhmM0rIChxcuYTFohJchKv
        NtxghLC9JTr7m9hAbE6BQIk1PfOYIIaeYpJ42zYPLMEmoCuxqKeZCcRmEVCVWLD7JBvEgkSJ
        Nc+WMUEsCJDobPkPtkBYwEPizb05YGeLCGhJ/Fm1F2wos8AMRolnF86DNTMLaEq0bv/NPoFR
        eBaSA2chSS1gZFrFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuul5tZopeaUrqJERLIwjsYd52U
        O8QowMGoxMPLML0iUog1say4MvcQoyQHk5Io7yRToBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR
        XiGFykgh3pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IE71QDoEbBotT0
        1Iq0zJwShDQTByfIcB6g4fdBaniLCxJzizPTIfKnGI05rlxZ94WJY8qB7V+YhFjy8vNSpcR5
        j+kDlQqAlGaU5sFNgyWjV4ziQM8J82YaAlXxABMZ3LxXQKuYgFbNmVEKsqokESEl1cAYonxk
        eUvBHx27rOA1h/hnR6kdPiCx7mOqTofL4q+JUU/9UhbKpi5Yda8vlnW97cNMHZ35a//2Pnpd
        HrlyVoV6rOZB15RT847tv7DyYPCWB6IBr5xPRbif8wzY+XXhrpzo7DBN1aMW+jHl/fPzNDq5
        9oetE5t/6kuXrIK27O8j8UeUnz4svFKmxFKckWioxVxUnAgAGIDFlSEDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dang, I just noticed that I hit "reply" rather than "reply-to-all" on
the below email (stupid GMail default). Junio, your response to this
email accordingly went only to me.

Michael

---------- Forwarded message ----------
From: Michael Haggerty <mhagger@alum.mit.edu>
Date: Mon, Jul 10, 2017 at 7:52 AM
Subject: Re: Should "head" also work for "HEAD" on case-insensitive FS?
To: Junio C Hamano <gitster@pobox.com>


On Fri, Jul 7, 2017 at 12:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
> [...]
> The exact detail of the encoding used here is immaterial, but I just
> used "encode uppercase letters and % as % followed by two hex",
> which was simple enough.  Usual refs/heads/master and friends will
> not have to be touched when encoded this way.  Perhaps the decoding
> side should be tweaked so that uppercase letters it sees needs to be
> downcased to avoid "refs/heads/Foo" getting returned as "Foo" branch,
> as a "Foo" branch should have been encoded as "refs/heads/%46oo".
>
> Having said that, this patch alone does not quite work yet.
>
>  * In the repository discovery code, we have some logic that
>    hard-codes the path in the directory (which is a candidate for
>    being a repository) to check, like "refs/" and "HEAD".  In the
>    attached illustration patch, files_path_encode() special cases
>    "HEAD" so that it is not munged, which is a bit of ugly
>    workaround for this.
>
>  * I haven't figured out why, but what refs.c calls "pseudo refs"
>    bypasses the files backend layer for some but not all operations,
>    which causes t1405-main-ref-store to fail.  The test creates a
>    "pseudo ref" FOO and then tries to remove it.  Creation seems to
>    follow the files-backend.c and thusly goes through the escaping;
>    refs.::refs_delete_ref() however does not consult files-backend.c
>    and fails to find and delete .git/FOO, because the creation side
>    encoded it as ".git/%46%4F%4F".

I think the most natural thing would be to use different encoding
rules for pseudo-refs (references like "HEAD" and "FETCH_HEAD") and
for other references (those starting with "refs/").

Pseudo-refs (with the partial exception of "HEAD") are quite peculiar
beasts. They sometimes include other information besides the reference
value and IIRC the refs code doesn't have any idea how to write or
read those extra contents. I believe that "HEAD" is the only pseudo
ref for which reflogs are ever written. Pseudo-refs have to match
/[A-Z_]+/ (see https://github.com/git/git/blob/8b2efe2a0fd93b8721879f796d848a9ce785647f/refs.c#L169-L173),
so ISTM that there is no need to encode such references' filenames at
all. (It's possible that the pattern could be made even stricter, like
/[A-Z_]+HEAD/.) Moreover, IIRC, such references are never scanned for
(as in for-each-refs) but rather are always asked for by name. So
their names might never have to be *de*coded, either. On the other
hand, when trying to look them up, it would be a good idea to verify
that the requested name satisfies the above naming rule. Other than
that, I believe it would be preferable to leave pseudo-refs untouched
by your new encoding/decoding code.

Whereas other references are typically lower-case, so it makes sense
for lower-case letters to be the ones that are passed through
transparently in such references' filenames (as in your scheme).

But...since we are talking about introducing a new loose reference
filename encoding, I think it would be a good idea to address a couple
of related issues at the same time:

* Some filesystems natively use Unicode, and insist on a particular
Unicode normalization (NFC vs NFD), which might differ from the
"upstream" normalization. So such reference names get munged when
written as loose references. I'm not enough of an expert in Unicode to
know what the best solution is, except for the strong feeling that it
would require some cooperation from the rest of Git to ensure a good
user experience.

* Another bad effect of our current loose reference encoding is that
it prohibits references that D/F conflict with each other (like
"refs/heads/foo" and "refs/heads/foo/bar") because
"$GIT_DIR/refs/heads/foo" can't be a file and a directory at the same
time. Even if we don't want to support that, this problem also
prevents us from storing reflogs for deleted references, which is a
serious flaw. We could solve this problem by encoding "directory"
components of reference names differently than "leaf" components; for
example, the above references could be encoded as
"refs/heads.d/foo.ref" and "refs/heads.d/foo.d/bar.ref".

It'd be nice to solve all of these related problems at the same time,
because whatever encoding we choose now will have to be supported
forever.

Michael
