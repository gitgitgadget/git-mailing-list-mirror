Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DD27EB
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 03:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZD0uv1a9"
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C164496
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 19:03:17 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32faea0fa1fso948690f8f.1
        for <git@vger.kernel.org>; Thu, 09 Nov 2023 19:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699585396; x=1700190196; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xwXPHdwpToxobdg0GKhJPXkqXSo+1FnFHSIIPri/ku4=;
        b=ZD0uv1a9qMwUG0lIsi82NmPq/8wpAZDcKxT8b/1Yyi6HzKuFlAjQBwo9QVIjG6fY4x
         /1lyz0Ld2w/o6EB6ZmWhZ3GunDj7tYkXsoTYzLWdngmNll7DrqvFj8Urc63pnfRgadrw
         dnpEvBMSjabtwCUOBxGRKpoNZAw1I7UN7PKvWsirjU51V9635sM/uaQ229YIvWgIZPST
         m+S9/vov2qM9eU6tn2yC7tO/ofxWscS77B419PE82wkgmoeUe2+tYMVFaiqnFbds+l92
         W3OV/vO2dCrjGpd+x6EvHpIMNuGQRixD6+jcninfoTRUXcwip3APjH9W9eE+J8YDgO1l
         a7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699585396; x=1700190196;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xwXPHdwpToxobdg0GKhJPXkqXSo+1FnFHSIIPri/ku4=;
        b=XgUdibGxgN38fq5lUejpTkTElqs1KmrZe3gK59BrGBcC/APT8R7dDC0h1XegVAQ3yB
         rtKoukh/w/6/CMrnjD3IgXauHRrpesaBDFfvwVlz/sAwua1gU1bOQ8VnVLEdqsWnqASN
         dDQPcHjXgxg7QDr0hEYefbNAlleWLqr0dioG28vvn1mB6YGW63sbmSm8oseWhKD2Y2ud
         BJB5xfIqGtuXG/54v/++wEte3OOwxdFmKY/luodrGlE4cWRUStlUSW8izqthJnLDU5nP
         pASzCUGrzYLqiNqpBL0LlicRElsXQ6ymmdGMhVr0pWsvuADqku1hXX28NOlZl5/jDrk8
         e4ng==
X-Gm-Message-State: AOJu0Yy+mKhW5d6XvM6XkjZBGT2Av8MwMxaaSbgGW/9/SBfWNxK6+qia
	o74WkvNfXs2VbRP/zI36XwUdEcpxTBFd/actD7jJQFo/d3w=
X-Google-Smtp-Source: AGHT+IEj4Ux7ZLSN/iEUkxhdfvc3xKX/4mTS1CBI/cWndbYnmT0fH1s3W+dkNSp43+NJyvUxKO7i23ws4RIQbmvyYEs=
X-Received: by 2002:a5d:64cb:0:b0:32f:7260:1220 with SMTP id
 f11-20020a5d64cb000000b0032f72601220mr1164241wri.17.1699585395720; Thu, 09
 Nov 2023 19:03:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Malik Rumi <malik.a.rumi@gmail.com>
Date: Thu, 9 Nov 2023 21:02:39 -0600
Message-ID: <CAKd6oBxF8m09QnqZ46joVpcR3mrR4MRSO+kL8vELGwVhD=rgXg@mail.gmail.com>
Subject: recover lost file
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am looking for a lost file that was accidentally deleted about 18
months ago. The docs I consulted are version 2.42.1. The git on my
machine is version 2.34.1

I followed the instructions on this page=E2=80=9D
https://git-scm.com/book/en/v2/Git-Tools-Searching , the section =E2=80=9CL=
ine
Log Search=E2=80=9D. But I got an error.

malikarumi@Tetuoan2:~/Projects/hattie$ git grep titlesplit
malikarumi@Tetuoan2:~/Projects/hattie$ git grep filesplit
malikarumi@Tetuoan2:~/Projects/hattie$ git log -L :titlesplit
fatal: -L argument not 'start,end:file' or ':funcname:file': :titlesplit
malikarumi@Tetuoan2:~/Projects/hattie$ git log -L :titlesplit:
fatal: -L argument not 'start,end:file' or ':funcname:file': :titlesplit:

I don=E2=80=99t know the purpose of the colon. Is it a boundary marker? Doe=
s
it belong at the front of the search object, the end, or both?
'start,end:file' sounds like the error message expects me to provide a
start and an end, to which the obvious reply is - If I knew where it
was, I wouldn=E2=80=99t be trying to find it.

What is the correct syntax?

Is there another search option?

Thanx




---
=E2=80=9CNone of you has faith until he loves for his brother or his neighb=
or
what he loves for himself.=E2=80=9D
