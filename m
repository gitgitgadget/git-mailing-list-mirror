Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E84AF20ABE
	for <e@80x24.org>; Wed, 11 Jan 2017 21:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756365AbdAKVgN (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 16:36:13 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63246 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753178AbdAKVgN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 16:36:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C2D675FFB1;
        Wed, 11 Jan 2017 16:36:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0Y6bkZdI/8GEQI31zP6g94wN3oM=; b=u2bZ6r
        ILt0SP1dt0JoScOoPDYbmz82oYPLMGoDRIRlMIujO+nat6ExvAC+oF91Q7lQ6yXJ
        gXFkM2yG6wSOJd3r13hGNWouoVDawETBnUJHbbMsyshxSkBlnMx5Hgp9pQd9V3yD
        V17sG10XIC+nAuj0Ft/EaOcyueg93o3jxPzCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KPR+0arEg8g8CtKwNdCzaVUV7IiPKRPN
        X+W4/qZXjhFre02A/BYVtR8R5qIZPFmdBTglltJkUt6THRzRQYM+IGTNcZrJ+29B
        ll8/DZ6sohpH+tWPmJU13D99l/bb0wurylhAtJt+8nNDa9D9UFt9TWy7rxFpAfOQ
        y/M118EZMd0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA9665FFAF;
        Wed, 11 Jan 2017 16:36:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 284CD5FFAE;
        Wed, 11 Jan 2017 16:36:11 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] index: improve constness for reading blob data
References: <20170110200610.146596-1-bmwill@google.com>
Date:   Wed, 11 Jan 2017 13:36:09 -0800
In-Reply-To: <20170110200610.146596-1-bmwill@google.com> (Brandon Williams's
        message of "Tue, 10 Jan 2017 12:06:10 -0800")
Message-ID: <xmqqy3yhmg8m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F851835E-D845-11E6-81D0-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Improve constness of the index_state parameter to the
> 'read_blob_data_from_index' function.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---

Thanks.
