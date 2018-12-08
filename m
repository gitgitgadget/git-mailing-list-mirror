Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4A3D20A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 06:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbeLHGIh (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 01:08:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62468 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeLHGIh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 01:08:37 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0732A110E3D;
        Sat,  8 Dec 2018 01:08:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wMNc093ebAxBmGd2prx7inDKzjI=; b=MApIN5
        B6S1TkJ+lZ6UVZl/wU/SC/7dd50d3NbA9Gxf12duN+03uuhS3KtnKzHxPeM/iPw3
        Ua9dP26r2g7ZZDau5XMrjrKcbhOyAGmFlixZpGuH+YEsFcNKlj2GfmkuXPXxnbl6
        DK7lMJDHWWw5lg0t/TeWQpRaZ3J4n+pYf1EBg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mRhLWXtfTYo7m3lco2B/89+OQUAUQYJs
        6i6qUP/Vum18ILeFyoPhCv86lm9i+AcHR5htOk4glZl3l5ONvQxcq7ephCE0tD2n
        yfJZpZeIdE7pDsXky9JAga9MpW32G87wQZj0dijPRGS+PrB538rhc6704Ck5ctVk
        J1zJlkyQr/8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F271F110E3C;
        Sat,  8 Dec 2018 01:08:34 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 68CC8110E3A;
        Sat,  8 Dec 2018 01:08:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, bwilliamseng@gmail.com,
        git <git@vger.kernel.org>, bwilliams.eng@gmail.com
Subject: Re: [PATCH] mailmap: update brandon williams's email address
References: <20181207205621.49961-1-bwilliams.eng@gmail.com>
        <20181207214013.GA73340@google.com>
        <CAGZ79kYrgpZDqAhg8c11V_qJTCzzw4-qrVN2z_Y_OAeCbWU6dQ@mail.gmail.com>
Date:   Sat, 08 Dec 2018 15:08:33 +0900
In-Reply-To: <CAGZ79kYrgpZDqAhg8c11V_qJTCzzw4-qrVN2z_Y_OAeCbWU6dQ@mail.gmail.com>
        (Stefan Beller's message of "Fri, 7 Dec 2018 14:11:18 -0800")
Message-ID: <xmqq5zw48s9q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B1D3630A-FAAF-11E8-8BF0-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Fri, Dec 7, 2018 at 1:40 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>>
>> Brandon Williams wrote:
>>
>> > Signed-off-by: Brandon Williams <bwilliams.eng@gmail.com>
>> > ---
>> >  .mailmap | 1 +
>> >  1 file changed, 1 insertion(+)
>>
>> I can confirm that this is indeed the same person.
>
> What would be more of interest is why we'd be interested in this patch
> as there is no commit/patch sent by Brandon with this email in gits history.

Once I "git am" the message that began this thread, there will be a
commit under this new ident, so that would be somewhat a moot point.

If this were "Jonathan asked Brandon if we want to record an address
we can reach him in our .mailmap file and sent a patch to add one",
then the story is different, and I tend to agree with you that such
a patch is more or less pointless.  That's not the purpose of the
mailmap file.

Not until git-send-email learns to use that file to rewrite
To/cc/etc to the "canonical" addresses, anyway ;-)

I am not sure if there are people whose "canonical" address to be
used as the author is not necessarily the best address they want to
get their e-mails at, though.  If we can be reasonably sure that the
set of such people is empty, then people can take the above mention
about send-email as a hint about a low-hanging fruit ;-)

Thanks.


