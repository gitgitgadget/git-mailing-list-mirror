Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BE828370
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 13:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721655864; cv=none; b=OaqE4zgBvpXvhCClv8sA/eglN1rw2KPSrS/zlECROavakaKTY2/XeMOYYWGnOQaRf1uhBigadx9JM5YOlV5YqG7MQJYz+1y5Yb3Rwyk6FjxXv7jU7UYJ+T/aUb2+wYnk/ADGWBZfh2JLIkhO1zte+vuXXpU0QXscnOc8LYzTQbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721655864; c=relaxed/simple;
	bh=TVodsO05AuSeuKvNHCGo2qm5UjuyIY68JRyvz2FWVx4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=pWEjUQVBmznjMFDRYDnG/4pxBPQibiiaXOs48B1j3pRzJhag9kuqCvy+HOEyEQz5q1yhqw2gfO+sN9OjHq3L/Y2rbp0g8YADM2M0+E0E6pQzh4kxodBeuZpdnYuvg7ILDS1Vo/UVHN/uv5PkUYZgmOUejO8N3NKfg0FXaFFU9cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=UUOX3UWn; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="UUOX3UWn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1721655859; x=1722260659;
	i=johannes.schindelin@gmx.de;
	bh=k9pozygIbczJcMwpTJIZpgFtrjQZmpAQnz+sKrYm2pg=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=UUOX3UWnP3lstU3jNX2Ox5dOy+a+ySeu2kW+J1h+jKa9KlIvfW5VHOIcJ+cDbhcm
	 Qv7UyHrEF+CSRhj8IEmUGxG/JPpAiYPDOsH18x3rtqc4Ym1mtNcos1kAp5sb5Q3mn
	 6bRQ+3mVSLM5vhmT+BQsB1NyQNjmy/QBMJVd6iYpUGQfxIQuT6dO6rD6KL9CGuiPb
	 g4JXBznwKxA8BDxNdndLji9aSElRI8J/Oq81OyXzUuQV6TeLYja+wwDR6csZVjuEh
	 MIjQnoeQDm+uyubsRgQ4vJlmfb1QeBaXpL1rrp/qjrXTXMA6jVy7lSTrCOFugYf7G
	 3k4pFhARhNPaJwq+wA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.218]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M42jK-1sVtKt2aES-00CmqY for
 <git@vger.kernel.org>; Mon, 22 Jul 2024 15:44:19 +0200
Date: Mon, 22 Jul 2024 15:44:19 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
Subject: Git Merge 2024 (fwd)
Message-ID: <f952a7ae-9dd2-7039-2ff0-9133639cdbbe@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-445410793-1721655859=:109"
X-Provags-ID: V03:K1:oDNjuif6+lu5Hzvaz3LtyLXmO7/P9F3umOngnKmZG+vgqm6w8vN
 vR0TXU7M64C9p0S3b+2HnIdKlfqOBhjkyQFj5K0NHaPBb2l9+s8T80FNjcsA+KCDndLVRX1
 bqD123Zc+MvsH6I1iA4rcQQIwV1wq+YKwP1VLjEKZkQdFNdYHqUUm1I36elBYyrjbgAG18A
 bw6KZ9KEV0MhwAjwulgyQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:e4hKWVjEZvI=;4ZqLSWr4ekY9BkCqHAccNIbQPIl
 c9CZMBaIYSXRO2Oj6fQw5Tb+RwZZn1eKrP8iB/LoIl1+eBB8Qs9ropWZmBb1SAsbybuXWZBnd
 URBCkIOeS9rmE6fEMLyPtn05egXiKho+C02bPGv8Ed7j272TPFaE5QyPs7oDBdkllo8ZAJPbc
 EtEjrohc3LQMJjn2voj4Z5txCGyV4BtK48il+S7QsJ882fTnAxrdRujhMiefVaHAZXjFZEf5C
 nCfCZo0Dq/jidHuCn9GN3TQM8N+TnhMmdsQ8rEIsE2QhtRmK2XxUlxu/9QKcEBpNBXHADG4In
 QEcJMa5FYVCquWFSdfeBtBjz0UqpBK7P4pvBzbhCQznXwqL7TleS27r47UGyC0U2qwmqEO1EN
 YtsW+HICrBIKoaCizwVu9O4NY4XsjRTxzXxlRYNTV5Q7MgqURUNva8eHCRWRk+W5La27+kv8O
 9kfkxwupA3VB7OViMpng88AnSJGTpXnDxaQg9cMnB556iKGieIxiWbYd9zkv4VDhuAR/+ln50
 4yY5M28cth4NMExaSRXpw+Aw/HDIwibIOnSiVOOm/XUMqTSrpOkFbNUxVhLTo31Hpon3rPq2P
 K4lfjBK3D6VjCROK6KRFeAcM1YhDNji2yCVGK+z0YelZFHfOTR7m7vpg96tNTccn7HRDCaiWC
 /zzoM5q2GxJjEDz8f/x8GBjndGKVjdrvJQhphiHAJGUHBoHoTZto6xog39W4zZh/tmIxEslhb
 BNq9Bj8cTaO1Ca3xDWXVLFNDmag0JqPg4MX1AICikNTOuxXjJkxrRxCVMXVi8zELdWcACQLqT
 aDDgVOXQFgjORWk2Iex0eOy6SoT7/0VWYvTlchpiPHkxeNu2l3ohopIzd4wwvTwe2QPYeNmqQ
 BFdN8q4j8rPHE/A==

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-445410793-1721655859=:109
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable

FYI

=2D--------- Forwarded message ----------
From: GitButler
Subject: Git Merge 2024

https://blog.gitbutler.com/r/86390f37?m=3D4154aa4f-d179-45d8-8323-11cc8743=
3d1b

GitButler [https://blog.gitbutler.com/r/482f1a0a?m=3D4154aa4f-d179-45d8-83=
23-11cc87433d1b]
Git Merge 2024 [https://blog.gitbutler.com/r/c70aa7ab?m=3D4154aa4f-d179-45=
d8-8323-11cc87433d1b]
By Scott Chacon =E2=80=A2 22 Jul 2024
View in browser [https://blog.gitbutler.com/r/edc6d401?m=3D4154aa4f-d179-4=
5d8-8323-11cc87433d1b]

A few months ago, Taylor Blau from GitHub announced on the Git mailing
list [https://blog.gitbutler.com/r/ec32c97c?m=3D4154aa4f-d179-45d8-8323-11=
cc87433d1b]
that GitHub was not planning on hosting the Git Merge conference and
contributors summit this year.

I actually helped start this conference at GitHub way back in 2013 as a
successor to the Git Together meeting that piggybacked on the Google
Summer of Code and GitHub has been hosting it ever since.

As an alternative, a virtual contributors summit was suggested, but we
thought it would be a shame for everyone who loves and works on Git to not
be able to sit down and have a beer together, so we decided to partner
with GitHub to help organize an actual, in person summit again this year.

Therefore, it=E2=80=99s our pleasure to announce that the Git Merge 2024
conference will be organized by GitButler with GitHub's support this
September in Berlin!

https://blog.gitbutler.com/r/7c304747?m=3D4154aa4f-d179-45d8-8323-11cc8743=
3d1b

If you love Git, work on Git or build tooling around the Git ecosystem,
please join us in Berlin on September 19th and 20th for Git Merge 2024
[https://blog.gitbutler.com/r/dbc8533f?m=3D4154aa4f-d179-45d8-8323-11cc874=
33d1b].
We promise it will be the most amazing version control nerd gathering of
the year.

If you=E2=80=99re interested in speaking at the event, the CFP for Git/ver=
sion
control related topics will be open until August 1st, throw your hat into
the ring here:

Git Merge 2024 CFP [https://blog.gitbutler.com/r/0171a619?m=3D4154aa4f-d17=
9-45d8-8323-11cc87433d1b]

Hope to see you there!

Comment[https://blog.gitbutler.com/r/14df0ea3?m=3D4154aa4f-d179-45d8-8323-=
11cc87433d1b]

--8323328-445410793-1721655859=:109--
