Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D31B18FC75
	for <git@vger.kernel.org>; Sat, 11 Jan 2025 15:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736608087; cv=none; b=cu2E5oUvLz8XoC/KvgOu+4Yiw6dUrkHb2dH7ijwlOgQIwEetC7MM2YBBP1+GHJXEmXH5pWTUsP5DXbgVa5LyKi6HdLmYAxSY/VT3NHxi6KleLUn9CrPhPn4n+CDkaQlV2CUkqN9/ySkaEiumJr1hQ0sRNn0qc/NsLqh607M89nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736608087; c=relaxed/simple;
	bh=Hi8EzFBA1KTgnMW9Dkl2Gzb9+mQ7Jlm0977KZxYEbFc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j8WkWR0zklro4nQdkRhJcsKx1g+ys2+pY3vMuboU8B6cKjHEiixjKOQt+T/m5XWbAUgeOLZt3uuaGrisWEGhz52MOWA5QQS0PgmBgEJLewDykbQQQfHXwlsJngk90xcHUtDfmSalCmIlf6Oypof/1I2Xjo/Zqmbc49MvcLGUNt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 50BF82Ev2455710
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sat, 11 Jan 2025 15:08:03 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <git@vger.kernel.org>
Subject: [Question] etc/gitconfig and .gitconfig missing errors
Date: Sat, 11 Jan 2025 10:07:57 -0500
Organization: Nexbridge Inc.
Message-ID: <021501db643a$9c5357b0$d4fa0710$@nexbridge.com>
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
Thread-Index: AdtkOefcaHkN+4nrT+qPyxbrMatGZg==
Content-Language: en-ca
X-Antivirus: Norton (VPS 250111-2, 1/11/2025), Outbound message
X-Antivirus-Status: Clean

Hi All,

Question from my community. The standard git install does not automatically
create
the /usr/local/etc directory if it does not exist, so the git config
--system fails.
If etc/gitconfig is missing, the command also fails. Similarly, if
~/.gitconfig is missing,
git config -global fails.

Is this intended? I have been telling my people that they should pre-create
those files
with appropriate security. I have mused that having git auto-create this
file may
introduce potential CVEs, explaining the situation. Is this assumption
correct?

Thanks,
Randall

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.



