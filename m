Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F6F91FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 17:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754382AbcLPR5X (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 12:57:23 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50151 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753056AbcLPR5W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 12:57:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CAC0A54EE2;
        Fri, 16 Dec 2016 12:57:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7wBpjyBig1EW/1lkB/hh6U9hUDs=; b=bYYrOy
        tZ7lm+TlOXAyt3KaLs4AU5dsKMFXCq7yHph7gT47N66xXBzsYhkqV6F9yAqs9AG6
        /CGtn7jlDMcFceRCcAq8YcjrCCP2TKW4oRKqKuEkZGd+lQwISiqG+B9ReBKIGTiy
        sIGMOpDxnZGHMue7D/CqZkEv4BTVwJXerigbc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YzBWhSIMP4oMh7hJohYdQB2qp5r5FbRL
        IcvJYywDJdhWesICxWw/pdXvkK7bg4BZQENt48eJMXBedNIgXrWv5ZazNhEXQZXE
        T9sHnQYpWXYvywsuuGGn66LDLFjXFI2IRs0If33N0hKmuSTC+wN8aR+qGYuUK037
        MvUQtBkDoGw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C18BF54EE1;
        Fri, 16 Dec 2016 12:57:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 33C3954EDD;
        Fri, 16 Dec 2016 12:57:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Jeff King <peff@peff.net>, Chiel ten Brinke <ctenbrinke@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] README: replace gmane link with public-inbox
References: <CAFw20syajXbjCQRcrqCv8pS9JwSge7-V4Hsg96n8SpYv2jJneQ@mail.gmail.com>
        <20161215141719.52peppv5pbjk3nuf@sigill.intra.peff.net>
        <20161215215702.GA28777@starla>
Date:   Fri, 16 Dec 2016 09:57:19 -0800
In-Reply-To: <20161215215702.GA28777@starla> (Eric Wong's message of "Thu, 15
        Dec 2016 21:57:02 +0000")
Message-ID: <xmqqbmwbu58g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 16EC0862-C3B9-11E6-BCB2-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Jeff King <peff@peff.net> wrote:
> ...
>> Yes, the status of gmane was up in the air for a while, but I think we
>> can give it up as dead now (at least for our purposes).
>
> s/http/nntp/ still works for gmane.
> ...
>> -- >8 --
>> Subject: README: replace gmane link with public-inbox
> ...
> No objections, here.
>
> There's also https://mail-archive.com/git@vger.kernel.org
> Where https://mid.mail-archive.com/<Message-ID> also works

Yes, but do we want to be exhaustive here, of just cite one that is
a useful starting point?  I think it is the latter.

Mentioning nntp for those who prefer (including me) may have value,
though.

 README.md | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/README.md b/README.md
index c0cd5580ea..91704fe451 100644
--- a/README.md
+++ b/README.md
@@ -34,7 +34,8 @@ requests, comments and patches to git@vger.kernel.org (read
 To subscribe to the list, send an email with just "subscribe git" in
 the body to majordomo@vger.kernel.org. The mailing list archives are
 available at https://public-inbox.org/git,
-http://marc.info/?l=git and other archival sites.
+http://marc.info/?l=git and other archival sites.  
+Those who prefer NNTP can use nntp://news.public-inbox.org/inbox.comp.version-control.git
 
 The maintainer frequently sends the "What's cooking" reports that
 list the current status of various development topics to the mailing




