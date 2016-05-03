From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] remote.c: specify correct plural form in "commit diverge" message
Date: Mon, 2 May 2016 17:16:13 -0700
Message-ID: <CAGZ79kayCBNn8e5TzD+zhPEopOVTvsTUfy=_9UGP43vktsdFLQ@mail.gmail.com>
References: <2A734D896A45164C887E476E942BF4F9B5F721@CINMBCNA09.e2k.ad.ge.com>
	<1462234350-30902-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	ernesto.alfonsogonzalez@ge.com
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 03 02:16:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axO0j-0007X1-Cy
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 02:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbcECAQR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2016 20:16:17 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36499 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932448AbcECAQO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2016 20:16:14 -0400
Received: by mail-ig0-f174.google.com with SMTP id u10so100983609igr.1
        for <git@vger.kernel.org>; Mon, 02 May 2016 17:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=ofI6tHVklqmfjoupZtWn9tEpUHPWyp4annLoXCxshtM=;
        b=AfY+0nFFE8aHOLB41EXZiw6Eg4be2OEgJtDwfvnIzD5RCPAbdMphheyEgBOQ0dQxi+
         uvU8n2rjXrf6zKm39QHkFRwaTB3XLWqJ+CrYYmtVWOvqOfqyVffx2gXPJb+cz6d+ku54
         FZZUEM8uVNglsVTPzBy6mTj9zs8pQbT7Zne2McxJSXUH9vXwezhf7up2q5Za6XT/Rxgw
         4DKSV+FYeSbfeSgrbOXtaVNyB/niR4fKHRiqajOXotF+4cc6cjeJJho9ZB11QxMJIINT
         eSuZUSTbWyixF5e5pzY6WkIY/F9J16JXq98hrHM29G2NHAModh0itIARiPjrIESnv4u6
         kZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=ofI6tHVklqmfjoupZtWn9tEpUHPWyp4annLoXCxshtM=;
        b=GTe7bDJQXO85RHq/mHl1qOiNmrH0vgTFmfLbETxtD0BkOQnfg+ee+EY4lZEir2Ewdb
         2oW9ttgNMPF/7mz5rMKSaQYdZe7QPiczJ39Nm5A+PsiC4TXk/gv8OXmmiOOAY2oPcD6z
         hYDUjzOjjvc1Mkhd0iLeY0u72HPz2FoALlre/P6p2mSemf3UH2C0Z4a0RZRRuIFgJswq
         G/9qSXnTFOewdTtKkYe8NMGdgHYue59XhRu11RFCd33mV+GGXfbEO/lmyuRSGveNIPMp
         ZbSpJeEMa/3f/2NYWzSMVFb8Aba2h7au8RRKYzNGU67n5KcJHJ2Udbo4k0Y23AXscuSC
         8G6g==
X-Gm-Message-State: AOPr4FXq7oatmqCSUdTXMbm+5euzX6eE+ur6SeQH4A/xg4QH5CXeMxBf5fU976tVd3FSYvJR495SXR+QHUcEJOue
X-Received: by 10.50.111.15 with SMTP id ie15mr24368164igb.94.1462234573546;
 Mon, 02 May 2016 17:16:13 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 2 May 2016 17:16:13 -0700 (PDT)
In-Reply-To: <1462234350-30902-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293310>

On Mon, May 2, 2016 at 5:12 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> We need to count both "ours" and "theirs" commits when selecting plur=
al
> form for this message. Note that even though in this block, both ours
> and theirs must be positive (i.e. can't be in singular form), we stil=
l
> keep Q_(singular, plural) because languages other than English may ha=
ve
> more than one plural form.
>
> Reported-by: Alfonsogonzalez, Ernesto (GE Digital) <ernesto.alfonsogo=
nzalez@ge.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  remote.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/remote.c b/remote.c
> index 28fd676..212426e 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2108,7 +2108,7 @@ int format_tracking_info(struct branch *branch,=
 struct strbuf *sb)
>                            "Your branch and '%s' have diverged,\n"
>                                "and have %d and %d different commits =
each, "
>                                "respectively.\n",
> -                          theirs),
> +                          ours + theirs),

I think it needs to be max(ours, theirs)

    "Your branch and '%s' have diverged,\n"
    "and have 1 and 1 different commit each, "

so singular for that too, no?


>                         base, ours, theirs);
>                 if (advice_status_hints)
>                         strbuf_addf(sb,
> --
> 2.8.0.rc0.210.gd302cd2
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
