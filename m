Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0606253B58
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770569801; cv=none; b=FWay19yxQTC0IN+9mSVA5mw4oPhyVxURBLj7hN2TZViXXzawrwxOhUDA2YCs4UaFuS0DiC3W8hesUlqp0Qi189FnASbZ+C+bpU+si0Lyfr4oH05mq54CNPuHPw6hMp7qhc0ynvqLQrmLc3l3gCfyjTN2bmbRVBeojyu+Qs4bXcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770569801; c=relaxed/simple;
	bh=mby44+PQXhkXaxtme4UoRIvODHaZc3eOD29qvBXz9zI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CDbB5ZUEOddFTb72K/WfuFpSzgIUcyAO7he3idlQ+OsEU5nSRQ272brpfr/oDoDYVnsIQDSMPhMpb57XftkM6qK9qgsJOrfUUc2/K1x2OmoaYeShW9ELE7qEpeJN3G/gWnasGHDMb/NWjd+s0pQUKiNe1W0Z4SzGvF/EYt29BJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.107])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4f8DW454wjz7QZ1P
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 17:56:32 +0100 (CET)
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4f8DVv32HWzRnlX;
	Sun,  8 Feb 2026 17:56:23 +0100 (CET)
Message-ID: <51aca4e7-3115-4dc2-aa59-e648c2958f64@kdbg.org>
Date: Sun, 8 Feb 2026 17:56:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSOC] Is adding 'dart' to userdiff.c a valid microproject?
To: soutrik das <valusoutrik@gmail.com>
Cc: git@vger.kernel.org, Pushkar Singh <pushkarkumarsingh1970@gmail.com>
References: <CAPHqhPmiMYLE_v03i-CzsBmonsNiY2PeeaGgP_AUthKhK=NoCA@mail.gmail.com>
 <CALE2CrR_Xrei32pc_gJ16mArZPjZ-+bNWWFnsJ3i+OGqbxwPcg@mail.gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CALE2CrR_Xrei32pc_gJ16mArZPjZ-+bNWWFnsJ3i+OGqbxwPcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 08.02.26 um 10:13 schrieb Pushkar Singh:
> On Sun, Feb 8, 2026 at 9:50 AM soutrik das <valusoutrik@gmail.com> wrote:
>> I saw that the 'dart' language was not present in userdiff.c's list of languages.
> 
> Yes, adding a new language entry to userdiff.c is a valid contribution
> and a good way to get familiar with Git’s workflow and review process.

But be aware that it's at the challenging end of the spectrum for a
microproject, if not already too much. Microprojects focus on the patch
and review workflow, while the solution itself is usually fairly simple.
A new language in userdiff.c isn't necessarily of that kind. Among other
things, we expect that the code change is accompanied by test cases.

-- Hannes

