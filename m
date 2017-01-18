Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91ED21F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 18:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753414AbdARSvv (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 13:51:51 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:36270 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753332AbdARSvD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 13:51:03 -0500
Received: by mail-it0-f47.google.com with SMTP id c7so124184797itd.1
        for <git@vger.kernel.org>; Wed, 18 Jan 2017 10:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HaFh9+WlS88GH6lYp6tmkM/DGRCg0xTGm7IpYEMLdZ8=;
        b=XJSW9UO4dBvI47Ir39hOZ2Sgmz0xC2LNOWQ3fyk3Yv3ADxMO6//T/+xj+7svSoMFh1
         7qpk105UJBj3bJy4hoXgzOUNfBupfOxfZTJ1Lxddx/L3sMiVGMP+uM2+X3wK35/Gxu4g
         AOMWfyfBaWcSG6Q4f4gfshV8+qJe9AKI/NuzJyCGEPIrLv5SxbQU0pHoUBTdnwn0eTlc
         3+mBEpXfNEyvrezSMFrehAitG7qkPznYwQVTBM8FZsQZVLKM9DghOLFreniOMhgzfXLM
         hV5gp7S3ZnL5Cb9M/URQxv68CUCJEEvmF2bwsmwAiDfADh4JHACkQH7Vn/uC5HXpE+RG
         TB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HaFh9+WlS88GH6lYp6tmkM/DGRCg0xTGm7IpYEMLdZ8=;
        b=saVofypC8uKOV/EAudkZijqU3fxHgnB63LzuKlFKqhIpaunDRJ4xo1b3zrPwd3zIEa
         6ydnV8FVjuG3tCfyN6A5amBnMcv4uL3+TBoZRi62kFhhu+hF95XSGA3aLb9e8dotipEn
         fFjXFdhcSwiBvLphXFbXMEPU8HO8MIfyjBkIiY8LBpPu9N7RAso3tdg+eROlxKwJQXhk
         kPlSU+p6iMo3iNlEAE5TImII2AB/25M9ulIRZZQC7wLqrJVgkiKqGwNx5lPpXAfr7tI5
         2eFv6eYVovlFcFA3e89MPbnSP3LgKH5P3rzQ2GcbHCWS78AmE6ruzpJWeG+NbczyvlYd
         IXqQ==
X-Gm-Message-State: AIkVDXL2MA0NaYAbV+TFxz9+Z73DLx+U3IOl/1MPbMHDaxCiSJOTOAFvmbkWocmyIrmN6la5hIfDskoxdYUEyfWi
X-Received: by 10.36.208.134 with SMTP id m128mr4507420itg.44.1484765440784;
 Wed, 18 Jan 2017 10:50:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.38.131 with HTTP; Wed, 18 Jan 2017 10:50:40 -0800 (PST)
In-Reply-To: <4817eb00-6efc-e3c0-53d7-46f2509350d3@synopsys.com>
References: <4817eb00-6efc-e3c0-53d7-46f2509350d3@synopsys.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 18 Jan 2017 10:50:40 -0800
Message-ID: <CAGZ79kYXQcUB+rVkboY9fMqu6R3RoHEJ7BTJn_+-RScFDjEduA@mail.gmail.com>
Subject: Re: Git: new feature suggestion
To:     Joao Pinto <Joao.Pinto@synopsys.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "CARLOS.PALMINHA@synopsys.com" <CARLOS.PALMINHA@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2017 at 2:40 AM, Joao Pinto <Joao.Pinto@synopsys.com> wrote=
:
> Hello,
>
> My name is Joao Pinto, I work at Synopsys and I am a frequent Linux Kerne=
l
> contributor.
>
> Let me start by congratulate you for the fantastic work you have been doi=
ng with
> Git which is an excellent tool.
>
> The Linux Kernel as all systems needs to be improved and re-organized to =
be
> better prepared for future development and sometimes we need to change
> folder/files names or even move things around.
> I have seen a lot of Linux developers avoid this re-organization operatio=
ns
> because they would lose the renamed file history, because a new log is cr=
eated
> for the new file, even if it is a renamed version of itself.

Well there are a couple of things to help with digging in the logs.

git log:
       --follow
           Continue listing the history of a file beyond renames (works onl=
y
           for a single file).

        -M[<n>], --find-renames[=3D<n>]
           If generating diffs, detect and report renames for each commit. =
For
           following files across renames while traversing history, see
           --follow. If n is specified, it is a threshold on the similarity
           index (i.e. amount of addition/deletions compared to the file=E2=
=80=99s
           size). For example, -M90% means Git should consider a delete/add
           pair to be a rename if more than 90% of the file hasn=E2=80=99t =
changed.
           Without a % sign, the number is to be read as a fraction, with a
           decimal point before it. I.e., -M5 becomes 0.5, and is thus the
           same as -M50%. Similarly, -M05 is the same as -M5%. To limit
           detection to exact renames, use -M100%. The default similarity
           index is 50%.

       -C[<n>], --find-copies[=3D<n>]
           Detect copies as well as renames. See also --find-copies-harder.=
 If
           n is specified, it has the same meaning as for -M<n>.



> I am sending you this e-mail to suggest the creation of a new feature in =
Git:
> when renamed, a file or folder should inherit his parent=E2=80=99s log an=
d a =E2=80=9Crename: =E2=80=A6=E2=80=9D
> would be automatically created or have some kind of pointer to its =E2=80=
=9Cold=E2=80=9D form to
> make history analysis easier.

How do you currently analyse history, which detailed feature is missing?

Mind that in the Git data model we deliberately do not record the rename
at commit time, but rather want to identify the renames at log time.
This is because
in the meantime between commit and log viewing someone could have written
a better rename detection, whereas at commit time we'd be stuck with ancien=
t
cruft forever. ;)

>
> I volunteer to help in the new feature if you find it useful. I think it =
would
> improve log history analysis and would enable developers to better organi=
ze old
> code.

IMHO complete renames (i.e. git mv path/a/file.c path/b/thing.c) are alread=
y
covered quite well. Partial rename (e.g. moving code from one file into two
separate files or vice versa) is still a bit hard.

I started such a new feature, see
https://public-inbox.org/git/20160903033120.20511-1-sbeller@google.com/
latest code is at https://github.com/stefanbeller/git/commits/colored_diff1=
2,
but the latest two commits are bogus and need rewriting.

I think this feature is not 100% what you are aiming at, but is very close.

Thanks,
Stefan
