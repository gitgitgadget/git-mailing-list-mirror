Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F09A5F
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 17:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q41RTHo/"
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE7FB0
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 10:17:24 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a7c08b7744so25172277b3.3
        for <git@vger.kernel.org>; Sun, 22 Oct 2023 10:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697995043; x=1698599843; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+i3OF1/5N7RcTGm47KZkpInvBAQEziyZIGXqCPVnSJI=;
        b=Q41RTHo/2oJAza37sVDVZzN+QsxT4NeZXYM3POU2Uivm9d3MPy4GVQgcFp9hz6ah8Y
         CHfJWtXsLVw15hvnI8eTnIfemtcjPCVwVeIzBFKOLN0VQOElaaX0Cfn2aq+qeYLEnt/W
         AKAjJBc3e3/a/Nk2n5XBx1nYzzT79IkWZY1AxxID0MoQYh7V5FOh9SYXMpcNwhO8roWS
         uKWIMXvxo199wKKES8/LMm3tvyOGN90OELdUrzAtvrOnWe1Xt4Q5yeowW6Sk+XjF/S9M
         90XfnRi3pSwygIaswA63wtBtZLrRqUex+KJ8wYxng5K4v2n5sOcGMrz3HN5oRkjGnq4j
         gQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697995043; x=1698599843;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+i3OF1/5N7RcTGm47KZkpInvBAQEziyZIGXqCPVnSJI=;
        b=C6sMmO8wAw436c+OYx8ZO0QFOrrMm8jwnrjd9jrPUnhf8tL0PPVZEGj2OJQLbgpQuN
         AaHxUuyePWUjMIiiAx1Xhi3Af9o/CfN7Mdg6IiDGfp2SdUAvIzSfxJB/FbOOf/dBEm9C
         8lsgyY95Af+vQierTDga9X25/KGhac6weBhrH9Neu8DW6jpOkueAvXiwoTmP7FK3RC31
         ED3V6M5r4NQtqVonMm0h664pBLX5T1F60NptKCajo+C/gnJKtfOqW2l3TP2HHFNoDmYo
         2D9iYpl8VRMjAKRbe6l/TY76wVpK48V9jIV5bxkkGxI26wz3dzOUy4YTKzrjLqZrtJzM
         nFLg==
X-Gm-Message-State: AOJu0YweA0fWHnP7IgNZIwVYT5V3y57ojYoHVAyRZqx5Y/WfDxEGTTmc
	xRwPqfXHsHwROZRBoG2iBaqp//ICq5JQuw5OBaUbE2jbJkus
X-Google-Smtp-Source: AGHT+IFhqLus5TNXOgHpiUWSnqDv8nVrGNEjHADseo9IDSFUjANxbMXes09Ga4GrciabTDE5gT1OKgkQnWRa3dL9A0Q=
X-Received: by 2002:a25:25c7:0:b0:d9a:ef4e:547b with SMTP id
 l190-20020a2525c7000000b00d9aef4e547bmr6232304ybl.41.1697995043093; Sun, 22
 Oct 2023 10:17:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naomi Ibe <naomi.ibeh69@gmail.com>
Date: Sun, 22 Oct 2023 18:16:54 +0100
Message-ID: <CACS=G2zPH4+R6L8bQ8w=b8u1i6Zsj6xwMibghPKzPX7oGko_tw@mail.gmail.com>
Subject: Outreachy Internship Project Timeline
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On the Outreachy website under the "Final application section", this
statement appears:
"Please work with your mentor to provide a timeline of the work you
plan to accomplish on the project and what tasks you will finish at
each step. Make sure take into account any time commitments you have
during the Outreachy internship round. If you are still working on
your contributions and need more time, you can leave this blank and
edit your application later."
Is there a link to where I can access the project timeline and
subsequently edit it?
