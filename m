Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC641DA2F
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278749E
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 10:01:55 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-66d2f3bb312so6440066d6.0
        for <git@vger.kernel.org>; Fri, 20 Oct 2023 10:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697821314; x=1698426114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mS9S5I0Tzvnj+aQ8XyefcTePsmwJZ6y4MPpYMhjQEWk=;
        b=JJS75Nfw9PEwSzC1VMDediv6SSeQlvpU7Z0GJJ9UCbEy5yTKZK4Cw0gCEO1xNHPLbe
         Pc/fJ841HHyvSprP4+Vn6pGKok4wdRi+FdKljRubNRwdZBMzRw6eSNWPfcF9O4ZN8HGL
         p2r5Ts+7rr7UGX76OMkY+Wtr4VvMhFNRplWsDIAd3gzeC9InhYPV7jYilsuq22LFf3nI
         td3xKlYhPECTXGlhK6VESTpPNM3te7GxLHHTnANYYJNJaZ1qac1do017vITQG3Ja9tfN
         p61jvKCzftswu0bBdjoQ6Se3GDBJnql7oZFAJWobAWGQOH5H9W/oHdevRB5ciLp3v+GW
         lrUQ==
X-Gm-Message-State: AOJu0YwKDOkMI+QFBXyl+fts7pt/eFudPlyqupkuNZ5T6Ht2bBYHJYtA
	NEEfdaHtQ2+YgKhcrFS1wljZSFxaSvx5iZn+8xZnGtCSJxs=
X-Google-Smtp-Source: AGHT+IGRVli4Ohvt/IAQA5PDUBatvCKCENJywaWDfje8JgyhUxphMOm23lL0tgwxUP+65oGgxBt1/4bom0EZVqXchCY=
X-Received: by 2002:ad4:5bc8:0:b0:66d:61c1:a354 with SMTP id
 t8-20020ad45bc8000000b0066d61c1a354mr2128016qvt.16.1697821314168; Fri, 20 Oct
 2023 10:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGUSxisVxXDLyFQ-KQHQdtTqF5UihhnJ22rtTn-r9J94ToeuXg@mail.gmail.com>
In-Reply-To: <CAGUSxisVxXDLyFQ-KQHQdtTqF5UihhnJ22rtTn-r9J94ToeuXg@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 20 Oct 2023 13:01:42 -0400
Message-ID: <CAPig+cRZV5R2V26USg4XZ_bpCmSLWG7kk4rRC5EVXxLBaej9bA@mail.gmail.com>
Subject: Re: Thanks and One Suggestion
To: Brock Whitaker <brock.e.whitaker@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 10:20=E2=80=AFAM Brock Whitaker
<brock.e.whitaker@gmail.com> wrote:
> Thank you for the git-scm site. It's an invaluable resource I use often.
>
> My only issue with it is the text isn't as easy to read as I would
> like. The orange text on a white background is a little tough to read
> sometimes. A higher contrast between text and background color would
> help.

Indeed, a color contrast analyzer, such as [1], indicates that the
specific orange/white combination used by git-scm.com is less than
unsuitable (at least for normal size text).

The git-scm.com site is maintained by a project separate from the Git
project itself. You can report the poor color contrast at their issue
tracker[2].

[1]: https://color.adobe.com/create/color-contrast-analyzer
[2]: https://github.com/git/git-scm.com/issues
