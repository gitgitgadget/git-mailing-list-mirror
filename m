Received: from st43p00im-ztfb10061701.me.com (st43p00im-ztfb10061701.me.com [17.58.63.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8ABBE47
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 07:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.63.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564281; cv=none; b=NUPxwvoawKK+fZYEaTKV5o0gItifd2+gZahihY5OJX8QHSPInV8w/8S8tGexBO83pQ/sbwJAtjp8CS9jz7bLS5/xwAjRNm1DkJ2BQKzyrCq/K9OK1MCVpT0zCtqKp39l602jVOr02PmY2SlbximnYA5xHtAz+T9gfebSlvEgNNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564281; c=relaxed/simple;
	bh=Xy/5fU93UkOJQ0C/AXZEIn+X4jFSyYI3c/SxNIzLMjo=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:X-Mailer:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=ld7r8XGkcPXSlzx6+oCB7jTFjzx4aUFSYpR2bIniU7sQsfZylx4XCmrngSS8q8f3ZHBqwGZGbKNZOXvCReiH3KmP1GrF9VdRY/N1o7xJn7pDfOFNfDBLpqgpZuNRx1sRkluW0Dj7UaG3VjT2iJ8ZlK6omUmr3rtkYgThb7IUgSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=wOEVI4TC; arc=none smtp.client-ip=17.58.63.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="wOEVI4TC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1705564279;
	bh=9ad+wsJBjiN4xm6fj5iWqXjkWELEWYN4dAhdVKGjHiI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=wOEVI4TClXXhBTjiZIKXmoIbEv/knX9PauSB7pXkelNXyG/QQQ+un9UwfTFWHueqD
	 l/o0NTivrsIpe6Cv7jHF6E8d2T88YtqCKpmh3HQeEvzGPr89L7NfnBX3iCkaz6WkxE
	 J8lCzK5DzrgVQjNOHI7/oeIMph71JEOle/l7H9PYXljG2s8J2L2g77xJtOyIuw6FH1
	 BnRrW6SdaKd/PK8uzm3WfJbYhW24w9/gCamhi9P3GwBM2iHXZd/5CNJUe8i+pnoB/V
	 6ppVu1ujbJnGiE9wfJYsiCO6U5Bayx8pifV9p/F9Fj/Ze0EvH/cWzbz2MC0KfHRDjA
	 UBYD5Xai242YQ==
Received: from [169.254.204.93] (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
	by st43p00im-ztfb10061701.me.com (Postfix) with ESMTPSA id 2AAF32E0170;
	Thu, 18 Jan 2024 07:51:18 +0000 (UTC)
From: Sebastian Thiel <sebastian.thiel@icloud.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren <newren@gmail.com>,
 Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Josh Triplett <josh@joshtriplett.org>,
 Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] precious-files.txt: new document proposing new precious
 file type
Date: Thu, 18 Jan 2024 08:51:16 +0100
X-Mailer: MailMate (1.14r5937)
Message-ID: <298F7067-D572-433F-A7DD-5256B43B97D7@icloud.com>
In-Reply-To: <xmqqsf3nl2b3.fsf@gitster.g>
References: <pull.1627.git.1703643931314.gitgitgadget@gmail.com>
 <xmqq8r5gfc3j.fsf@gitster.g>
 <CABPp-BGSTYDUR1oYYXkCSh-1i2zwxBM=-gnoe-ezNbtPi5CV2A@mail.gmail.com>
 <xmqqsf3nl2b3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: 0yEcshn_PwxXZfXjnskK89sFG22SSxvI
X-Proofpoint-ORIG-GUID: 0yEcshn_PwxXZfXjnskK89sFG22SSxvI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_04,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=991 clxscore=1011 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2401180055

I thought it would be helpful to see the syntax being referred to here,
as first brought up by Phillip Wood:

#(keep)
/my-precious-file

The main benefit I see for it is that it's extensible, despite having
trouble imagining what such extension would be 10 years from now.
On the flip side, since it's already using a comment, people will
be even more inclined to document the reason for the preciousness
of the file.

# The kernel configuration, typically created by running a TUI program
#(keep)
.config

As a side-effect of the syntax, it's obvious this is an 'upgrade', with
perfect backwards compatibility as old git does the same as always.

I'd love to take first steps into the implementation, and if the above
should be the syntax to use, I'd be happy to submit a patch for parsing
it, along with initial support for precious files in `git clean` and
`git status`.

Does that sound like a reasonable next step?


On 27 Dec 2023, at 23:15, Junio C Hamano wrote:

> Elijah Newren <newren@gmail.com> writes:
>
>> There are
>> precisely two choices in our design for how older Git versions can
>> treat precious files:
>>   * ignored-and-expendable
>>   * untracked-and-precious
>> If we pick syntax that causes older Git versions to treat precious
>> files as ignored-and-expendable, we risk deleting important files.
>
> Yes but not really.  I'd expect the adoption of precious feature and
> the adoption of versions of Git that supports that feature will go
> more or less hand in hand.  Projects that, for any reason, need to
> keep their participants at pre-precious versions of Git would
> naturally refrain from marking the "precious" paths in their "ignore"
> mechanism before their participants are ready, so even if we chose
> syntax that will make the precious ones mistaken as merely ignored,
> the damage would be fairly small.
