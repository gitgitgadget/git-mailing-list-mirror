Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A97B1F462
	for <e@80x24.org>; Tue, 28 May 2019 20:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfE1Ukv (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 16:40:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53140 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfE1Ukv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 16:40:51 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 18E261455E4;
        Tue, 28 May 2019 16:40:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/K2ZSCvbBLTZ
        jqGe73u3dtENUF4=; b=UYrGnjjHpKS64ZYDTdTgcC3DaMGbBdIreHn9RF1AVc8B
        mrL6wWAuwPxBRaoVZxBF4VMejg8OtN4GBvLAcqjR38Co+bxkzcFbEQj62KOKJNEN
        zdjqZpLgQUR4NjNIHg3mdQO9qZv1WwfVMWWx1qLfMsRvm11Jw7mE1+ZEaCXH0Yc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=uGJrMV
        6m0bcFMhDMWJgpwaImXwvff34ba1CvlGy7IPLIDupSikdpPN0ggenbTUkconsQmj
        ZFLMeD9Wdn/DMa4Fus2KfeXgPcpfpmjBTio0cLehI/yhqhg+LrFPE+RQFDqv+5zC
        1ScMn2/pcf5/B61YqlKU/L1iQ5gineAgJCQlY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 11DA51455E2;
        Tue, 28 May 2019 16:40:49 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7D4591455DF;
        Tue, 28 May 2019 16:40:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?5p6X6Ieq5Z2H?= <johnlinp@gmail.com>
Cc:     John Lin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] status: remove the empty line after hints
References: <pull.196.git.gitgitgadget@gmail.com>
        <468be8f85426ccf588ad558fab3c8927ef58627f.1557917642.git.gitgitgadget@gmail.com>
        <CAKO26MsGpEcK74CSdgNGjFdKAMDP5Knm+0_vtcnrBBJjBfjcQA@mail.gmail.com>
Date:   Tue, 28 May 2019 13:40:47 -0700
In-Reply-To: <CAKO26MsGpEcK74CSdgNGjFdKAMDP5Knm+0_vtcnrBBJjBfjcQA@mail.gmail.com>
        (=?utf-8?B?Iuael+iHquWdhyIncw==?= message of "Tue, 28 May 2019 15:42:32
 +0800")
Message-ID: <xmqq36ky1fe8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E001E8C2-8188-11E9-915C-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=E6=9E=97=E8=87=AA=E5=9D=87 <johnlinp@gmail.com> writes:

> Hi Junio,
>
> John Lin via GitGitGadget <gitgitgadget@gmail.com> =E6=96=BC 2019=E5=B9=
=B45=E6=9C=8815=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=886:54=E5=AF=AB=
=E9=81=93=EF=BC=9A
>>
>> From: John Lin <johnlinp@gmail.com>
>>
>> Before this patch, there is inconsistency between the status
>> messages with hints and the ones without hints: there is an
>> empty line between the title and the file list if hints are
>> presented, but there isn't one if there are no hints.
>>
>> This patch remove the inconsistency by removing the empty
>> lines even if hints are presented.
>
> I would like to ask for the final decision on this patch. Thank you.

If I recall correctly, the test part of this patch conflicts badly
with a topic in flight that splits 'checkout' into 'restore' and
'switch', which is a more important topic between the two.  So if I
must give _the final_ decision, then we need to drop this patch, but
I'd rather not ;-)

Doing this change on top of the switch/restore topic, once it
stabilized more and graduated to 'master', would be the best course
of action, I would think.

Thanks.
