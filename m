Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E19340A4C
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 19:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766171121; cv=none; b=Fi8EEkxflw0phKXvRAPRV6uqs2v5uCv+Yi5OOaCJ8OwqN9HxR5FY6QzGH3aVT32upXePGsIYiXLOpgf1JZVGXHqSaJ5r6+NPLU7Hsp++g6l6azzqGvBLF7f5ih01XeKIujoVqrWfii4b208guI1lLwI0GJQpLPnJZJhFNEzXxOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766171121; c=relaxed/simple;
	bh=769zQVGpcN6K98Q+ZL3vJpYnlPnCJBCtifm0+1qeob0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UWkTCMbDVXPFci6JxIC2AtPungiO7uTZjv16uf6dwLbz85agofz1rwF4j9aV4nifgMIEaKIe0NF7zX9Wp9O5AAGTmiqnoaM67VjL0JuMuWkEwI10VKKBcXcoO9MLt0DIzXr2A/3iOf+S4AbMqte4DzbBvuE8C0Ln2OvkJppwOPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 6E26E4CEA8
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 19:59:40 +0100 (CET)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:4db7:bdb8:c69c:cb75])
	(Authenticated sender: jn.avila@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id A7857780371;
	Fri, 19 Dec 2025 19:59:30 +0100 (CET)
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <avila.jn@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: What's cooking in git.git (Dec 2025, #06)
Date: Fri, 19 Dec 2025 19:59:30 +0100
Message-ID: <5950078.DvuYhMxLoT@cayenne>
In-Reply-To: <xmqqfr96v2oe.fsf@gitster.g>
References: <xmqqfr96v2oe.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 19 December 2025 17:47:45 CET Junio C Hamano wrote:

> * ja/doc-misc-fixes (2025-12-15) 1 commit
>   (merged to 'next' on 2025-12-18 at d30d8cac71)
>  + doc: flock of small fixes to various documentation files
> 
>  Various documentation fixes.
> 
>  Will merge to 'master'.
>  source: <pull.2016.git.1765830229824.gitgitgadget@gmail.com>
> 
> 

After a review by Kristoffer Haugsbakk, a V2 has been pushed.


