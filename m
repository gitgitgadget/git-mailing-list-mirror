Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4697D207BC
	for <e@80x24.org>; Wed, 19 Apr 2017 01:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933067AbdDSBkg (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 21:40:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61120 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758918AbdDSBke (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 21:40:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 79499817ED;
        Tue, 18 Apr 2017 21:40:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=gHov/m+ZMcEU
        lBrJe5YYR6WygCA=; b=HTRfa0Qzjnwo9UEzJyCrEuN1EhM3yhW937VGt3tKcnG1
        IY06fkWMrYNG1fqyWR+iOhEdXzgc4uFZnFmWguC4Q++3lO3x13VBnq32TJjJdY/A
        c9F9Zn2OKo18Yyq8GiiEY1rXszSZZPrtSl0CdDLHps2iVexi/BAM/Y4UiTPhvhY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=mPLQ08
        tz56xqsI9ddBVI4tP8t0EufZJeDMfQ+EsD39EpL/WfVDsJCsUMr7bNcXO6CwCZlv
        +ZzFqwauNJmwJFvbSLNjZSGUQDbMbnq1RDBJewkOG0IMlb6+dl5/IFLrZsk3ucS5
        SBPsCTNkzH+DaFTL3I0GvvuE2cj8bVRJ9+81E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 72BE8817EC;
        Tue, 18 Apr 2017 21:40:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D7F4E817EA;
        Tue, 18 Apr 2017 21:40:32 -0400 (EDT)
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
Date:   Tue, 18 Apr 2017 18:40:31 -0700
In-Reply-To: <1492518377.5720.47.camel@gmail.com> (Christoph Michelbach's
        message of "Tue, 18 Apr 2017 14:26:17 +0200")
Message-ID: <xmqq1sspdvjk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2D73FF88-24A1-11E7-89AA-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christoph Michelbach <michelbach94@gmail.com> writes:

> On Mon, 2017-04-17 at 17:31 -0700, Junio C Hamano wrote:
>
>> Obviously, "grab all paths that match <pathspec> out of <tree>, add
>> them to the index and copy them out to the working tree" will never
>> be able to _restore_ the lack of 'd', even it may match the
>> <pathspec> being used to do this checkout, by removing it from the
>> current index and the working tree.
>
> Exactly.=C2=A0"grab all paths that match <pathspec> out of <tree>, add =
them
> to the index and copy them out to the working tree" is a more accurate
> description of what the command does (but it might need some rewording
> ;-) ).

Of course it is accurate, as that is how I would write it, not
"restore", if I were doing the documentation.

Care to send in a patch to update the documentation?
