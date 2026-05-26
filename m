Received: from a10-132.smtp-out.amazonses.com (a10-132.smtp-out.amazonses.com [54.240.10.132])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CB835CB6A
	for <git@vger.kernel.org>; Tue, 26 May 2026 09:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.10.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779789520; cv=none; b=VoakFbeoOmlDUIzGVNRbNplSlTgjStQnl6yuZma4xLOa+yemBavg0HMBQD5MLB1ip51tM39R2zYuRIp86qB951FT99OwFrtC9g1lek1BGFM44Qkn+lFKbDDUgbih0xtxHMRXtZM6v9GYyBjVcZ41pWATb1I4eXZf/RgUkUdz21I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779789520; c=relaxed/simple;
	bh=FCbcfefCPDWNYxRhGz9e+0YSrI5OMWLO1Btz1PB7m18=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=aWQHqKSg8CPjA3JMNkEHNa68WCYgfIeYyJJdmsmz0yAE7rn9Vt3yzg1uOv1iqDdaOcPbLIk5hANqiBHcI2m+eeK2AN0Bd1qwdyQ9h5wS3kehBw+nGRB9Khx+3oo1Axw41RVP8WtvMndDXB4WnU6/0bl5KStypFZcFWUAZ7aB67Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solutions-corp.org; spf=pass smtp.mailfrom=send.solutions-corp.org; dkim=pass (1024-bit key) header.d=solutions-corp.org header.i=@solutions-corp.org header.b=qu4sVryy; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=Np2Dwfsh; arc=none smtp.client-ip=54.240.10.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solutions-corp.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.solutions-corp.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solutions-corp.org header.i=@solutions-corp.org header.b="qu4sVryy";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Np2Dwfsh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=solutions-corp.org; t=1779789518;
	h=From:To:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=FCbcfefCPDWNYxRhGz9e+0YSrI5OMWLO1Btz1PB7m18=;
	b=qu4sVryyxmg/EoXtf5kvVNzqwNRkCqnC2AVc+c20U5sVOOgj9LPMRmWMOw/QgKac
	kWaZjhK6VlYpVrNCaRo+q3K+ZqQqRB2fhSFBy62bxWFd1bTrTxcPHf+cFn1cAWIQoDS
	RE/D7gIP8qAMIbYnFYdOB8h7iJpOfAy//mheZaaY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1779789518;
	h=From:To:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=FCbcfefCPDWNYxRhGz9e+0YSrI5OMWLO1Btz1PB7m18=;
	b=Np2DwfshxilnrCx3WIkBnZT5ua9aaMsnblFOjh7lel2rq9xECtUKmM51L0qhRgwG
	ZhOZ1BBwWF8LP7a2pmZYm1WM7eGQzWeO/N3e+3oVx2qvC+0pbGv4YP7Q9B/nUx5LcLT
	4jTloEsixoTA0dVkv4hgP/G6JYgOABjL17h3XmyM=
From: Victor <victor@solutions-corp.org>
To: git@vger.kernel.org
Subject: Thought Your IT Background Might Be a Good Fit
Message-ID: <0100019e63b8d54b-2c17b8b4-93c7-47b5-bb79-e896aaf76c64-000000@email.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 09:58:38 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.us-east-1.5Y+5gO6jednSEgg0xsq1dNxSoklWjiayNvr6T/9wHti1CCTTk8FxV6P5PpsXU/S5vV6OyFwkxNF8bf+kHjpZVZZHA7rAwIWl7mbrl3DU1OnhXDB029NyjjwzqkL6u21KyfEBGuL/F1XFeK+nBKSbgcRJQ/gfe5meZU2C83cjECg=:1.us-east-1.epbACCJLarUaEI78XZoGREJ9LamRjxMH5pM2kZb64rA=:AmazonSES
X-SES-Outgoing: 2026.05.26-54.240.10.132

Hi No=C3=B4men Ben Hassin,

I saw your profile on GitHub and liked your =
background in IT. I=E2=80=99m reaching out because I=E2=80=99m working with=
 a flexible remote opportunity that may align with your technical =
experience.

Would you be open to a quick overview? If not, no worries at =
all.

Best,
Victor
