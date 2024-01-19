Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1A858217
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 22:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705703216; cv=none; b=XRHXwpNxYaK1BFF0OMAf/mVEyekp0eFwLDojdOXabyZxAvrhV43e4tCh9hru6e+7OUqxiuKbcGunSvs46OeIrM78aH6L1zCHmHhd5rEkFKPTteud6KsvgVx5E4GQrxhGw+Gx15UkvNRnS9lnWFzjaLA8qFQeT5MRGGGQxyYRt/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705703216; c=relaxed/simple;
	bh=Q/Won7j97oj5YMi5SDFtEfpJW5tq2NZ03ubjC5Pp9b8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UqrwtsTyMPGUp5rppVEdFP4TFHiGI3voZS4jPN86eP4FqMe5zEqKtMKB9YOx6po+8clwrXI7fbPDlYAOIvYVLUF7B9v6TsMhlQ7aeqHnnlLahFVmUrrD0Cw9326bmWH5ZLnBYpbwA8a49Wp10gfA3WwXDXUpd1jEkEbuwQNPTps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xf6o0d7p; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xf6o0d7p"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B0E881D7114;
	Fri, 19 Jan 2024 17:26:47 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Q/Won7j97oj5YMi5SDFtEfpJW5tq2NZ03ubjC5
	Pp9b8=; b=xf6o0d7pMKtT6LSrBbX8naVB4XgXEDsIgUJLN1Yb/cdf6GJ7vlqJP/
	IswmJSE62QG1HVueqj5wpagI5LYA7kSGpxbWCpgkLtbyx0n3wvjP7QaHXJV+EwCv
	i7gkxsOorUaiTJxbHCIXprRF+aKxB5PQn8LXQ55NTcW66p85mwMPg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A77821D7113;
	Fri, 19 Jan 2024 17:26:47 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 166701D7110;
	Fri, 19 Jan 2024 17:26:47 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: spectral via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  spectral <spectral@google.com>
Subject: Re: [PATCH] MyFirstContribution: update mailing list sub steps
In-Reply-To: <20240119-flat-jellyfish-of-drizzle-b31abe@lemur> (Konstantin
	Ryabitsev's message of "Fri, 19 Jan 2024 16:06:52 -0500")
References: <pull.1644.git.1705697955144.gitgitgadget@gmail.com>
	<20240119-flat-jellyfish-of-drizzle-b31abe@lemur>
Date: Fri, 19 Jan 2024 14:26:45 -0800
Message-ID: <xmqqmst1hsd6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D506293A-B719-11EE-98CB-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> On Fri, Jan 19, 2024 at 08:59:15PM +0000, spectral via GitGitGadget wrote:
>>  contributing are welcome to post questions here. The Git list requires
>>  plain-text-only emails and prefers inline and bottom-posting when replying to
>>  mail; you will be CC'd in all replies to you. Optionally, you can subscribe to
>> -the list by sending an email to majordomo@vger.kernel.org with "subscribe git"
>> -in the body. The https://lore.kernel.org/git[archive] of this mailing list is
>> -available to view in a browser.
>> +the list by visiting https://subspace.kernel.org/vger.kernel.org.html and using
>> +the `sub` link next to the `git` list (this is a mailto link; you can leave
>> +subject and body blank, but you still have to send the email). The
>
> I recommend just telling people to send a message to
> git+subscribe@vger.kernel.org and linking to
> https://subspace.kernel.org/subscribing.html for more details. While
> "sub/unsub" links will do the job for some people, webmail users may not
> have things properly configured to correctly process the mailto: links.

Yeah, good suggestion.

Kyle, thanks for noticing the majordomo deprecation.

Perhaps something like this is agreeable to everybody?

------------ >8 ----------------------- >8 ----------------------- >8 ------------
Subject: Docs: majordomo@vger.kernel.org has been decomissioned

Update the instruction for subscribing to the Git mailing list
we have on a few documentation pages.

Noticed-by: Kyle Lippincott <spectral@google.com>
Helped-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/MyFirstContribution.txt | 5 +++--
 README.md                             | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git c/Documentation/MyFirstContribution.txt w/Documentation/MyFirstContribution.txt
index 279f6a3e7c..f06563e981 100644
--- c/Documentation/MyFirstContribution.txt
+++ w/Documentation/MyFirstContribution.txt
@@ -35,8 +35,9 @@ announcements, design discussions, and more take place. Those interested in
 contributing are welcome to post questions here. The Git list requires
 plain-text-only emails and prefers inline and bottom-posting when replying to
 mail; you will be CC'd in all replies to you. Optionally, you can subscribe to
-the list by sending an email to majordomo@vger.kernel.org with "subscribe git"
-in the body. The https://lore.kernel.org/git[archive] of this mailing list is
+the list by sending an email to <git+subscribe@vger.kernel.org>
+(see https://subspace.kernel.org/subscribing.html for details).
+The https://lore.kernel.org/git[archive] of this mailing list is
 available to view in a browser.
 
 ==== https://groups.google.com/forum/#!forum/git-mentoring[git-mentoring@googlegroups.com]
diff --git c/README.md w/README.md
index 2c3de2f9c8..665ce5f5a8 100644
--- c/README.md
+++ w/README.md
@@ -39,8 +39,8 @@ Those wishing to help with error message, usage and informational message
 string translations (localization l10) should see [po/README.md][]
 (a `po` file is a Portable Object file that holds the translations).
 
-To subscribe to the list, send an email with just "subscribe git" in
-the body to majordomo@vger.kernel.org (not the Git list). The mailing
+To subscribe to the list, send an email to <git+subscribe@vger.kernel.org>
+(see https://subspace.kernel.org/subscribing.html for details). The mailing
 list archives are available at <https://lore.kernel.org/git/>,
 <https://marc.info/?l=git> and other archival sites.
 
