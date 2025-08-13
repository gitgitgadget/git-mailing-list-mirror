Received: from mail.aegee.org (mail.aegee.org [144.76.142.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14ED2DCF55
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 07:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.142.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755070131; cv=none; b=Q+rg+3LiGkwd/oEiAFLB5Xz6Pld6XjS5Q7sIEPxEDLtU+ZSUeJUhwmuwJs0rLyZEg31KT0EQoaqXhK68pvFoQ1XM5rRTbX5cLnoNTnu9y8L4111DVeYTKQFg2yMvyReliwE28/VudXsRVLSJIFvRhbcQlCh1GBPBlPoaCjfWeuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755070131; c=relaxed/simple;
	bh=NYwzdt3rJUNfyQMBA+yatgd7knB4sMyY+HaUpEom+0k=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=HWQwscTTf7yrN/aEqX5U/YTQeY7E7jEay4MTvkyK5wB90ry1U+yO2XnERUWVqLDrRoT52QN7Xky6iv5UFKLbCsYaoMKEfdaScoOgm+i0Kd6ejwXYDQnlVHiOv10DF89aDTcRuxiEtsDq/tfYHCWXbr9drbZVCwqobnnYmTIuyIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aegee.org; spf=pass smtp.mailfrom=aegee.org; dkim=pass (4096-bit key) header.d=aegee.org header.i=dkim+MSA-tls@aegee.org header.b=Nh9sKQWQ; arc=none smtp.client-ip=144.76.142.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aegee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aegee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=aegee.org header.i=dkim+MSA-tls@aegee.org header.b="Nh9sKQWQ"
Authentication-Results: mail.aegee.org/57D7KEov2513876; auth=pass (PLAIN) smtp.auth=didopalauzov@aegee.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aegee.org; s=k4096;
	t=1755069615; i=dkim+MSA-tls@aegee.org;
	bh=NYwzdt3rJUNfyQMBA+yatgd7knB4sMyY+HaUpEom+0k=;
	h=Subject:From:To:Date;
	b=Nh9sKQWQSS6tJ+CFeb3gM0JovTlqo9n+iejGHkfbC24TVedLsA2wrx3vBylabGEXs
	 ihm7WJVSB9RiyuiDEOmWqP/jDwpnhLlvQ0u72sa0DCWttNIs9wGlR4MzM96f+BnwYJ
	 LZ8zfqBrwevKF2zxf/3dI81K6iR0O9SPOwC0qAo1Gbszu7xbdKirDrWXMbfJdUXpK8
	 3ZNyPKO8dIjjvY86yvD3ZdPDmYZDdaamGxACIoq4Rm0VWZ4QXKkkL+mi/VMNyqOicw
	 sfvI68Qjd2qNFVO8yFUiI6pckQU83uRVZ8v2fhIrLYtyoFEhydMQwUFvSyPxgDowZJ
	 EmnJQK0TMy0btewxOnK3/cVTbQQVVNBFpWdCgtGcMQ0+HbCJ1qyslsNv7tax1N6BNh
	 VxJ90n0paskc1WGDG2gW+XtdKJB6q/s8NmiOP5JZ+MD5LKWSov6XV86pEtiN1wDnVr
	 vwqapJeBRfQhfA4djSwPy/DunrKJdSER+pRXVWCaAYMym2ml73DVSvaY8FyRuViqEq
	 P00Vz47KQ/oCWncK32KVwnqwE/zKhdTvz8fB+TWcfySKtkXUAAVDtvCngK9LlxktWQ
	 HzcQvWOm0VL3U5Bz99cPPC8no5QaCc5TA4xjredvRaf/1QT2zWUxpNai4Qom8w0thf
	 Nl6Cne95seCBMFi8653xKJCs=
Authentication-Results: mail.aegee.org/57D7KEov2513876; dkim=none
Received: from [192.168.0.242] (95-43-114-153.ip.btc-net.bg [95.43.114.153])
	(authenticated bits=0)
	by mail.aegee.org (8.18.1/8.18.1) with ESMTPSA id 57D7KEov2513876
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 07:20:15 GMT
Message-ID: <1b0d634286da16f32cd9faf541ee28c811d6c83f.camel@aegee.org>
Subject: git diff shows twice =?UTF-8?Q?=E2=80=9C\?= No newline at end of
 =?UTF-8?Q?file=E2=80=9D?= - no need for repetition
From: =?UTF-8?Q?=D0=94=D0=B8=D0=BB=D1=8F=D0=BD_?=
 =?UTF-8?Q?=D0=9F=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2?=
	 <dilyan.palauzov@aegee.org>
To: git@vger.kernel.org
Date: Wed, 13 Aug 2025 10:20:13 +0300
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.57.3 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,

when a file, which does not end in a new line, is modified, git diff shows =
twice the text =E2=80=9C\ No newline at end of file=E2=80=9D. As this piece=
 of the file is not modified, I think git diff should print it once.  In th=
e example below the first =E2=80=9C\ No newline at end of file=E2=80=9D sho=
uld be skipped.

I am using git 2.50.0.

As a matter of fact github also shows this information twice - https://gith=
ub.com/alex-shpak/hugo-book/pull/755/files - which I find is bad.

Greetings
  =D0=94=D0=B8=D0=BB=D1=8F=D0=BD

$ git diff=20
diff --git a/layouts/_partials/docs/toc-show.html b/layouts/_partials/docs/=
toc-show.html
index 21122a1..c243ae5 100644
--- a/layouts/_partials/docs/toc-show.html
+++ b/layouts/_partials/docs/toc-show.html
@@ -2,4 +2,4 @@
   and
     (default .Site.Params.BookToC .Params.BookToC)
     (not (eq .TableOfContents "<nav id=3D\"TableOfContents\"></nav>"))
-) }}
\ No newline at end of file
+}}
\ No newline at end of file
