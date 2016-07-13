Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12C272018F
	for <e@80x24.org>; Wed, 13 Jul 2016 15:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbcGMP1w (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 11:27:52 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:60884 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751580AbcGMP1r (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2016 11:27:47 -0400
X-AuditID: 12074411-a53ff70000004911-f6-57865dbc2b86
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id E1.76.18705.CBD56875; Wed, 13 Jul 2016 11:26:53 -0400 (EDT)
Received: from [192.168.43.172] ([89.204.154.160])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u6DFQbdM020511
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 13 Jul 2016 11:26:41 -0400
Subject: Re: [PATCH 00/38] Virtualization of the refs API
To:	Duy Nguyen <pclouds@gmail.com>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
 <CACsJy8CNJfQxnn94b=+mjfPVvNzJu3sD3w_g8yCUHY0UQCbfLQ@mail.gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
From:	Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <6c123315-ba5c-ac15-8314-b6a71c325d9f@alum.mit.edu>
Date:	Wed, 13 Jul 2016 17:26:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8CNJfQxnn94b=+mjfPVvNzJu3sD3w_g8yCUHY0UQCbfLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsUixO6iqLs3ti3c4M1yAYv5m04wWnRd6Way
	aOi9wmzRPeUto8WPlh5mi5lXrS3OvGlkdGD32DnrLrvHs949jB4XLyl77F+6jc1j8QMvjwXP
	77N7fN4kF8AexW2TlFhSFpyZnqdvl8Cd8fBgH0vBHrGKKYdesjYwLhLqYuTkkBAwkdj6ZB1b
	FyMXh5DAVkaJY7//QjmbmCTWtHxmBakSFrCU+HBoGzuILSKgJPGmYxtzFyMHUFGdxNNZ2iD1
	zALdTBInT7SxgdSwCehKLOppZgKxeQXsJbY/nQoWZxFQlbi0oAVsjqhAiMS2mw1sEDWCEidn
	PmEBsTkFAiWev/jJDGIzC6hL/Jl3CcqWl2jeOpt5AiP/LCQts5CUzUJStoCReRWjXGJOaa5u
	bmJmTnFqsm5xcmJeXmqRrqlebmaJXmpK6SZGSMAL7mCccVLuEKMAB6MSDy+DSGu4EGtiWXFl
	7iFGSQ4mJVHezrlAIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8M2LawoV4UxIrq1KL8mFS0hws
	SuK8fEvU/YQE0hNLUrNTUwtSi2CyMhwcShK8niCNgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkp
	qUWJpSUZ8aCYjC8GRiVIigdo77tokL3FBYm5QFGI1lOMuhx/Nky+wiTEkpeflyolzhsJskMA
	pCijNA9uBSy9vWIUB/pYmLcRpIoHmBrhJr0CWsIEtKTWoRlkSUkiQkqqgTH+gZ+UqpLYxI8m
	ibu0TTdP1PMIMj595mR8u+rNWIdIR64vcz4/NTpx4215tNcj/eBj6ffbou+9SMmcElf86aQ5
	/9arr54f4vu1MPno32kLlqra256qM3KZyeBQGzH1AMPqksBEFzaFj213ek8VS689/+fGt+iT
	v5NyvFZwP+D5zrR1ZaDYtb1KLMUZiYZazEXFiQAnnCa7SgMAAA==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 07/10/2016 05:09 PM, Duy Nguyen wrote:
> On Fri, Jun 3, 2016 at 11:03 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Since the that ref-iterator [1] changes seem to have gotten a positive
>> reception, let's try to keep up the momentum. I hope I'm not
>> overloading the review pipeline...
>>
>> I think all of the groundwork is in place now to virtualize the refs
>> API. This will open the way to storing refs in ways other than the
>> familiar loose refs / packed refs format, such as David Turner's
>> proposed LMDB-based storage [2].
>>
>> This is a long patch series, but most of the patches are pretty simple
>> and formulaic. The goal is to implement a `ref_store`. In the language
>> of object-oriented programming, `ref_store` is an abstract base class
>> representing a reference storage backend. It provides methods to read,
>> write, and delete references and symrefs, and to iterate over
>> references, reflogs, and reflog entries, plus a number of other
>> things—19 methods in all.
> 
> I probably don't know what I'm talking about because I don't follow
> your work closely enough. Please ignore if this is nonsense. But if we
> extend/change API, we might need to update git-for-each-ref too, to
> expose it to shell scripts and external commands. I guess for
> iteration there's nothing else more needed, but we may need to
> introduction new options for the storage thing, e.g. to select
> storage...

This patch series doesn't change the external API in any significant
way. It only wraps it up on a virtualization layer so that a different
reference storage backends can be plugged in.

So as long as people are using plumbing commands to work with references
(rather than reading/writing files under $GIT_DIR directly), they should
notice no difference.

There are only two exceptions that I know of:

1. Users will need to be able to request that a repository use a
non-default reference backend, and (less importantly) inquire about
which reference backend a particular repository is using. Those
facilities will be added when the first non-files reference backend is
added.

2. At least one command (`git pack-refs`) is particular to the files
backend, and won't be needed (at least not in its current form) for
other backends. Conversely, it is conceivable that future reference
backends will require their own "maintenance" commands. Such commands
would be added as they are needed.

If there were operations that other reference backends could do much
more efficiently than the files backend (like, hypothetically, return
all references matching a regular expression without having to iterate
through all references), then it might make sense for performance
reasons to provide commands to access that functionality. But at the
moment I don't know of any such cases.

Michael

