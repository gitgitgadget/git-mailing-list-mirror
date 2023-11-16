Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="K6icvrD2"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921CCBD
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 19:10:33 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3A13A337A3;
	Wed, 15 Nov 2023 22:10:33 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=JiW03zEG96QEiv04sA/rb9DiEiSMdWtfv6S4jR
	SqOy0=; b=K6icvrD2MrFrX5363IdtTUaNg5oiAvndcDyKqzD0voq2WOj7haAGvQ
	pqsRn/lN8rX1f1qIB6kyJ5EgRIAXDCja4AH83+In9CV9XdMd4V87bOdQqBRitCzU
	SWIe3aD1SQXC+oveoSC+Tar9dn6mDW3hdYUFqbFkr/680MMav3EJQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 32ED5337A2;
	Wed, 15 Nov 2023 22:10:33 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CA8EE337A1;
	Wed, 15 Nov 2023 22:10:29 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Alan Dove <alan.dove@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Bug: "Received" misspelled in remote message
In-Reply-To: <4e76dda1009a8365a1d66d9594865a4af31ab418.camel@gmail.com> (Alan
	Dove's message of "Wed, 15 Nov 2023 13:46:10 -0500")
References: <4e76dda1009a8365a1d66d9594865a4af31ab418.camel@gmail.com>
Date: Thu, 16 Nov 2023 12:10:28 +0900
Message-ID: <xmqqmsvetmu3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B283E344-842D-11EE-8804-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Alan Dove <alan.dove@gmail.com> writes:

> Hello:
>
> Using Git 2.40.1 on a private server, I see this message whenever I
> push a commit:
>
> "remote: Recieved update on checked-out branch, queueing deployment."
>
> "Received" is misspelled. 

I think it is coming from the "push-to-checkout" hook that is
installed on your "private server", and not from what we ship as
part of our software offering.

We are not going to include spelling correction software to massage
the output from end-user installed hooks, so it is unlikely the
typo will be fixed by us.

> I realize this is a very minor issue, but it should also be very easy
> to correct. As someone who suffers from Proofreader's Eye, this error
> deals psychic damage to me on a daily basis.

Sounds like something a world-class science writer may say ;-).

Thanks for reporting.
