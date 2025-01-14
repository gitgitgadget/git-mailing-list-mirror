Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5526A23244D
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736867352; cv=none; b=FBAgCJUSsLin1zn7i72H6HEaaTpqdpTmFcZx37/yLV55Mmfp7f6YkUoTrRdCN2v8J/V4uwzbVNs26SsxeQPIb2CJg0XRtViCfSPQXE4byjIeaeGB8t3nFt59bwYREgdD8TEF5kVUho11PfgQoGx8LLs2pXy6BjJ/H/sNwKWT8uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736867352; c=relaxed/simple;
	bh=u/rfAokdN9rClqKRtPF7m14tI7mxK5MmRmPeb7stqtU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XcDwkR8QTjtgSSEtkqh1deVhuiuVoXVVbifvVKwpqFt6uRKI7nf7TSECXmbd9CFwi8rnYlDAOekPbGwvlpsNZTjskjjZhq/U0pE7WoDH39/UHToujG7KQt2FYk3fCXupkziZnNVKxcEuZ+sEl28mC+nnHiDmzlfdKb/GCrQwqHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [PATCH v3] meson: fix missing deps for technical articles
In-Reply-To: <Z4Z8Mg2IME0mveHJ@pks.im> (Patrick Steinhardt's message of "Tue,
	14 Jan 2025 16:01:06 +0100")
Organization: Gentoo
References: <5114dc9a00377826a55f6bab007d2ad1a4de8bc5.1736866030.git.sam@gentoo.org>
	<Z4Z8Mg2IME0mveHJ@pks.im>
User-Agent: mu4e 1.12.7; emacs 31.0.50
Date: Tue, 14 Jan 2025 15:09:07 +0000
Message-ID: <87a5btwhyk.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Jan 14, 2025 at 02:47:10PM +0000, Sam James wrote:
>> We need an explicit `depends: documentation_deps` so that all of our
>> Documentation targets know they require asciidoc.conf. This shows up
>> as parallel build failures with it not yet being available.
>> 
>> Other targets look OK already.
>> 
>> Signed-off-by: Sam James <sam@gentoo.org>
>> ---
>> v3: Fixed commit message.
>> v2: Drop incorrect dep I'd added for api-index.sh as pointed out by Patrick.
>
> Thanks, this version looks good to me.

Thanks, and sorry for the (obvious) errors.

>
> Patrick
