Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D2EB1FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 21:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754311AbcHZVaS (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 17:30:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61680 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754205AbcHZVaR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 17:30:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 37DBE3950A;
        Fri, 26 Aug 2016 17:27:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DbouP5n7/q+bkqAwLqs1u3GwZd8=; b=GwotTS
        k6t05ul8ZAWvkjJJ3uHjlNK07dWCkj8k+JS5nVF87KkXxxvTNFdo89mTYOyzwIxQ
        b3NNk+8ESBQ5keakAnbOUh3DH+yk57/KHY3x7MoGiA+QrLbnoKT2yWLZuU2ZmLYx
        ZukAnQYftZTyzONtSeP7RlpPW8RYZ5x1rnsrY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R24BoEJDjHhxxnP8+e5LDcJf9pgGTI6A
        HuTZHPDzzn3DONrgwKhLc1s5jAf6solyFKMV1CG5gkKIYB/kT1G418LCqyBAxLVs
        1lZNJWTmgwouv8bQ/1ZZv5iaHiCVB6CwhvCEFMMpUQ31mGjF/7K79NR4DrLhPLiU
        rLi0gf+0Tg0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 311CA39509;
        Fri, 26 Aug 2016 17:27:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AF9D739508;
        Fri, 26 Aug 2016 17:27:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     Stefan Beller <sbeller@google.com>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/2] gitk: align the commit summary format to the documentation
References: <1472230741-5161-1-git-send-email-dev+git@drbeat.li>
        <xmqqoa4fgzhv.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbL13b=iZiFKW8a=G+2zXRSwjYDTzu2TS47Ppohgzm0Gg@mail.gmail.com>
        <6afee090-fbe1-5d05-1f7e-6f0fc4901418@drbeat.li>
Date:   Fri, 26 Aug 2016 14:27:49 -0700
In-Reply-To: <6afee090-fbe1-5d05-1f7e-6f0fc4901418@drbeat.li> (Beat Bolli's
        message of "Fri, 26 Aug 2016 22:27:29 +0200")
Message-ID: <xmqqtwe7dxuy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F19E0606-6BD3-11E6-8467-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Beat Bolli <dev+git@drbeat.li> writes:

> On 26.08.16 21:16, Stefan Beller wrote:
>> I agree we should fix that.
>
> So would you prepare a amendment to your documentation commit so that
> Junio can disregard my two patches?

I think the mention of gitk having a feature to easily give you a
commit name in the preferred format added by your 2/2 is worth
keeping.  I am not Stefan, though ;-)
