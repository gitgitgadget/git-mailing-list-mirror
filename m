Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB1BE1F935
	for <e@80x24.org>; Wed, 21 Sep 2016 18:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933504AbcIUSRI (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 14:17:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63141 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932340AbcIUSRH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 14:17:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 657E53EE9B;
        Wed, 21 Sep 2016 14:16:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IutKrUgPCEHZxejU3R19fkmhxmU=; b=r1Ac+n
        Ya3ji6aX34iW+f54CAePDmXTNWsiYRadG0QGtomdt0920u9fyIrWpF60asU/Q9g8
        rCwKEGZNG5b1FoPaBflAd+TnFFy73WClZsXlOrardRKyTp8vECx+ArUGaSgPsAW/
        UGmyXVGbiQh10rXgfjfR7/6hiSlRWdMcKIIhI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PVTmqEW+FZX+dmVi7zrPZMTVkZd1ojxx
        cyUEhnDFZaD+UJWfk8YdJJ6Be1JdcjAK8vEefOK1S2fLmE1GDRbWI/Y2Z8mCOiF1
        G+KMTSl753a0B8RTS7CHdL69+7LYdKVvC1N+MlunZ9sC/HR0REDBiDoQ3qNtLeDH
        XROUX0l2Qzo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D0B43EE9A;
        Wed, 21 Sep 2016 14:16:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D81ED3EE98;
        Wed, 21 Sep 2016 14:16:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: git-gui, was Re: [PATCH v2 6/6] git-gui: Update Japanese information
References: <1474378663.1884.41.camel@sapo.pt>
Date:   Wed, 21 Sep 2016 11:16:21 -0700
In-Reply-To: <1474378663.1884.41.camel@sapo.pt> (Vasco Almeida's message of
        "Tue, 20 Sep 2016 13:37:43 +0000")
Message-ID: <xmqqlgyl86fe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 81133902-8027-11E6-B845-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> I have sent some git-gui patches on May this year and I think it will
> add value to accepted them at some point:

Yeah, they may be of value, but the thing is, I am not really in the
position to review or apply them (I don't do git-gui).

If Pat is not going to return, we would need to find volunteers to
be maintainers of "git-gui" first.

Thanks.  I may get to these patches when/if I find time, but it is
not likely to happen very soon.

