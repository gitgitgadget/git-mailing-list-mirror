Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE061145B16
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887352; cv=none; b=pzzpLaqrQa1hXzx5J17hehaPqEBPiYOkPTTBlxcB0EzIPkk0W05oxy5gDDXtkrxiYzkBiK2xGClre4Ea1ZfvN4Vq0fpQb9v6EB230GO+0KAVA42ks0Ai7ijc855wZEvXxWC2zUdV9dvwnWBEBEqevBrLQz5SA11c/3TJeyxlTdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887352; c=relaxed/simple;
	bh=UJ1ACw4woZNglp8bAbUQ7DVgwanWxgZk8WxPGtLBOak=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=BZMEafD9y7FMzaGk7YiDZULbR1GBUGJod053bDEz4dKI3M9OL+MqSkvC3HVqoMe+ZXy+3pByoZIrbwq/i0Q1yn4+Tr1o9exFC7Q5aAubIxYAKNAPNNiozMQHwdB4dx23YhT25Z5LcpJrdvkv+t05qiiO68Dx20c8+IJREv1smWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 412FMOfd1709838
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 15:22:25 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Sergey Organov'" <sorganov@gmail.com>,
        "'Hans Meiser'" <brille1@hotmail.com>
Cc: <git@vger.kernel.org>
References: <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>	<AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM> <877cjm53bf.fsf@osv.gnss.ru>
In-Reply-To: <877cjm53bf.fsf@osv.gnss.ru>
Subject: RE: Migrate away from vger to GitHub or (on-premise) GitLab?
Date: Fri, 2 Feb 2024 10:22:18 -0500
Organization: Nexbridge Inc.
Message-ID: <008b01da55eb$9f3c36d0$ddb4a470$@nexbridge.com>
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
Thread-Index: AQMTzlW4975feouBsT254Lv1BIoWdQGhQd7aAcbbN+6uaPlmQA==
Content-Language: en-ca

On Friday, February 2, 2024 9:49 AM, Sergey Organov wrote:
>Hans Meiser <brille1@hotmail.com> writes:
>
>> Hi,
>>
>> is there any current discussion about moving Git development away =
from
>> using a mailing list to some modern form of collaboration?
>
>Yes, now there is (again).
>
>> I'd like to be able to follow a structured discussion in issues and =
to
>> contribute to the Git documentation, but the mailing list currently
>> just bloats my personal inbox with loads of uninteresting e-mails in
>> an unstructured waterfall of messy discussion that I am not able to
>> follow professionally.
>
>Did you consider to rather read the list through =
gmane.comp.version-control.git
>nntp newsgroup?
>
>This way you get only very specific mails in your mail-box, those where =
you are
>explicitly CC'ed, and you usually get more support for structuring from =
NNTP
>readers than from mail clients.

Google is dropping Usenet NNTP updates on 22 Feb 2024. I would love that =
idea, but it has a limited lifespan.

