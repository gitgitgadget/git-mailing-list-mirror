Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124081C578C
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 08:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548866; cv=none; b=jSnmo67kVZLJD5d6Y+eNlCMkKtNzS1h4JZINO3EQsbeB1znjWBNL5tMG4jcxtN7a26d3wWvDqLsulHN6pbeXGbUciBHN+RzO8zBqL4heenCEuZEhPmAAiozCv8y6laG8giHDF/R+UAlEg7/+AF1mN71WOm4VvohKFnl2yNTPrEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548866; c=relaxed/simple;
	bh=OLpqfbUo47Mgg1AF+AqQ6LJo3GkfDbyNDNhOxZ5NoUc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dPauFEMOSdHbaBXJdgi68rYpL5lI757IebcgKW7WtXZ4u51Ayo4TXPvAJ11yVTMW4H7H7wMjTJ45OFLR0toca14cSj5W0hZLPlk/QGDIf9R7RI0ZGEunuYKb4/INNwp/KbtURZmE8YwHBbp7cusD2e1sT8H0x0b/stjfQPgaPJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=6eoAd9iS; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="6eoAd9iS"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1728548859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OLpqfbUo47Mgg1AF+AqQ6LJo3GkfDbyNDNhOxZ5NoUc=;
	b=6eoAd9iSTp6scoM3zGjT6hLUls0Ehczj/IwHpCZtNg/SaVDFNAxtZWkUZ5WLsugTUwCXR1
	XrnzjVHFTUMahdLsi7uYc9y6PgDbqWL1bwJ73iyqiyNP7xt6w8ptc9Axf9VDGC+uHTFlpj
	xeBBiKJwnUCAVGzaS9ykU4raBp79BHE=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, karthik.188@gmail.com
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] clang-format: align consecutive macro definitions
In-Reply-To: <CAOLa=ZTAgaOK3KzsncTq1ZydXFbiG8M7MSsC9S9zUK4gdPPdOQ@mail.gmail.com>
References: <CAOLa=ZRvFBhageS65uE5enzLBz7H_CAvvnEcPsi_QAi0exRx2w@mail.gmail.com>
 <CAOLa=ZTAgaOK3KzsncTq1ZydXFbiG8M7MSsC9S9zUK4gdPPdOQ@mail.gmail.com>
Date: Thu, 10 Oct 2024 10:27:08 +0200
Message-ID: <87a5fcs6qr.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Karthik Nayak <karthik.188@gmail.com> writes:

> We generally align consecutive macro definitions for better readability.
> So let's add the rule in clang-format to follow this.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>

I think it's valuable to add an example what bad vs good formatted code
looks like.

Otherwise no comments about this series.

--
Toon
