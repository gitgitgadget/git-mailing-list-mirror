Received: from a9-39.smtp-out.amazonses.com (a9-39.smtp-out.amazonses.com [54.240.9.39])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A807B33B6D7
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.9.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767625222; cv=none; b=Ez9wBJrgWZS6X3Kh5pqh8uNtGOCTvBUNaYQIi8A7EkByimffFWTB1rz/E37Il0udQP7xBtCviKYmlwfDbPpTlLEeenAkzpaZmNA44IGaFBwAu13YhZ07xEvV8DdMJvkMr+5lMkTRxf0BQV17Z2kSPdJisOevRET42VUgrQ2e6Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767625222; c=relaxed/simple;
	bh=7C9Hq5hJMCANqVQDWb11x5fPCJM45wucbhB+hZF6zK0=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=DK/WCKvxHaxkT/TO7KudvCIOCIU7qeswTthiOoGXrczMnRtOZ7yRJoCI9PiLDs9XvQI4mjziJ4UPBHAHdQUwZNEfH/769IIl/s9XLfG72bjK7DESSupwgd9M06KqQwVozljjyfQSKOK+RMjSYXz2zyrb9s2Fe8fVnEdQjoi0FGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reader.directory; spf=pass smtp.mailfrom=send.reader.directory; dkim=pass (1024-bit key) header.d=reader.directory header.i=@reader.directory header.b=Zf/O1oEp; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=kibtBaXX; arc=none smtp.client-ip=54.240.9.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reader.directory
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.reader.directory
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=reader.directory header.i=@reader.directory header.b="Zf/O1oEp";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="kibtBaXX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=reader.directory; t=1767625219;
	h=From:To:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=7C9Hq5hJMCANqVQDWb11x5fPCJM45wucbhB+hZF6zK0=;
	b=Zf/O1oEpnKHpDWVN0JcBmFguq/8/G6pmH4rx30eUIKy9ziWTgQO20sjmwpPr4ewG
	XVz0r2YV8zNQNBL3eeqLStQZAsqoQytv9xZ88U5fiar0BVqsf02hlZ0FEk7jJc+iHU9
	9oiD6aAgg1dpYaz/j1vNwMvFVEcIvibbC3aaM7zI=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1767625219;
	h=From:To:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=7C9Hq5hJMCANqVQDWb11x5fPCJM45wucbhB+hZF6zK0=;
	b=kibtBaXXzJ4yxSzNkUXVP3yV6aSQYLtkKv3n6j7qN/uYxtcXnlUNFeq6Q7w9YBlE
	G4fmK5pwa2LaLfT7ZYqd7KdXBI6cTQqo3B5jE7T3B3xWSkQZveYubNG1CW52O1hd0F3
	6HdCwvrDlB0N1cP8pd4h6/7yGlDlx+a3FhpyookU=
From: hello@reader.directory
To: git@vger.kernel.org
Subject: Git Rev News is on Reader Directory
Message-ID: <0100019b8eac5db8-53e5b9de-36fb-4f16-9869-420461b301b2-000000@email.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 5 Jan 2026 15:00:19 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: ::1.us-east-1.bUdgMqWxfG2SVsrQjgiKGviqCgupN9bd/NLnQooLs3w=:AmazonSES
X-SES-Outgoing: 2026.01.05-54.240.9.39

Happy New Year!

My name's Samir, and I've been subscribed to dozens of =
newsletters for a while, including Git Rev News.

This got me thinking...=
why isn't there one go-to place where readers can discover newsletters that=
 genuinely interest them?

That's why I created https://reader.directory. =
It's a place where readers can use AI-powered search to find newsletters =
perfect for them. The site has grown to over 5,000+ readers who use our =
systems daily to find the perfect newsletter.

As a reader of Git Rev News,=
 I decided to add you guys to our growing index of over 300+ newsletters. =
This way, more people can find Git Rev News. Feel free to check yourselves =
out:
https://reader.directory/git-rev-news (let me know if any information =
is inaccurate or you want info updated)

We also have some more trafficked =
sections of our site where we can do sponsored/featured posts if you're =
interested in greater visibility. Feel free to shoot me an email back.

Best,
Samir
