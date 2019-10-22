Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D60F1F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 23:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731822AbfJVXwA (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 19:52:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62141 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731767AbfJVXwA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 19:52:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1615A39A65;
        Tue, 22 Oct 2019 19:51:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MAEmuOhtICCuiMM7DP/XwS7KyW4=; b=QS9pJl
        VWsWRbb+HsvAuxo+zRPaRCMhJ0OCWDywCpyIZtVXwg8XaZxAQBvgSoNJiNrlBfMU
        b3oMCI7+hyl4/+jipkWwApc2IVm+M0aPyR5lH1dNfqoxKNlTN5F61VnN0eBEtFCx
        rf6kFGtApGyKqd/6QBGBlmKRXIRxZczcPUiJM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UQNsPgHz3UgxcoqUtUgrYvZIEIe10qpW
        BFMae7wMWmNPR6JPC0FcCso9upowWuy5m8zZvh7H2YBX3Ey/sBdj88DkVheVTCIm
        +/QRc23M/99prEmwpVQwIBK4HCO+zH0aYffBaWd6W2ZJSJ4doZfRhIFbP+hpXzoM
        20P5oFtZtOc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0CCB939A63;
        Tue, 22 Oct 2019 19:51:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 643B439A62;
        Tue, 22 Oct 2019 19:51:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH 1/1] documentation: remove empty doc files
References: <pull.412.git.1571768375.gitgitgadget@gmail.com>
        <ffdde613d8ea2dc57719594aa0f89b6d6177b636.1571768375.git.gitgitgadget@gmail.com>
        <20191022210458.GE9323@google.com>
Date:   Wed, 23 Oct 2019 08:51:56 +0900
In-Reply-To: <20191022210458.GE9323@google.com> (Emily Shaffer's message of
        "Tue, 22 Oct 2019 14:04:58 -0700")
Message-ID: <xmqqtv80jq3n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EEBAACAC-F526-11E9-9357-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> As for the content of this change, I absolutely approve. I've stumbled
> across some of these empty docs while looking for answers before and
> found it really demoralizing - the community is so interested in
> teaching me how to contribute that they've sat on a TODO for 12 years?
> :( I even held up api-grep.txt as a (bad) example in a talk I gave this
> year. I'm happy to see these files go.

I'd approve this move, too, especially if we accompanied deletion
with addition (or verification of existence) of necessary docs
elsewhere (perhaps in *.h headers).

