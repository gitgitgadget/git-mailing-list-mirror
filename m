Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3B31A9B5E
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 23:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737155941; cv=none; b=GKLgZBiXcglTY3l4q6U1QIAe0b4/91yV5G9Y/jnniWqP+L5i+0qYYmCmYztKM+YoJFhtMPww6minS0UukdDCqy0vTB8QvTG+FpEQUtuqiHWo3zI7C8zHeos9UBcDdU7IMz88DU0PSPiWk7wbET+v0Pzzdh8im37nhlXD3YBbkT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737155941; c=relaxed/simple;
	bh=9+djXdC/yjHZwJ7VjWm9qNCxOKCYUi2b9bZ+PoIdqaY=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=NkEOHpLweocfY2i/JQmlSeJXVkEtn2U9ccEb8wvhtEkx1O04MQUz7XN7wBqWt/+0dGgqF8xxJ5c4TQNuT0r7x5sOW8YqE92qTNpWUtUXfkp+KVtbeTdrspZCdBSCMVTU9lM6IaPxwAJ70s+T41U6YfqQbetmTyBUeXWCOGNRgN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 50HNIkYb3836460
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 23:18:46 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: "'Usman Akinyemi'" <usmanakinyemi202@gmail.com>, <git@vger.kernel.org>,
        <christian.couder@gmail.com>, <ps@pks.im>, <johncai86@gmail.com>,
        <Johannes.Schindelin@gmx.de>, <me@ttaylorr.com>,
        <phillip.wood@dunelm.org.uk>, <sunshine@sunshineco.com>,
        "'Christian Couder'" <chriscool@tuxfamily.org>
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>	<20250117104639.65608-1-usmanakinyemi202@gmail.com>	<20250117104639.65608-7-usmanakinyemi202@gmail.com>	<xmqqwmethxyq.fsf@gitster.g>	<00bc01db6932$1eed21a0$5cc764e0$@nexbridge.com> <xmqqfrlhhwga.fsf@gitster.g>
In-Reply-To: <xmqqfrlhhwga.fsf@gitster.g>
Subject: RE: [PATCH v2 6/6] version: introduce osversion.command config for os-version output
Date: Fri, 17 Jan 2025 18:18:41 -0500
Organization: Nexbridge Inc.
Message-ID: <00bd01db6936$28fa89e0$7aef9da0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQL1iKQeqDpt8guF+jE2EcHccRlcdgGGCMwEAb1tHEECbCriYQE2huoPAjuQoimwnk0FAA==
Content-Language: en-ca
X-Antivirus: Norton (VPS 250117-8, 1/17/2025), Outbound message
X-Antivirus-Status: Clean

On January 17, 2025 6:06 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>> On my box, uname -srvm = "NONSTOP_KERNEL L24 08 NSV-D". Is this going
>> to Break anything?
>
>If you are happy with that string, then there is no need for
osversion.command
>configuration variable, is there?

I am fine with that string. If that's what will work by default, it should
be fine.

Sorry about my confusion.

