Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9CD7464
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 00:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738197447; cv=none; b=HXNJSMZ3U59fXQWE4ICV5tWkeAV+PjyL5og4NtXQhM/KLD/CLUO4Ue1obfeb7wwLnzsx2g1ClaqelLCjYOvJ99lKxOQTN2vNsUn2PrLImqkv3oOg+vvAi4Q6X8mmb/9IglPbj1Et4mot+tDjZDh0hIXysQAQZWhi8Mrx0ej4NBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738197447; c=relaxed/simple;
	bh=Eg7aDk6IqlbaQkpxMhsFZ6yn2fJ/uvUMGknVkcawMYo=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=V7sfoLqrcblSIb4qJ2hqPXPcawX6k/UKtjkcQu1WB3vMre+WiFKNxg+Zo7S8Bu5AIptSTlrGYN7/8J9N5sWZlbGoetpVw3SGvCXJM7u1XjUS9hxdQ6+//EIzRFR/+pWo8gPEP6g7ViKlZHx9WE+AfwVX1vXfbJboQd2vzA/YYT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 50U0bLKV2043758
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 00:37:22 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
References: <007f01db726b$ac911ce0$05b356a0$@nexbridge.com>	<xmqqbjvpk1wo.fsf@gitster.g>	<008201db726f$6e6990b0$4b3cb210$@nexbridge.com>	<xmqq5xlxidh6.fsf@gitster.g>	<009c01db728d$164a60d0$42df2270$@nexbridge.com>	<xmqqwmedgpkf.fsf@gitster.g>	<001201db72a8$72719480$5754bd80$@nexbridge.com>	<xmqqfrl1gosc.fsf@gitster.g>	<001501db72aa$fc812350$f58369f0$@nexbridge.com> <xmqqbjvpgnea.fsf@gitster.g>
In-Reply-To: <xmqqbjvpgnea.fsf@gitster.g>
Subject: RE: [BUG] PREFIX environment variable ignored by git config --system
Date: Wed, 29 Jan 2025 19:37:17 -0500
Organization: Nexbridge Inc.
Message-ID: <001801db72af$20a35560$61ea0020$@nexbridge.com>
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
Thread-Index: AQN9fsp86lG5K0M4uVvG8mjsU9to7QHrUQSBAdADBhMChc+5BwBRHwqvAunZ6BQCaak4ygJoX8LsAzJTt7YCPhTGL69Ma/bA
Content-Language: en-ca
X-Antivirus: Norton (VPS 250129-6, 1/29/2025), Outbound message
X-Antivirus-Status: Clean

On January 29, 2025 7:24 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>> This appears to do exactly what I am looking for. When I create that
>> file, git picks up config values from that file.The question is, is
>> this environment variable actually sanctioned or is it just coincidence?
It does
>exactly what I am looking for.
>
>How about reading "git config --help"?

Yup. It's there, thanks. So should I figure out how to sync the website with
this
or ignore it?

