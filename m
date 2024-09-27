Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F112913A3F2
	for <git@vger.kernel.org>; Fri, 27 Sep 2024 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727458829; cv=none; b=PvbbVndHX1Rrd36ak/NGw1YQ8jilhmf+wQL6rfPbaNa9qBxhcrZXIzXot10r9R3IujTLs9m6RJvL5qZ/E+RbZnys6MkO1++9VgKpY/hXLsicndywNroXaeA0APCG+RnAWQ9Ws2easscEDCfaP2TrWRctuvo6vuI7EAwni9AYSBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727458829; c=relaxed/simple;
	bh=f35oGC6o1C2QknfXAKVrDXJ7gcQQrfLSJp6jBe2lbOM=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=KUcWWRIC1KkMFOwCNt6I7O0SpqSlNOXQ9fPYRDwwQ+F+JRm1ADJiPwmKX8P5c8nbI1O5kcrgiY90PvbzlFRXWqHhFQ7CtxILMZwTDuSFgTQKawQAJEQY49gQkfWH4IdH0dcjk+ZOyYWp5VVpTWU0XladQVoQSpxnmulRk1v4aHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 48RHeISY1955597
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 17:40:19 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <rsbecker@nexbridge.com>, "'Sean Allred'" <allred.sean@gmail.com>
Cc: <phillip.wood@dunelm.org.uk>, "'Taylor Blau'" <me@ttaylorr.com>,
        <git@vger.kernel.org>
References: <Zu2DmS30E0kKug2a@nand.local> <Zu2D/b1ZJbTlC1ml@nand.local>	<053f01db0b79$0d885b30$28991190$@nexbridge.com>	<m0v7ynm7h0.fsf@epic96565.epic.com>	<00a501db0db2$94d505d0$be7f1170$@nexbridge.com>	<18d732da-ad34-4a45-b59f-cf2cb3c7238b@gmail.com>	<018401db0ed3$667bcf80$33736e80$@nexbridge.com> <m0msjtmo81.fsf@epic96565.epic.com> <032401db10d8$141962f0$3c4c28d0$@nexbridge.com>
In-Reply-To: <032401db10d8$141962f0$3c4c28d0$@nexbridge.com>
Subject: RE: [TOPIC 01/11] Rust
Date: Fri, 27 Sep 2024 13:40:13 -0400
Organization: Nexbridge Inc.
Message-ID: <035001db1104$528b16b0$f7a14410$@nexbridge.com>
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
Content-Language: en-ca
Thread-Index: AQF24rJ2Q0W9JcDOH4N3ZxazDM0CYQHP+YxMAoJn3JIBrepyAwFv0IQDAQwByIYCD0om0QJxxC41AfjkEmiyvJJ04A==

On September 27, 2024 8:24 AM, I wrote:
>On September 27, 2024 5:38 AM, Sean Allred wrote:
>><rsbecker@nexbridge.com> writes:
>>> I do not know whether Rust will never be available. The policy is
>>> that the Rust maintainers must sanction and approve any ports. I have
>>> tried to get approval and have not been able to do so. It is not for
>>> a lack of
>trying.
>>
>>I do not see a proposal for "NonStop" in a pull request filed against
>>rust- lang/rust[2] per the process laid out by [1]; can you point me to
>>where you submitted this request?
>>
>>[1]: https://doc.rust-lang.org/rustc/target-tier-policy.html
>>[2]: https://github.com/rust-lang/rust/pulls?q=is%3Apr+nonstop
>
>I will investigate where this went.

I have taken this up with the platform vendor. Any request of this sort
needs to come from them, in my opinion, even if I do the port.

I will advise the list if I get anywhere.

