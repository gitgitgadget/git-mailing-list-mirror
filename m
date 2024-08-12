Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BEB183CC8
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723476404; cv=none; b=i+32oRLagXYY3nmsan9aBEcy/yKzOHhji1Yhq0VhLEUJ2U8J93LGHjIzqiS+y/i4m36ahYJXgmG0mqVkE+ZfFcNdzfwqDOZ7q1pL7AU6df4ZvDbgUcBkqn295dtUevl27ILFq5hUEKiy1BgEr+HJym99dSq2BCzGxwL1EtPxoOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723476404; c=relaxed/simple;
	bh=I6gRro/pxE3xsybhQU3zzI/nC2Ua2w9RI0PFNuGlVEo=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=q8tBo4viZUSKe5hnHkpq1aGNusZ7k73r1sMzTIHWLZrJxEtYFuYy+BCk252nJTbJfqiphPatZSbVNV+gpDyOOhM/jhhRQkuHR5Dpjz2bHMxjtqggWJucocm/I4tKV91vuMBsayIlBZQzl5dGvmhrENsWoqgUpXlIrMz9BHfjH2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 47CFQdbq1459578
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 15:26:39 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Mike Castle'" <dalgoda@gmail.com>, "'git'" <git@vger.kernel.org>
References: <CA+t9iMyT8fAR_fvQXOer=ivLnNKDnH8g_M8iQiq7gdrnfG7aCg@mail.gmail.com>
In-Reply-To: <CA+t9iMyT8fAR_fvQXOer=ivLnNKDnH8g_M8iQiq7gdrnfG7aCg@mail.gmail.com>
Subject: RE: Heads up: GMail regularly marking list messages as spam
Date: Mon, 12 Aug 2024 11:26:34 -0400
Organization: Nexbridge Inc.
Message-ID: <030501daeccc$0747f210$15d7d630$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQL2WPSlbE7oYP192nx6CjPSTgRa3a/s5WJg
Content-Language: en-ca

On Monday, August 12, 2024 11:10 AM, Mike Castle wrote:
>If you read the list via GMail, you may want to regularly check your =
Spam label for
>messages from the git list.
>
>I'm not sure what's up with that.  A handful of real spam had made it =
through vger,
>but GMail seems to be hitting a fair number of false positives lately.
>
>Sometimes it is just one message in a patch set.  Others, it is whole =
sets of patches.
>I didn't check to see if there was anything in common across the =
messages.  Maybe
>if anyone has a large batch, they can check?
>
>It would be interesting to see if this affects domain specific users as =
well (e.g.,
>Google itself).

What I think you will find is that some spammers use this mailing list =
to send spam.
Most of it gets blocked because it is in HTML or RTF. However, various =
honey-pots
and organizations like SpamCop detect the mailing list servers as the =
source of spam
so the servers get black-listed or marked as spam. Unless the servers =
themselves
filter out spam before redistributing it, this is going to keep =
happening.

