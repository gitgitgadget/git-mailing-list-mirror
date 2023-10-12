Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655403D3AC
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 20:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HHfdzJaV"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AD7BE
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 13:46:40 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 36A061C066B;
	Thu, 12 Oct 2023 16:46:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Qw/pMxVnaYcDsZzl9kmBjLVgj6i6v0AFPcE+1i
	w/6eE=; b=HHfdzJaVQWogQD3q1yD1NUaOU7m70Q68GcLn2MwShzW11R2wnG5Oum
	H99oG1c57y1+oimmdYridrYPSbsMpuDJkPxEQt47erruiMFFHmz19ooLXp7uesEC
	zxaUu0zofuf2PDiegWB4Px0pXbsJbOq3pmQGADqG+kU4eZlGdRrYg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A0C31C0668;
	Thu, 12 Oct 2023 16:46:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 580C21C0667;
	Thu, 12 Oct 2023 16:46:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: git@vger.kernel.org
Subject: Re: This list is being migrated to new infrastructure (no action
 required)
In-Reply-To: <20231012-magnifier-decipher-4493ec@meerkat> (Konstantin
	Ryabitsev's message of "Thu, 12 Oct 2023 16:40:38 -0400")
References: <20231012-party-legwarmer-551ab7@meerkat>
	<20231012-magnifier-decipher-4493ec@meerkat>
Date: Thu, 12 Oct 2023 13:46:38 -0700
Message-ID: <xmqqcyxj6029.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 713E8B3A-6940-11EE-8F3B-25B3960A682E-77302942!pb-smtp2.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> On Thu, Oct 12, 2023 at 04:30:54PM -0400, Konstantin Ryabitsev wrote:
>> This list is being migrated to the new vger infrastructure. This should be a
>> fully transparent process and you don't need to change anything about how you
>> participate with the list or how you receive mail.
>> 
>> There will be a brief delay with archives on lore.kernel.org. I will follow up
>> once the archive migration has been completed.
>
> This work is completed now. If you think something isn't working right, please
> report it to helpdesk@kernel.org.

Thanks!
