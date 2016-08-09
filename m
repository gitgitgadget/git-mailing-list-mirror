Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C160D1F859
	for <e@80x24.org>; Tue,  9 Aug 2016 17:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbcHIRjG (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 13:39:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51745 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932222AbcHIRjG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 13:39:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 09F213465F;
	Tue,  9 Aug 2016 13:39:04 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XozsxyFw3P6hcynuh1VT4FlXG08=; b=ZK3Vxc
	atlOTfQuuKYjpPUT1YQA//kypki0jxIGG5Gsv8fZ/k1iOV8O0xmgdJZp7j1KZQwO
	X+XudmP07E30zdaESL6T8/XtgKgGMQ3TNnEDwFFTepndOmCWJW3EGKdIV6ZDK0T/
	78roH0cbIdaLJqoQozWgM6ZN/vc2OYp92eALU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DNcoONRwv5KpKC2OJvvmmyHkQ7U7r6cK
	HkZRaEJF8aYRACC3lWSS4Ex4C26KF9ZvoHXqzIHbRIDFbkrEZaeGxaexJz7+QI6Q
	tW+pUZrhyMryLLjktpe2sH6m30p/0uI7MJe+e7pCi5/J9D9cgsEdt9j1ydpd+Jat
	lLfASONOyyM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F2B903465E;
	Tue,  9 Aug 2016 13:39:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 775483465D;
	Tue,  9 Aug 2016 13:39:03 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv3 1/9] t7408: modernize style
References: <20160809040811.21408-1-sbeller@google.com>
	<20160809040811.21408-2-sbeller@google.com>
	<CAPig+cRnDVMBZzKOOS-fW+hNaCHhYRVLM+d_akZcB4H5iyqfKA@mail.gmail.com>
	<xmqqfuqec56x.fsf@gitster.mtv.corp.google.com>
	<xmqqbn12c55e.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZgEF2FBSLQnOm=v-a+jy=6aWyPBoLC9-QU=g-aUaqj3w@mail.gmail.com>
Date:	Tue, 09 Aug 2016 10:39:00 -0700
In-Reply-To: <CAGZ79kZgEF2FBSLQnOm=v-a+jy=6aWyPBoLC9-QU=g-aUaqj3w@mail.gmail.com>
	(Stefan Beller's message of "Tue, 9 Aug 2016 10:30:47 -0700")
Message-ID: <xmqqd1lhc05n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29EEAC1A-5E58-11E6-A559-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Tue, Aug 9, 2016 at 8:51 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>>
>
> I originally thought that it may be easier to have 2 patches.
> This first one is very gentle and "obviously correct" as it only changes
> formatting and drops the directory changes.
>
> The second patch goes for renaming ans subtle style issues,
> combining some tests, so it is more likely to break.
>
> After this review, I consider using just one patch and do it all
> at once to not confuse the readers as otherwise I should reword
> the commit message with the rationale of doing it in two patches.

FWIW, I would think your split between 1/ and 2/ were very sensible,
and have a slight preference for keeping them separate.

If you already have squashed, I do not insist you to split it again;
it is not a big deal either way.

