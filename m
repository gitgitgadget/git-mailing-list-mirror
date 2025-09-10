Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B3E24C676
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 23:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757548491; cv=none; b=TxzTVyerUOMAx3vpK01Ki56YIAi8KxZIXAgG69GJ8eB3m5YoRME8hD2+OL3sr9C2GS5lLlGcUVvx24b68U+uvVTsDp4fvRgig4FNWoNPMKUkdOX7q2nal5sJu14ha5JbZ0IJPxxxvqqzHJrKs4ZkXmRj7UTDuxDOip0jTS32AWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757548491; c=relaxed/simple;
	bh=Hdbwe8LSQY29qYRPdru7Cy2wmSdzlNd7wWoh6uk62sY=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=u478z3S2kFkLcOWAp2ZAJ/NjtFY6/Tn0Pfj9Lb3X0XJ3vyMWbMsFP1fuzgks8325wcMWGgdXSbbXHa1/rQAegAgSJ3LDeHPcWKO1eJNTtHkwDbMXQPh8nxnJvjQgs5K+lQl5NAdVfnMvnY+b9qRT08+Cj/5r4dcAtlrXx7VdBvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 58ANscqr3576208
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 23:54:39 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'ynckz'" <yanckezcs@gmail.com>, <git@vger.kernel.org>
References: <CAGyVUB5QLV+HQMWT+0kDu1_H0uXHK7kTy35WqhXQaETZ5if5EQ@mail.gmail.com>
In-Reply-To: <CAGyVUB5QLV+HQMWT+0kDu1_H0uXHK7kTy35WqhXQaETZ5if5EQ@mail.gmail.com>
Subject: RE: Git private branch Feature Suggestion
Date: Wed, 10 Sep 2025 19:54:34 -0400
Organization: Nexbridge Inc.
Message-ID: <061501dc22ae$45ac35c0$d104a140$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFEpuLzRhOdciwLa5ROn+p9KHoUFbW8Dgcw
X-Antivirus: Norton (VPS 250910-4, 9/10/2025), Outbound message
X-Antivirus-Status: Clean

On September 10, 2025 7:29 PM, ynckz wrote:
>I have a request for you. Could you please add private branches? This =
is a really
>useful thing.
>Imagine that you want to publish your project as open source, but you =
need to hide
>the .env file in a separate repository. It's easier to do everything in =
one repository,
>but in a different branch. Maybe there is another way, and I'm just =
dumb as fuck,
>but here's another example:
>Say you don't want to release a new feature yet. To do so, create a =
private branch,
>make the feature there, then merge it into the main branch.
>
>Maybe I'm a dumb ass, and don't need to ask this of you, but GitLab, =
etc., anyway,
>I'd appreciate it if you could add this feature.

Put your private content into a submodule and set the visibility of that =
submodule
to private in GitLab. Your *.env files go in there and will not get =
shared.

Once you have this working, please try to use polite language instead of =
what is
In your message. Thanks.

