Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2701BC37
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 20:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710622739; cv=none; b=prQsZugcVuadKseaQX8IwMGM3pk/z8WgUmbg5Gjokt3LlYRZqGi/ou8Cw2vItBBAoDvirymkGduKO98d/6mKo+k9sltDYfmjvxXpjHxfrOdaPAuM2N3dty0473HclDrexQKYUlfjIB3eHNQdsWAek2YLyZY+8846XVRAA2GCN5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710622739; c=relaxed/simple;
	bh=CwNS5w8rI7Wf+HLNPMAXZEwpoLgvM98ttPR4jGOLajA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=gkIEblAuQBcyqis27UDyPgQPK1HOjKJYbv5iUiPr5FSCUVi4UTZyBssAKWDsjPYDUsBzaZccQuWF8B3nqIm5UX74SmGrM+wvg8baCQ4SMfdf/UiB31PKrxQx4ZLGBDbm5PJg9fudOSVhV404QQLQzwDvct6NS+C694C7siKbzrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=qx+n0w4+; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="qx+n0w4+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1710622734; x=1711227534; i=l.s.r@web.de;
	bh=ofqs0u73wshEJoImfwxBbHaRLe4/iusqwQ5p8Oy0lpw=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=qx+n0w4+bVGC/w9KSr25C4cqDjQsTFqTGl3LDQ3Iu/t/aEwV5J2TeQu7mFYfjPn9
	 9PbqnF5k9rNrq8XAZ/N87A84IcFRl0d53Jfnak81IvSkJgohm7sTHQbzfaARcizhb
	 B0qHqh7s36tMLDAXWFBt/sQ7vF7gwyh0oSn9E8SGw6pofFjLy1ANKzFKvxmUli7SG
	 qA1ENbGGNqGxpA7T8v37GgG4yt3m2TLH4E9d8eL+a+X4CUtXQSi65cmvIcX2ew9vr
	 V19D2bdE7lVomyFhOANGjVTjrxdd01I8FTx9DLPX48hhjyIKq56S0F+oP1L769ceP
	 cMuks4LDvu3xMo9aLA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.211]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M8TBS-1rhDCS1WRE-004oZ0; Sat, 16
 Mar 2024 21:45:52 +0100
Message-ID: <197f5ac9-7257-4caa-aa9e-041016c787f7@web.de>
Date: Sat, 16 Mar 2024 21:45:51 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Cc: Chandra Pratap <chandrapratap3519@gmail.com>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/2] t-prio-queue: shorten array index message
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yW/1vgVEyjy6kbArwugLihlVuWQyEJZderk3OTEqoSQhiliLick
 8+9N7IgRBHVopKCOTddLYVXYAcQt23EUT/V9n9owJZYGGalCg8Vqbm4RyCKH2KrdkBNne85
 F6aIndL3+5wvir5TjjGR9+v/jid4gRXk1JhBdkFAy9LFfUum9PiJO1FfiK9s23KiFQDwpTN
 wrKda113GcScDHcTqzIGA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qnl3XiZIxDg=;8zm3TV1HcqBXsh6wPTRDXDNuAtR
 jU48qP2IW80aC4fxJI4nYkfPyk7RFGuKfdRmGf0KT5qkSocH/m0S6JxtBpi8kd/J0YfPUNnOo
 QrLTCfcuvEJjOxGa5RYZhORFkuACjKFc7Nzra759WckOLXeJspVzriXE6ZzHwbNrWnpYs4Oft
 mGPZdOoL7D+2MT+8w77dQOa9NzXRnlKT2ayB3bmxrF353tSi7Lu/huCOlLhs0x6FBk2c6ZYO6
 EovB/qcDrazc0GV34fu1dPCDHDPPU+5tfZJRxbtpJrxWXk75GvDxJLoz0KHNGETlHQHs1DWgb
 rJM2y208IaNWNqp1eAXnZZlbeUe0O+qsrmTt7KiSSK2l41COirTPeAhjxPWdiF/mWRYl7xKbJ
 afzbcGZQUw7L0yNK0h7Vb3P0ugDxWhAdf3MdU03mHpCp6ALE72RuZ6GuIDkYTfbZ3e1qcpSfS
 qRF0Fzy+I1TMr0+dka9NnEp9CBTTuRIWXFnGnPy9ODPlFSI5gU91c1NK+vUcW6oiRlTi9woWQ
 23TohsKEn0B0YmrGKgco9dPxM2KoTjiAkY0mZMgQvV6DGlB95pSLddQNm1/y7VY6ix4YpeNXi
 0lQTLVrxLueZHIj5HcjLFa1IhQybRj5NMMeqzVnf4zFpOEZmILYWSrwaplhvEXx1kms68CNuX
 SlSl0LaBH587BSu0HedQp3wPPk6+XEPQxdIe49gO7xv6DmR5AKMCYBIcWxXLlf5DrLmVKpzaG
 P5p4ZWW3juYIIP4t3ZfofIKOuhddbSbstRhTYg+JH5LESjO/YzvVUdOPdg0mtqxu2Fi1OswZG
 URCYA/SJD2xC0p/vSbflARsVgL7CZnfCaOXSYcfhv6COI=

If we get an unexpected result, the prio-queue unit test reports it like
this:

 # check "result[j++] =3D=3D show(get)" failed at t/unit-tests/t-prio-queu=
e.c:43
 #    left: 5
 #   right: 1
 # failed at result[] index 0

That last line repeats "failed" and "result" from the first line.
Shorten it to resemble a similar one in t-ctype and also remove the
incrementation from the first line to avoid possible distractions from
the message of which comparison went wrong where:

 # check "result[j] =3D=3D show(get)" failed at t/unit-tests/t-prio-queue.=
c:43
 #    left: 5
 #   right: 1
 #       j: 0

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/unit-tests/t-prio-queue.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/unit-tests/t-prio-queue.c b/t/unit-tests/t-prio-queue.c
index d78b002f9e..616d0fc86f 100644
=2D-- a/t/unit-tests/t-prio-queue.c
+++ b/t/unit-tests/t-prio-queue.c
@@ -31,16 +31,18 @@ static void test_prio_queue(int *input, int *result, s=
ize_t input_size)
 			get =3D prio_queue_get(&pq);
 			if (!check(peek =3D=3D get))
 				return;
-			if(!check_int(result[j++], =3D=3D, show(get)))
-				test_msg("failed at result[] index %d", j-1);
+			if (!check_int(result[j], =3D=3D, show(get)))
+				test_msg("      j: %d", j);
+			j++;
 			break;
 		case DUMP:
 			while ((peek =3D prio_queue_peek(&pq))) {
 				get =3D prio_queue_get(&pq);
 				if (!check(peek =3D=3D get))
 					return;
-				if(!check_int(result[j++], =3D=3D, show(get)))
-					test_msg("failed at result[] index %d", j-1);
+				if (!check_int(result[j], =3D=3D, show(get)))
+					test_msg("      j: %d", j);
+				j++;
 			}
 			break;
 		case STACK:
=2D-
2.44.0
