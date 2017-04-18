Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F28AC1FA26
	for <e@80x24.org>; Tue, 18 Apr 2017 00:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755620AbdDRAbi (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 20:31:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63368 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754658AbdDRAbg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 20:31:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AAE4A73F34;
        Mon, 17 Apr 2017 20:31:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PZ0XlQvKyJ84OX7/B7EXsfY+kAY=; b=P3xe+V
        xDuQKSTGrtjqH8C8m3GGak9poDgYSr/NDKWgiVlKUZXlC6kvkmgn/roJ2vNogcaK
        WGbXbg0Ev2MDrEy8IvOXpb3VWUKO8I0yzGaQrV+6XpaMPePf4hMY+3BRMEQa1dsU
        hMcuK6mdTHnlyYUpJ/QP5s5DXcbevK7yMeodU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Lpvym4dolMhtr2Z8zTlNu5c6DgO6jsSe
        CC+xK1LknHGZQwxalVE+9DVYDXCt9aQPRlnKTBiEJ/2Q8+NxNbXqeVUHbiWYkWLg
        IoFKd7enw+5MbPDCzmWoObPMW1Mqgu2FrCjj8QZBOLJKLiaYfsqGUykJN0wJxIKu
        9Z3L7ZzWe94=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A395373F33;
        Mon, 17 Apr 2017 20:31:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1082C73F32;
        Mon, 17 Apr 2017 20:31:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Christoph Michelbach" <michelbach94@gmail.com>,
        "Git Mailing List" <git@vger.kernel.org>
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
Date:   Mon, 17 Apr 2017 17:31:33 -0700
In-Reply-To: <5FD0803E166B4D2F9F64D8D21AC23EB3@PhilipOakley> (Philip Oakley's
        message of "Mon, 17 Apr 2017 21:59:44 +0100")
Message-ID: <xmqqa87eimje.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 60B5320A-23CE-11E7-83B4-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

>>> If we'd created and added a file d just before the checkout, what
>>> should
>>> have happened to d, and why?
>>
>> I understand what the command does. It behaves perfectly as I expected
>> it to. I did not find this script but wrote it to demonstrate that what
>> the documentation says is different from how it behaves after having
>> read what the documentation says it should do and noticing that that's
>> not how I expected it to work from experience.
>>
>> What it really does is to copy all files described by the given paths
>> from the given tree-ish to the working directory. Or at least that's my
>> expectation of what it does.
>>
>> The documentation, however, says that the given paths are *restored*.
>> This is different.
>
> I don't see that difference in the phrase *restored*, compared to your
> 'copy all files described by the given paths'. Could you explain a
> little more?

I am obviously not Christoph, and I was the one that defined how
"checkout <tree> -- <pathspec>" should work, but when you say
"restore" (which is not what I wrote ;-)) it is fair to expect lack
of 'd' could also be "restored", in addition to path that was in the
directory.

Obviously, "grab all paths that match <pathspec> out of <tree>, add
them to the index and copy them out to the working tree" will never
be able to _restore_ the lack of 'd', even it may match the
<pathspec> being used to do this checkout, by removing it from the
current index and the working tree.

