Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 899BF20756
	for <e@80x24.org>; Mon,  9 Jan 2017 09:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934780AbdAIJyd (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 04:54:33 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58644 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934771AbdAIJyc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 04:54:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 729055A5BB;
        Mon,  9 Jan 2017 04:54:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Klr3jnMMeJmuW7okt+968k8dQZw=; b=m9O4RL
        3QtgORJ0UPYxE+nzKMX+B0wMzXGb6hI0Rg5P6V8zrgma99Wn0IHqbPItIALaH7WH
        tbqvbNphUmDjFgT9TDT9WfUysfltOTVWdkaIzob5vgjy5/COq2qNuvzz75mrMnQY
        +X8umdDBqPCxcyN6t1gV4WuRU9fZu6ZQ+otXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ga6ioPmu8TaTZPATFxXMnNHKLqGUZOgG
        8nbWn4Wdy6Y1xbaTy3Xl/eh20G7DqWQYAybcDyWOEVV9BjRrafNPUyCYo0OIifuq
        USCXuijHrOndh4SEAK9ijHxS24yVmU7+xATb1sCQaCNwkYt8SRW8Xq+z9eFzxhOS
        21F42BkrXsY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A9F95A5BA;
        Mon,  9 Jan 2017 04:54:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CDDD55A5B9;
        Mon,  9 Jan 2017 04:54:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] t9813: avoid using pipes
References: <010201597f017978-356bf9e9-ee78-498b-926b-5c00466b1d9e-000000@eu-west-1.amazonses.com>
        <010201597f0179fb-fc4c0240-5ec7-466b-96b9-59f4840954d7-000000@eu-west-1.amazonses.com>
        <CAE5ih7-mAfezTwdbWrAWFOSoCf-z_NJOic+FQdCmHbCyR8ng9w@mail.gmail.com>
Date:   Mon, 09 Jan 2017 01:54:29 -0800
In-Reply-To: <CAE5ih7-mAfezTwdbWrAWFOSoCf-z_NJOic+FQdCmHbCyR8ng9w@mail.gmail.com>
        (Luke Diamand's message of "Mon, 9 Jan 2017 09:11:06 +0000")
Message-ID: <xmqq37gsy2wa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9DBF4D86-D651-11E6-919B-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Diamand <luke@diamand.org> writes:

> On 8 January 2017 at 16:55, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> The exit code of the upstream in a pipe is ignored thus we should avoid
>> using it. By writing out the output of the git command to a file, we can
>> test the exit codes of both the commands.
>
> Looks good to me, thanks!
>
> Ack.

Thanks, both.

