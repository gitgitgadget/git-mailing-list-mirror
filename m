Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E00B2D0618
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759510104; cv=none; b=rxUUOXjo0q7VZu+4peHyZfWsSN2pdVtcnPsJKfMTV1UWWkoMfFHU20Ixtd7xkhszEMBNrmulBbbt2Uni0q1m5EJrTWVj8uw7+2HiTaeMj3RSu7m9MXIiDM4oSMxf+9PJwqUkMAOP+k3ONBUgwZoj/epqmNwa919apWSsrZVOlGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759510104; c=relaxed/simple;
	bh=rV3+hclK7daL4SunQ8xT9ewvOaNgtZLhewvm/2vyZmg=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ovavZja6G1TakpLqY4dOpYzX+bHpPDuX89oJxfyr1MucClN2XBrudpDw+MLovJzsHoIxbQaYkBrKVFFyCNdZaNS5FsYQP1s+g/CkmvCQ5GuPDkQeSQjkMTapWDMSrbukjJ+AdQkDrOOTYcO3GLMw3id/ND0kavfdi3dzu2spZLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 593GjnNP491307
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 Oct 2025 16:45:50 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>,
        "'Christian Couder'" <christian.couder@gmail.com>
Cc: <git@vger.kernel.org>, "'Taylor Blau'" <me@ttaylorr.com>,
        "'Rick Sanders'" <rick@sfconservancy.org>,
        "'Git at SFC'" <git@sfconservancy.org>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Patrick Steinhardt'" <ps@pks.im>,
        "'Christian Couder'" <chriscool@tuxfamily.org>
References: <xmqqcyalm0mh.fsf@gitster.g>	<20251001140310.527097-1-christian.couder@gmail.com>	<xmqq4isi1gpm.fsf@gitster.g>	<CAP8UFD3wc-aj27Q_kFXvknJrpa-ySWbZiPmNCTMboA08=HP+xw@mail.gmail.com> <xmqqjz1cufcd.fsf@gitster.g>
In-Reply-To: <xmqqjz1cufcd.fsf@gitster.g>
Subject: RE: [PATCH v2] SubmittingPatches: add section about AI
Date: Fri, 3 Oct 2025 12:45:43 -0400
Organization: Nexbridge Inc.
Message-ID: <061a01dc3485$2ca50820$85ef1860$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDukNemFFvhssO2I1SMimhFsqd3cQF/XLqwAlz95vkBl/qpdwJDkGo5tk4nukA=
Content-Language: en-ca
X-Antivirus: Norton (VPS 251003-2, 10/3/2025), Outbound message
X-Antivirus-Status: Clean

On October 3, 2025 12:21 PM, Junio C Hamano wrote:
>Christian Couder <christian.couder@gmail.com> writes:
>
>>> A milder way to phrase this would be to jump directly to "we reject
>>> what the sender cannot explain when asked about it".  "How does this
>>> work?"  "Why is this a good thing to do?"  "Where did it come from?"
>>> instead of saying "looks AI generated".
>>>
>>> It would sidestep the "who decides if it looks AI generated?" question.
>>
>> I don't think the "who decides if it looks AI generated?" question is
>> very relevant. If someone says that a patch looks mostly AI generated
>> and gives a good argument supporting this claim, it's the same as if
>> someone gives any other good argument against the patch. In the end,
>> the community and you decide if the argument is good enough and if the
>> patch should be rejected based on that (and other arguments for and
>> against the patch of course).
>
>And then who plays the final arbiter?  One can keep insisting on a patch
that looks
>to me an apparent AI slop that it was what one wrote oneself, but you may
find it a
>plausible that it was a human creation.  Then what?
>
>It is very much relevant to avoid such argument, because the point is
irrelevant.  We
>are trying to avoid accepting something the submitter has no rights to
claim theirs,
>and requesting them to explain where it came from, how it works, etc. would
be a
>better test than "does it look AI generated?  to everybody?", wouldn't it?

Can the cover page from the originator contain statements that:
a) I (whomever it is) has the legal authority to the submitted patch without
violating any copyright.
b) The code is original work and does not violate any IP laws where I
(whomever)
am located.
c) The code is not generated from AI and/or despite being AI generated, I
(whomever)
have verified that the code works as anticipated and does not contain AI
contents
trained from another code-base or project that might otherwise violate b),
and that
I (whomever) accept all responsibility for falsely making this statement.

This could be changed to an agreement maintained by the Conservancy prior to
Accepting any non-trivial contributions providing the agreement is
referenced in
Either the cover page or commit comments.

