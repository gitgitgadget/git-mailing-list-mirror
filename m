Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EF66207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 22:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S947908AbdDTWwo (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 18:52:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61341 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S947899AbdDTWwm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 18:52:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D6DCA7D7B3;
        Thu, 20 Apr 2017 18:52:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TRxNVpmSWhRKol0X0/ZeAZz9S8o=; b=rOW7XU
        kTESCc3FcqrmM7bUpJtb3rkTiSpVN1+dR034f1nTJ8sa1paOx5ob7AwltQtqvSaj
        ssIFVGEbEQlaTYABAKeTdBx8znGRL3L7suKgslwPOxHIUiNRhgchaRMW2bOY4+an
        nFMX0Pkdg43Q1gWvjqgDjkYPmjns0LTINaZcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wT8FWBPaQVenaeQJTFS6b3NykX8tim7G
        vGuUvU/qVbtRlmYFJ83Qn81aLPlbkNxmWvFcmaI+/7hFt0vr707YUrnMPbTriEHC
        IH4HSvUF2Zwjrw+JTZIW/5KUxxq811ON8RsCo3i8wWVEpg2KHi7kSAQnL/NIIJnk
        8sx6DWegTM8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CFE537D7B2;
        Thu, 20 Apr 2017 18:52:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 42AFF7D7B1;
        Thu, 20 Apr 2017 18:52:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2017, #04; Wed, 19)
References: <xmqq4lxjabce.fsf@gitster.mtv.corp.google.com>
        <25191991-F4EA-4D91-B291-854F46A34DC2@gmail.com>
Date:   Thu, 20 Apr 2017 15:52:40 -0700
In-Reply-To: <25191991-F4EA-4D91-B291-854F46A34DC2@gmail.com> (Lars
        Schneider's message of "Thu, 20 Apr 2017 17:32:13 +0200")
Message-ID: <xmqqinly8zev.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F21613E-261C-11E7-83D2-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> Sorry for sending this email multiple times. My mobile email client created html... Should be fixed now!
>
>> 
>> * ls/filter-process-delayed (2017-03-06) 1 commit
>> - convert: add "status=delayed" to filter process protocol
>> 
>> What's the status of this one???
>> cf. <xmqq60jmnmef.fsf@junio-linux.mtv.corp.google.com>
>
> posted v3 here:
> https://public-inbox.org/git/20170409191107.20547-1-larsxschneider@gmail.com/ 
>
> From my point of view the only open question is if we use an index ("delay-id" favored by Peff) or the path (favored by Taylor) to identify delayed items: 
> https://public-inbox.org/git/20170227095825.jhdspwy6oa6mvvvm@sigill.intra.peff.net/ 
> https://public-inbox.org/git/20170412173404.GA49694@Ida/#r 
>
> I slightly favor the path approach as it simplifies the protocol. But I also trust Peff's opinion.
>

Thanks for a nice summary.

>> * ls/travis-doc-asciidoctor (2017-04-16) 3 commits
>> (merged to 'next' on 2017-04-19 at 359c32953b)
>> + travis-ci: unset compiler for jobs that do not need one
>> + travis-ci: parallelize documentation build
>> + travis-ci: build documentation with AsciiDoc and Asciidoctor
>> 
>> Have Travis CI format the documentation with both AsciiDoc and
>> AsciiDoctor.
>> 
>> Will merge to 'master'.
>
> Can you hold this until next week?
> The I would post a v2 and check asciidoc stderr: 
> https://public-inbox.org/git/D9F45212-91F7-4BB1-A0EC-74A84DA81860@gmail.com/ 
>
> I can also post an additional patch if you prefer to merge now.

Thanks; will hold.
