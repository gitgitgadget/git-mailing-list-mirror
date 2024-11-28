Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42521C6B4
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 01:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732758920; cv=none; b=iwOl22Ue8GtfH8PiZUva64wUicUP/yQ56NA+R85I5RDo382GqZVzR2woYJeMr3ty7xLQlZRQvYJJu22sHONWtEFI7oLKk8faLMdsLwQ921RpH8klgS+E0m4Z0pqV8DoCesTbCeTt0us9LqgtzwQvSzJa91A/5VsYqLpNL+ii+Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732758920; c=relaxed/simple;
	bh=onduime52/mkGI2QOa/SSFO4noTEheRABof4euqU5aU=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=OaGYqbJ3zahip8uDrD9MXfjB1c+tp0LKeUni8OIMG0rodEMVMF6BtplDQTQNUrNof7VCLlBCKlZyWnrRrsnbIbD1yQamxW6cryXZdqGnESS77TC6eNqGYRh91VqGw8d3r73QRZzdpHBMO2McovplUPdsw+pRzA/tA3cTfoMtX5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 4AS1t6r42033673
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 01:55:07 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <junio@pobox.com>, <git@vger.kernel.org>
References: <xmqq5xob6coo.fsf@gitster.g>
In-Reply-To: <xmqq5xob6coo.fsf@gitster.g>
Subject: RE: [ANNOUNCE] Git v2.47.1
Date: Wed, 27 Nov 2024 20:55:01 -0500
Organization: Nexbridge Inc.
Message-ID: <027201db4138$8ce7b110$a6b71330$@nexbridge.com>
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
Thread-Index: AQLP/SIomF0GoU6jlXXvh6jX9USCyrDidmzA

On November 25, 2024 1:38 AM, Junio C Hamano wrote:
>The latest maintenance release Git v2.47.1 is now available at the usual
places.  This
>flushes some fixes accumulated on the 'master'
>front since Git 2.47.0 but the primary purpose is to synchronising "gitk"
subtree
>with that of Johannes Sixt, who volunteered to be the new upstream
maintainer of
>it.  Huge thanks to Paul Mackerras who started the useful tool and have
maintained
>it so far, and to Johannes Sixt to volunteering to move it forward.
>
>The tarballs are found at:
>
>    https://www.kernel.org/pub/software/scm/git/
>
>The following public repositories all have a copy of the 'v2.47.1'
>tag and the 'maint' branch that the tag points at:
>
>  url = https://git.kernel.org/pub/scm/git/git
>  url = https://kernel.googlesource.com/pub/scm/git/git
>  url = git://repo.or.cz/alt-git.git
>  url = https://github.com/gitster/git

Packaging is done for NonStop built with OpenSSL 3.2 and lower. Working on
git
dependencies for OpenSSL 3.3 and 3.4.

--Randall

