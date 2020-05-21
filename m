Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A265FC433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 09:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77988207D3
	for <git@archiver.kernel.org>; Thu, 21 May 2020 09:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="GM+Qv2Pc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbgEUJwM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 05:52:12 -0400
Received: from mout.web.de ([212.227.15.3]:57337 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728834AbgEUJwM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 05:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590054725;
        bh=1tc0yJJDA/sJje+rQPUpUy0LH5uEqYfEi2wU+MUERio=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=GM+Qv2PchX1jzJS7tQ5p5QTvTA7O+F6uKh5KeP1eFw7XY6snlI1H9j+kJ1A7N0MXB
         tc9jtIKtkFQzDr+S8xoLJ2R/XYu7jNFfqe4zu17nvxocHU1HEYJrG+cyTCT0IpYB1I
         M4sV31gnrR45sFE9uRJySH+1JLBf7kxlh05cKD+4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.188]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LshCr-1iwHIz3mwr-012FzR; Thu, 21
 May 2020 11:52:04 +0200
Subject: [PATCH 1/4] fsck: fix a typo in a comment
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bwilliamseng@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <CALN-EhTpiLERuB16-WPZaLub6GdaRHJW8xDeaOEqSFtKe0kCYw@mail.gmail.com>
 <d963242a-72f3-7f42-7c95-ea5148f74804@web.de>
 <xmqqpnbduiec.fsf@gitster.c.googlers.com>
 <938f0818-7e57-b883-009f-01db88ef8f65@web.de>
 <xmqqh7wovoop.fsf@gitster.c.googlers.com>
 <aab9512b-a70a-0f5b-5cdc-5d40acd343d0@web.de>
 <2937d635-52a9-5e69-b3d2-fbde415b7315@web.de>
 <xmqq4ksmsaks.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <0e34ddca-1e29-17ed-278c-4f94ed6436b3@web.de>
Date:   Thu, 21 May 2020 11:52:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <xmqq4ksmsaks.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+qTIBWH6ATr7iJT4XZzheyavA7Ad/qhZ9I5abebsHeA32HT9M1B
 in6LV7vlE4rywtDcLoPa5wD9+BmfvmZonUzsq0F8xZA0nRST85+lrl8F4VFxk/JyOzgU0xj
 E/7K4U0D0j24Oenn4dv0aeyv57GplRTIOZMznzCYAdtDxFf81DrBrTsnb/R4VyKbdBmdhSP
 fjwREqWn6s/BH5IfTlU5w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Erf7JlbvmrU=:lv2RcBGjFjgQ8MKqiMrY1j
 urTS+HNMB6/yXb/RMZcqJw94BXX7ayiPL07YrwwQzMAugu8nnwEHp1gS+ndn1qSRjHuR6zzZk
 6f0Uk/FVDIDSxZhDEr05oTznerjZWiAUkvtpgH1HW/9PRS7sEDIgJCKxVI22xrJbu/vX5Io7C
 zxgWJlJyyX8s1c9HmL22tB5q7gWDE4orhr4OHoSFG0WtDQszt5YvMWR9xAMFkw1dJGxnNuH1W
 RgmDNMV4vJXljDvZxEcw/Tix8KmWH/0z9z4b27NBRWrOAJTDsrE93v1FNmuzYg4RvMaEHun3k
 tVsprieutvACRJUD4ukG5tfIstZFwV7w/08VbiBa+hM7N4TZdDldBVExqKkpxPX8ZMRWYWzY9
 Ou/Nm6/qL8qAxQHzkGBQxJ2KfgPUmWXNsP5EmZnAv/f6mZXa1qvquqXjsG+bgAFvV4m9d9NdJ
 NqwB+/AEksIB9PpM4YRj5ufgZJ5LdBGpTu303enmgm8q8tYhBFdQkjUGIlBj7xIvx2NHs2tLY
 0sQirssbR/3FgwQBp+LE00MxN8cOrVNbdojvST9TB6Ku5hZG19ni80K+k2x5uQBNLyRlgW3bO
 yXwyyLUHsfPRZStu/ivn+9DOl1gdU/yZLW5pPks4J1JzXHuUlEapgYPZPhPQaO+ypr89GSRZ/
 hwyh2PXmyI/7VqY3Ten/5lb+T1bql5Vm8wAnoFv/5XMGNs+rxgLJkJmzwbU/6o35NNACmQQwT
 dBm2IFX6fTtxcEQ7bJRkDtBXUuzrOPZDMYJJ/zyyGw2+ebY8ouxatfYiMytdKQAMqyKxlgV+w
 BkTRZ9AYiiYHMm/jEpcE3KiSoWnPOeUVMQCmh32Jagu6MwLkgeat6DWM334B8w1z/g/59lDhW
 vcJHOQfyc+QFzKtMhEmRQ07ZHJyyOKG41YDzlwsqeREEUNf1oM5WMj4ahnLq7d0u9fcj4WByX
 yj6f8bGl0yMW83uztK3kXq556H6E87QBJ/xmIynCL7ZIlw3gSUUZZoOCg3WAsQnju6BirIn6J
 bR9rTrJl+IFlv5xXvx0YnE2Oh3WlEKJJMfwQFITimubjVm3CcA3BJ8rWZy0BR7dM+iTdoSVPY
 gUckU9ShHWvWTuzhkJ9JadhZPcoH4cWD+mLIUUQI5kN++6eFuQ8CvEsWZdK8YtxNRK6hBesiy
 GMECudOqIIn1lQmkooDOAnOGcwO1Qpy6hP7LQCe6kEOmQjf5TAHR3YIOsK3KmuDc8enRylocG
 v0taEra5MYv56Wbo+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reported-by: Junio C Hamano <gitster@pobox.com>
=2D--
 fsck.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck.c b/fsck.c
index 8bb3ecf282..b48426262c 100644
=2D-- a/fsck.c
+++ b/fsck.c
@@ -598,7 +598,7 @@ static int verify_ordered(unsigned mode1, const char *=
name1,

 	/*
 	 * There can be non-consecutive duplicates due to the implicitly
-	 * add slash, e.g.:
+	 * added slash, e.g.:
 	 *
 	 *   foo
 	 *   foo.bar
=2D-
2.26.2
