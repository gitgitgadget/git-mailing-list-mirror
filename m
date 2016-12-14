Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F8AE1FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 18:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754372AbcLNSEv (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 13:04:51 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52878 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754366AbcLNSEu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 13:04:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A009357740;
        Wed, 14 Dec 2016 13:04:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XZgcxNcZlcl5lCWWpoF0DR1shmY=; b=GQbvMh
        VJD5XHFJyIFmVuBxl5p50XouVfjGDkMLQRlTFkhuGVqW3TH4zQJ9yqP9cT/UcY9v
        8JBv3EDxNBO/2keBSBHOtqT95CcmKwvIOXeSnFRbzq5Zfr517uOzxRlVaJXmeHtb
        /P6HDqu1bU3yjED566jOjtJe8gUfAzKK6esls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jCj81zZnZXItBeocchGEAfo/lTTUcnWu
        AyIoR0SSV0h/VJZW+/0/ijbbAvd8iNY1J5UuG7hUeLdObxLX/zB64t64kQZmqO1m
        uAOFc1f/arTLO+RebdoRnyI5OLcbGHQxMlpJlJ3ruxSqgO1aZE0ZmRvBv75SJleB
        PQx0wvANCtA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 97CCC5773E;
        Wed, 14 Dec 2016 13:04:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 021E45773D;
        Wed, 14 Dec 2016 13:04:47 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chris Packham <judge.packham@gmail.com>
Cc:     git@vger.kernel.org, mah@jump-ing.de, peff@peff.net,
        jacob.keller@gmail.com
Subject: Re: [PATCHv3 1/3] merge: Add '--continue' option as a synonym for 'git commit'
References: <20161213084859.13426-1-judge.packham@gmail.com>
        <20161214083757.26412-1-judge.packham@gmail.com>
Date:   Wed, 14 Dec 2016 10:04:46 -0800
In-Reply-To: <20161214083757.26412-1-judge.packham@gmail.com> (Chris Packham's
        message of "Wed, 14 Dec 2016 21:37:55 +1300")
Message-ID: <xmqqk2b2xu81.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD006406-C227-11E6-99D7-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The last one 3/3 is a nice touch that makes sure that we do not
forget what we discovered during the discussion.  Very much
appreciated.

Will queue.  Thanks.
