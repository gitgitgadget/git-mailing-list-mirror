Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BD8C77B73
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 02:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbjDTCtT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 22:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjDTCtO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 22:49:14 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744F4E5A
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 19:48:46 -0700 (PDT)
Date:   Thu, 20 Apr 2023 02:48:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1681958924; x=1682218124;
        bh=QOYAqcKfZINj4X3hX2SZ7dGrdo+fB1xOBPdXe87rsvs=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=EqcrtbGZ2A8yAyx1/ERye1CcUtaH0F131W23Fn8W88sJuXDFYFPYX334xLWCTjBy5
         UK6J75jAZun6qhgBEB/kzn6IQV8pi7FK77oZ2HnS8UxEayxnAxVH3TylmV2h8WISBS
         KbMcIgZXS9n81z7FMQTlLccrIgj65VR7R2VHxnvLbZKb6p6oxhe6Zs76j6glqXNggn
         tdOycSIdwzf0u4Zpi2jZQuUhSbi/vkknmjt+m4XLwU8Grnrd+bqVXMZhELt7pF5ifF
         mt3Nlh0LPFN5P2ATVzUtsp1oNtC4WMlO0MIJE7RiIdoMlicSrXqG62QOIL2xZwRIr1
         Pcf124B6Pw/Jw==
To:     Junio C Hamano <gitster@pobox.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v9 4/8] t2400: add tests to verify --quiet
Message-ID: <auz2uadzp3k2b3ycmut6hhqelatwgnodrpqg7kalf2amzjknmq@gnqwpwzeomm3>
In-Reply-To: <xmqqfs8yjisl.fsf@gitster.g>
References: <20230417093255.31079-1-jacobabel@nullpo.dev> <20230417093255.31079-5-jacobabel@nullpo.dev> <xmqqfs8yjisl.fsf@gitster.g>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/04/17 02:33PM, Junio C Hamano wrote:
> Jacob Abel <jacobabel@nullpo.dev> writes:
>
> > [...]
>
> It is good to test the --quiet option.  It is not good to have the
> ineffective "cat actual" when test_must_be_empty is already used.
> Probably the same comment applies to the rest of the patch.
>
> Thanks.

Understood. As mentioned in the patch 2/8 discussion, this change (the `cat
actual`) will be reverted in the next revision.

