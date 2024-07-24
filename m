Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329B815B554
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721838837; cv=none; b=DTql6/W0/hFNarkC3Mj7Qq+n5gJxC3BmMcT7g4p1puSya+uNeGbx8sYpO28+Q2ZRZeOpCiwUdKTX3q5l1RmNoCpI3smL7Bp93l5aojZ0kH5J8YNmHMW8cbGB/rBxAET6pc+JiYMy81NQYRvYrsNEAebl/VszBtMi2FV21CbbYS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721838837; c=relaxed/simple;
	bh=eVQVZ2oXdxGj1rrUSxaYcbDgpNFluNkWoOAXiV1oIQo=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=BiweCbum39JZjyAmD+oQEV+oGq2M/jbtxe1BhYhLx2L1qWzcMzZuiii58x3Ag4tKMREf/DlVrmLU98HUFU1Du3QoB/PO6Jwco6zTt4iW1Nr/A5q9v3W4DN9Fs30Dmgs+RAdOK9s2wCXTwqTDQJuNBvi+Rn7VDo/LAmtpJW9e3l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 46OGXeu62041764
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 16:33:41 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>,
        "'Randall Becker'" <randall.becker@nexbridge.ca>
Cc: "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Randall S. Becker'" <the.n.e.key@gmail.com>, <git@vger.kernel.org>
References: <20240621180947.64419-1-randall.becker@nexbridge.ca>	<20240621180947.64419-3-randall.becker@nexbridge.ca>	<80112f79-f2ec-28ff-3ced-9df9d7ea87f0@gmx.de>	<DS0PR17MB60311800BF14CC1C5C7E707FF4D42@DS0PR17MB6031.namprd17.prod.outlook.com>	<0bec87dc-d852-4133-1e6d-11e9a1c5df2c@gmx.de>	<DS0PR17MB60312EE0F4B6679DBEEDAB42F4AA2@DS0PR17MB6031.namprd17.prod.outlook.com> <xmqqed7iyd4i.fsf@gitster.g>
In-Reply-To: <xmqqed7iyd4i.fsf@gitster.g>
Subject: RE: [PATCH v2 2/2] Teach git version --build-options about zlib versions.
Date: Wed, 24 Jul 2024 12:33:35 -0400
Organization: Nexbridge Inc.
Message-ID: <051501dadde7$3ea474c0$bbed5e40$@nexbridge.com>
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
Thread-Index: AQIUAP7e2wQYDPiBW6KIInLGycvnFgG9Wnw3Ayy4Fz8BeWs9XwE/MQ0JAnQ+rQ0B4nacLbE0ARyw
Content-Language: en-ca

On July 24, 2024 12:22 PM, Junio C Hamano wrote:
>Randall Becker <randall.becker@nexbridge.ca> writes:
>
>> What I actually proposed was splitting --build-options with runtime
>> (some representative argument). This would allow the headers used at
>> build time (--build-options) to be reported *and* the runtime
>> (probably) DLL versions (but would also report static linked library
>> versions) to be reported. Both are useful from a support standpoint.
>
>That certainly is a reasonable future plan.
>
>> However, the --build-options argument was intended to report an
>> invariant set of values used during the build, so I would rather not
>> conflate the two distinctly different semantic values.
>
>This reasoning makes sense to me, too.
>
>Please wrap overly long lines to reasonable width, by the way.

Sorry about that. Outlook is a pain in that regard, and different recipients
define different line lengths.

I will do my best in future for git.

--Randall

