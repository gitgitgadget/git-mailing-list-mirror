Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 874CC202F2
	for <e@80x24.org>; Tue, 21 Nov 2017 00:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751875AbdKUAVQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 19:21:16 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51416 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751800AbdKUAVM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 19:21:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 68491BAC29;
        Mon, 20 Nov 2017 19:21:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aL2wjQfRkPPOfZWmvgEOL/QcKpk=; b=PKGvRZ
        bZOlYIoRFB7LRzd1ViIInkS4xZFRqU67ed/tNRyuZXDRIPiTJThabzh/lsAFcCRW
        xwncXzJk4hjzN96vtfEShl+onqSBYXbfSmizUicYwP5xO93nIg4dYqLmaVjEcQvD
        Yl4T2TYdPaASzfb7cNyuQpktwhQbQlM55lBEY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SH3aYLVrjJwu/1lr9s1mIv8akhgziPY7
        s88+PMK5xoQSndplIBOkxb9hi5Ie3MAbUy+ERzt0n73oSqiTEVm5ViGiqKR77ViU
        Tc7wDKwgzEbdnKdMIP5gy536bPayi401BTaj6SEhdbqG97rvnrdkw7qikiikeTKD
        86Udxbm+90Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5FB40BAC27;
        Mon, 20 Nov 2017 19:21:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D274ABAC25;
        Mon, 20 Nov 2017 19:21:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     Alex Vandiver <alexmv@dropbox.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Nov 2017, #05; Fri, 17)
References: <xmqqbmk1sabs.fsf@gitster.mtv.corp.google.com>
        <xmqq375ds99m.fsf@gitster.mtv.corp.google.com>
        <MWHPR21MB047824EDFD7AE4EC39256E7FF4220@MWHPR21MB0478.namprd21.prod.outlook.com>
Date:   Tue, 21 Nov 2017 09:21:09 +0900
In-Reply-To: <MWHPR21MB047824EDFD7AE4EC39256E7FF4220@MWHPR21MB0478.namprd21.prod.outlook.com>
        (Ben Peart's message of "Mon, 20 Nov 2017 13:49:24 +0000")
Message-ID: <xmqqmv3glbwq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E04B49B8-CE51-11E7-A46F-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <Ben.Peart@microsoft.com> writes:

> As far as I can tell, the patches are good.  I'm not aware of
> anything else that should hold it up.

Great; thanks.
