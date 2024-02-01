Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662948663E
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706792173; cv=none; b=bh0+Ssbg3IRp3L5c9JoAcD6lnnTQw0RGI4at2hkRMvfiw0eX2GTInV9bEr7KOlof1Xz0886es+GyzBAzwR92j7mNS5t499rk4iJTuanLWYoYAsxU5AM0hpODPE5QwEo4TQVG5Xi2B3aI9q9aCtbxPBMmlEceA6VwtC1DmwM/w0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706792173; c=relaxed/simple;
	bh=ceU0zIcOKimqjOoGw/DZnDYxd/iwtBKaPo1UDqLMPFo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=KU1nZHlyi398V5Cd8kyK8Sjom1w2YjESt0N9LSKq9MhM307m0xjQ9ioqIjj2HEw2S2au5UjJ+WT2DWfjQrBAdVt5q/axCBhbyfwNIHSSTVYfQA8HuH1quHtSJEMK2J4BISj8acgxzPDVrZvdOkwEn6x/6Bd6GBSq8JFAJ4RkUrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=GKgueb2F; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="GKgueb2F"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1706792168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lcQcbPgx25I5TrkvpaN90a1snVH0vOxYXp8DHS6H/bU=;
	b=GKgueb2F73FYP6WisUtwReGvtOl8r3EFOoE1WGFomNEjsJuir2HSvvP64r1Fph4l8ET4Rq
	criYpvsMYfyME9hUESCerTv+HUPZVVbs+FmZ3El8gTBHJzp/uqEOBqtq/7HUSzDuZK/hgv
	RraMRIkXXIOhx6h3v9anHURerucLhUQ4zUI7mC+5N70ZK+MalaAUIpITj+Q1SczfweEysW
	0JaNq3rCVvnBOqC6NTKam6zDZ9i8InWcDPSmXv66szWXnPjDGIb1X9L7dkKhYLd9gy6RQr
	1IcsHJUmGdb/J9QP4YqFXwxdyqxaz1yymXhRQFkewdevStzLIqnzfmnozlnPgA==
Date: Thu, 01 Feb 2024 13:56:08 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Hans Meiser <brille1@hotmail.com>
Cc: git@vger.kernel.org
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
In-Reply-To: <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
References: <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
Message-ID: <cf4a0ac7850a9b1e4597830bfd5e1c42@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello,

On 2024-02-01 13:10, Hans Meiser wrote:
> is there any current discussion about moving Git development away from
> using a mailing list to some modern form of collaboration?
> 
> I'd like to be able to follow a structured discussion in issues and to
> contribute to the Git documentation, but the mailing list currently
> just bloats my personal inbox with loads of uninteresting e-mails in
> an unstructured waterfall of messy discussion that I am not able to
> follow professionally.
> 
> Are you consideration for migrating?

Perhaps it would be good to also know that many people simply don't
live in a web browser, so to speak, and live in the CLI instead.  For
such people, having to use a web browser for development is simply,
well, awkward and inefficient.

In other words, as much as not using some more modern, web-based
tools may drive some people away, there's also exactly the opposite
reaction that should also be considered.

There was recently some similar discussion for another open-source
project, but I simply can't find it now. :/
