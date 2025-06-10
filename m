Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B297A13212A;
	Tue, 10 Jun 2025 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749567686; cv=none; b=MBWkQUdXGTD7yrxcaQloqWcf4aXEfo3/xtGrMcMJw0sLX13FY5OAgxRCB9q98MO23SxjfqacqQM/9UkodCkOiQ1tOC6ELqD3Cvix9YZhX6Y7rXFZ6WG4mw+hVTmFjF0GR3aquL3y2CnR/nxfy5bh2DMxzlaY8pJfOvIJYjPLIe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749567686; c=relaxed/simple;
	bh=zLb8E0TT5xS3qwPtVw/itFSUC79nOHAuhcy/HOZBv8E=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=UOjAxfIxDMEL6Zv3NQEB1Hw6SGI4YFaN9fM9d/lHF+pMbXbJ0g26B5PtO6ggG5D6sK5ErFRZiZ0UFWE0CAEfMpkSZQVVaEhDHWz+VveSXRW+F54JCnPNEImNmCaiB6umdUuGkR3egpH6QkPzOlwkNZ3ZI5PqNsVSnIc7uD6+5b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 55AF1DmF1790293
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 15:01:14 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc: "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
        <git-packagers@googlegroups.com>
References: <xmqqfrg8surr.fsf@gitster.g>
In-Reply-To: <xmqqfrg8surr.fsf@gitster.g>
Subject: RE: [ANNOUNCE] Git v2.50.0-rc2
Date: Tue, 10 Jun 2025 11:01:08 -0400
Organization: Nexbridge Inc.
Message-ID: <008801dbda18$828e5d80$87ab1880$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJnrRbUnLH2+fPEetiagZnGfaqIibLk1plg
Content-Language: en-ca
X-Antivirus: Norton (VPS 250610-6, 6/10/2025), Outbound message
X-Antivirus-Status: Clean

On June 9, 2025 1:13 PM, Junio C Hamano wrote:
>A release candidate Git v2.50.0-rc2 is now available for testing at
>the usual places.  It is comprised of 604 non-merge commits since
>v2.49.0, contributed by 85 people, 33 of which are new faces [*].
>
>The tarballs are found at:
>
>    https://www.kernel.org/pub/software/scm/git/testing/
>
>The following public repositories all have a copy of the
>'v2.50.0-rc2' tag and the 'master' branch that the tag points at:

RC2 passed on NonStop without TCL. Thanks to everyone who helped.
--Randall

