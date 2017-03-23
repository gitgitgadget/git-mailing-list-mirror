Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A35020958
	for <e@80x24.org>; Thu, 23 Mar 2017 22:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754860AbdCWWiS (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 18:38:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62542 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752034AbdCWWiS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 18:38:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F18736A0F3;
        Thu, 23 Mar 2017 18:38:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9GT8b3L5m6JJi766eu++kec+nvE=; b=uSjnhx
        ELVXgrxbzQaPkza65RlJcRl+h+XnXthwJjkFLDgHWEEhRn6yBcRFtnqeOYVn2+Yh
        wyeztKdf0oZPRk+s3ehunP9tbiaFEhSMdsndqTdL/rasLsmJHB+E1MNfa61tNrOn
        oF3MCtO/VKhPCN3RclpT79wGuigmpbWiMGZXw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M/HeKeRkQQ0fsPhf8fcBglWoGlJyBKG3
        y7QTkz+KftvRwPik7ifeYg0fm1ESn320U3v8Fh68Tuk+cAlSqIvvOEYFeWIJjM0i
        8OUT8na+GeELrZNOShtn9VpEOk4l9d3uO7W47Sb6/vqDMF0QICthOK3S4gAwuavP
        NHR12+wy47Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E82A26A0F2;
        Thu, 23 Mar 2017 18:38:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 49D966A0F1;
        Thu, 23 Mar 2017 18:38:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        johannes.schindelin@gmx.de
Subject: Re: [PATCH] sequencer: fix missing newline
References: <20170323170233.50499-1-bmwill@google.com>
        <20170323221217.GA20794@aiede.mtv.corp.google.com>
Date:   Thu, 23 Mar 2017 15:38:14 -0700
In-Reply-To: <20170323221217.GA20794@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Thu, 23 Mar 2017 15:12:17 -0700")
Message-ID: <xmqqbmsraaax.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6767665E-1019-11E7-B660-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Brandon Williams wrote:
>
>> When using rebase --interactive where one of the lines is marked as
>> 'edit' this is the resulting output:
>>
>>     Stopped at ec3b9c4...  stuffYou can amend the commit now, with
> [...]
>> Signed-off-by: Brandon Williams <bmwill@google.com>
>> ---
>>  sequencer.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Thanks for fixing it.  I don't see any other fprintf in the file with
> missing \r or \n at the end, so this fix looks complete.
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
