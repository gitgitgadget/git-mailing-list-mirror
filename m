Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E99559168
	for <git@vger.kernel.org>; Fri, 19 Jul 2024 20:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721421671; cv=none; b=brd91kWxgk/ROlewiu51pnQCmz1AhfgmBIt/dnUtIGhmz6d9yvMxxkKQ49GET5Rg29CwJUbssp19SFW+jXksT8Q8QshNdC+Wh5tJwpjHwnYZwVtZr3EdURpso1mfayO2IRcBgMEJKq7xBJoB54iWrWWbaXCKMQysddzpsTW0wx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721421671; c=relaxed/simple;
	bh=Z/WTbhbcAU9wJRBGRiF8fHjJNX+1Q4Jzne8M8y1CQ7o=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=MPDoNI9Ia5TrplG7KGGY9CEXpCOhlVHxoJgk1FJQqzUmf9sNhTaOUHRWOHnp8dWRvzl9volE9yH0PgZ1I3a7MI6s0p9/6LOBG6ea5ErxxfwUIoZuQOwgMF65m6+QPJr1Gj8zF7zUKYvCibLU/lISm5XmxOGz31ik5ctsO/YkuXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 46JKevxa1295732
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jul 2024 20:40:57 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Roman Dvoskin'" <rdvoskin@mytechnologyco.com>
Cc: <git@vger.kernel.org>
References: <CAKexjB-+6VXE8YXrc1YaOVE6bKs05Ty4XHMSBPRHUcUrxpp31w@mail.gmail.com> <ZprI_wP1km8eA7HA@tapette.crustytoothpaste.net>
In-Reply-To: <ZprI_wP1km8eA7HA@tapette.crustytoothpaste.net>
Subject: RE: Bug report
Date: Fri, 19 Jul 2024 16:40:52 -0400
Organization: Nexbridge Inc.
Message-ID: <019001dada1b$f5a822e0$e0f868a0$@nexbridge.com>
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
Thread-Index: AQKkWI+LfwKXIaGuqPioEuHTFER8qAHYgukFsFzB6BA=
Content-Language: en-ca

On Friday, July 19, 2024 4:14 PM, brian m. carlson wrote:
>On 2024-07-19 at 18:34:29, Roman Dvoskin wrote:
>> Thank you for filling out a Git bug report!
>> Please answer the following questions to help us understand your =
issue.
>>
>> What did you do before the bug happened? (Steps to reproduce your
>> issue) I renamed an existing branch to a new name What did you expect
>> to happen? (Expected behavior) When I git push I expected the new =
name
>> to be used to match the remote branch What happened instead? (Actual
>> behavior) I was prompted to use git push HEAD:<old_branch_name> =
What's
>> different between what you expected and what actually happened?
>> I expected for the new branch name to be used, as if it was always =
the
>> branch name Anything else you want to add:
>
>I'm not sure I understand exactly the message that you saw here, and I =
suspect if I
>don't understand, it's possible other people on the list don't either. =
Could you copy
>and paste the exact output you saw here so that we can see what the =
prompt looks
>like and the exact response you saw? That would help us understand =
whether the
>behaviour you saw is a bug or not, or if perhaps maybe the =
documentation is
>unclear.
>
>Also, to be sure I understand, you did something like this:
>
>----
>git branch -m foo bar
>git push origin bar
>----
>
>and you expected the local branch `bar` to be pushed to the remote =
branch `bar`,
>correct?

Would not the logical way to do this be:
git switch -c foo # Or however the branch is set up.
git push --set-upstream origin bar   # Sets the association to the =
remote branch

I could not get the original attachment (filtered out).

