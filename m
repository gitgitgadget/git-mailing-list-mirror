Received: from sc-ord-mta120.mtasv.net (sc-ord-mta120.mtasv.net [50.31.156.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D644F3054D4
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 20:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.31.156.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755896270; cv=none; b=K1R1yms2JoSItkV/Y62q0GoIbYZAFwKyrzGg2UAmR6Wrevd8LkkLte6nFPtJ/qsIvBGaqI62xzHRUGQDYVs3k3gbJrw3yHU3/RDlKLoMjInmx2rhlvefbKZOk24lZaSe3CdD5gDOPyGlJ8uySZHLrfzDuPL+HuecWeUL1lyh8Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755896270; c=relaxed/simple;
	bh=wNQ3YyRIYBmdyIqANXRI5h6ls9gjQODl2Yk+8ZPjjVI=;
	h=From:Date:Subject:Message-Id:To:MIME-Version:Content-Type; b=lVrPwI4890cpBIRT3q3piiQz3eAQLOfo7DsLVfd0VdQHxcrCEtOnsW/ne3uWJpu7YUGgS6iVGu4mcB/PPg3Qww8CfyNg22+It30wP3vs+ENWqSclfixsRy2qaURdrKFgS4RYdukFJ4yEDU8HEZIjH0difCIeEf09e6ny6x2FjeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tablerockacademy.com; spf=pass smtp.mailfrom=pm.mtasv.net; dkim=pass (2048-bit key) header.d=pm.mtasv.net header.i=@pm.mtasv.net header.b=A3644u7i; arc=none smtp.client-ip=50.31.156.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tablerockacademy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.mtasv.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.mtasv.net header.i=@pm.mtasv.net header.b="A3644u7i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=pm20250324; d=pm.mtasv.net;
 h=From:Date:Subject:Message-Id:Reply-To:To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Date:From:Message-ID:Reply-To:Sender:Subject:To:CC;
 t=1755896268; x=1755982668;
 bh=wNQ3YyRIYBmdyIqANXRI5h6ls9gjQODl2Yk+8ZPjjVI=;
 b=A3644u7iU/UvkQNLvIzuioynV6ikiTzHJvdTCrsFbJ3+WBPZMMDuNMnaEyB+hQ/B6yc/VpRACmwJ
   yqG6HtsIIYPptZ6VRND8ZRguCRs2gdIEF5VQYXqAKPqcCSiKBf044XYwFkiB0umFA34qfPOmrWIo
   TzJa7xfo8JEz9fu8SC+OIvcPi/n6uei1Tznixk8WtWTAy7BZ0eusKO36Q/Co2WNJ144jSS56lnQ4
   oIiWCtjlnCTqayynLYyQObYB4m2vHA/VEmcIhGkKB/8jDGncKWp21C6gDSwc/OBOdZ0UQKefw40h
   qh2stbHA5jBWTtPDHif2LSB0tBaQzkR34A3OJA==
Received: by sc-ord-mta120.mtasv.net id hl3cso3b84kv for <git@vger.kernel.org>; Fri, 22 Aug 2025 16:47:42 -0400 (envelope-from <pm_bounces@pm.mtasv.net>)
X-PM-IP: 50.31.156.120
X-IADB-IP: 50.31.156.120
X-IADB-IP-REVERSE: 120.156.31.50
From: rich@tablerockacademy.com
Date: Fri, 22 Aug 2025 20:47:42 +0000
Subject: =?utf-8?b?8J+SrA==?= git - quick collaboration question
Message-Id: <042551ad-c7ae-4aaf-9de9-b5721eaeb867@mtasv.net>
Reply-To: rich@tablerockacademy.com
To: git@vger.kernel.org
Feedback-ID: s16634298-_:s16634298:a443464:postmark
X-Complaints-To: abuse@postmarkapp.com
X-PM-Message-Id: 042551ad-c7ae-4aaf-9de9-b5721eaeb867
X-PM-RCPT: |bTB8NDQzNDY0fDE2NjM0Mjk4fGdpdEB2Z2VyLmtlcm5lbC5vcmc=|
X-PM-Message-Options: v1;1.wKjH-yw4kSLi9X1SNzf33g.kg3yl4YbVbcfw4eqP72sWFuYarG34gGnf7De1IMJ32EQjgRuLGj3XCYtc-pAzVAOAGRhpheiEtLRQJZjEnmd6quGOdRkcYTVQ19yWSrgyDD4mIUA3TmaT2_ev4u67uTuiL3qbWJnDRarMX4XZ1yAMU8mR-cELZmwZEcYSX4aroZ7QtNWv0rCtFzsxKG28RmE
X-PM-MTA-Pool: transactional-1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I noticed Git helps developers manage version control for projects of all s=
izes. Your work on providing a free and open-source solution caught my atte=
ntion.

Quick question: Do any of your users ever mention challenges with collabora=
tion or tracking changes, especially in large, distributed teams?

We've built a chatbot solution specifically for software platforms to offer=
 their users, and here's why I'm reaching out to you:

- You make the introduction, we handle everything else
- No technical work on your end=E2=80=94we do all demos, setup, and support
- You earn recurring commissions for each user
- Can be white-labeled as YOUR solution

I actually created a working demo with your site to show what this looks li=
ke in action: https://www.tablerockindustries.com/trichat/live/git-scmcom

The math is simple=E2=80=94if the chatbot helps even one team collaborate m=
ore efficiently per month, it pays for itself. Everything after that is inc=
reased productivity for your users (and commissions for you).

Worth a quick 12-minute call Monday or Tuesday to explore if this could enh=
ance Git's offerings?

If it's not relevant, just let me know=E2=80=94I'll mark it down and won't =
follow up.

Best,
Richard Williams
813.834.0715

P.S. We're only partnering with one version control platform. Happy to disc=
uss exclusive integration if you're interested.
