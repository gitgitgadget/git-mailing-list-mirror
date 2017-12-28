Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A87001F406
	for <e@80x24.org>; Thu, 28 Dec 2017 19:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754053AbdL1TCG (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 14:02:06 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50200 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751074AbdL1TCF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 14:02:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 57E83CA471;
        Thu, 28 Dec 2017 14:02:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5t93v7b32zfDaFchQ56WizZtvxw=; b=TTjAv0
        lawHA1/HPqQEIlHstUcnZKLCmGHliRyBR8V5TPuPqZutonK0QvJ3dAACPTVvoWWT
        qo8Q9oF+SW8iWBuFaAi9M+s87+UGLf63xVCm0RUHsj5QNXfccYvGoObItrVWdmH6
        3/lUBRmbEVI8bcntXXgkoLl/+Sh2sdokLFnUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q+mjIc3G947upmynio49d8SJKFjEwHAh
        KKbmrfBnVW0BGOeBeaKsHqYddx01erXynksCM0+QgD/7eNmlsdP4lg0Y5DucU2Lb
        Miz7P//oLCNY8zTvgv7nVAZztAS27ykIoSv4a1DZugjQjYlZr//xSqIoCkKgRlNS
        W6rK0GEvfO0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 50B84CA470;
        Thu, 28 Dec 2017 14:02:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C00F1CA46F;
        Thu, 28 Dec 2017 14:02:04 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Dec 2017, #05; Wed, 27)
References: <xmqq608rn9ca.fsf@gitster.mtv.corp.google.com>
        <CABPp-BHxcFU+e4OgccWb+LgLbMo5sJsNjYFQb=WnxViTFdOu=g@mail.gmail.com>
Date:   Thu, 28 Dec 2017 11:02:03 -0800
In-Reply-To: <CABPp-BHxcFU+e4OgccWb+LgLbMo5sJsNjYFQb=WnxViTFdOu=g@mail.gmail.com>
        (Elijah Newren's message of "Wed, 27 Dec 2017 17:09:34 -0800")
Message-ID: <xmqqh8sallqs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 980A1A12-EC01-11E7-A4F0-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> surprised by the branch name, though.  Was 'ew/' a typo,

Blush X-<.  Yes it is a typo.
