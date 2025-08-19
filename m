Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FADF34321D
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 20:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755637091; cv=none; b=gNjaPHb+CwYouLXhsiHCm6x200wGXBVBAfEo4vSnAtvD5o6hA32oYo132f6n6MP+y5pm5TJolIN+QRrigxQb1M5wA1o5WacuMvk1WumRdPTAydgD0WMjYxDRyEcw6D29H+iF3Cq6fT/ge1qLA76S4fvjFEE8HhHZVHcFDzG/6u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755637091; c=relaxed/simple;
	bh=e1NDJuShAsJgKhLenndWIOhLXKDPYKOU1oZvFBQrQ+0=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=XwcQ8alJ7/bi+psabHPhsqeTqKPYHOhawl/hbEHKuhe81m/R/dMTctQb/MSAbqIsvqUTh+JNx0nXwngXZ3idbirEpmq1bdONe9WSl+v0z3+Z5/tckY6D7mCVUCUZRIn98WvqJK3vKmaNk3awOHlgDuZ2oLsOBWMGKVxJLWE7iTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 57JKw0c32451561
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 20:58:01 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Chris Judkins-Fisher'" <chris.judkins-fisher@donorschoose.org>,
        <git@vger.kernel.org>
References: <CAAn3O_2n75RGpvxv1o14BE3KFdwiJW9OOKaHp6_c0rd_MqxC2Q@mail.gmail.com>
In-Reply-To: <CAAn3O_2n75RGpvxv1o14BE3KFdwiJW9OOKaHp6_c0rd_MqxC2Q@mail.gmail.com>
Subject: RE: git whatchanged
Date: Tue, 19 Aug 2025 16:57:56 -0400
Organization: Nexbridge Inc.
Message-ID: <011801dc114b$f38bb130$daa31390$@nexbridge.com>
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
Content-Language: en-ca
Thread-Index: AQHsFvP7gX54FcGLOe//MIdKXIkh5rRKaMAQ
X-Antivirus: Norton (VPS 250819-6, 8/19/2025), Outbound message
X-Antivirus-Status: Clean

On August 19, 2025 1:51 PM, Chris Judkins-Fisher wrote:
>I still use git whatchanged

I did too. However, now that git log --since has basically the same =
functionality,
Perhaps setting up a git alias might do the trick for you:

git config --global alias.whatchanged 'log'

so

git whatchanged --since=3D"2 week"

or something like that should continue to work after the command is
removed.

