Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E64682036D
	for <e@80x24.org>; Mon, 27 Nov 2017 12:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752145AbdK0Mwb (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 07:52:31 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38291 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751889AbdK0MwU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 07:52:20 -0500
Received: by mail-wm0-f47.google.com with SMTP id n74so9052827wmi.3
        for <git@vger.kernel.org>; Mon, 27 Nov 2017 04:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vLJZGjElE6dOBf4TLW3HjZh85IHUkuWhdBsV88oNsJg=;
        b=ks/LcimLXnJng+mvPvKe1UtFNzp16UVQQzVvBz3efeTtS5bdMiVbVKg7sD/u94Yqh+
         x1BZNceUI0odVpQmlXJPvd7etyz62KaEn9qVk4zEva4/Kf5UQmL4dG+eDuw/k741Sqkp
         EwY9XE81Vw9FZcdcdr5SJBrPUXozYqxEut/Br08prXBVCmD36epd1xBg6xiIN5ZcQRB8
         qfCkGbW9ME4CaFRlejow5ctWto3Rlw5fvK52ESDMxb+6Zl3mXPHNelJeAiCl9SJZKNew
         4hQUCaHpG6Jdwey7Ny61e7OB2L/fhLwprUzw6PryUBn3Ptrm+GIen1pv5C7ZdnKJIIMu
         6wVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vLJZGjElE6dOBf4TLW3HjZh85IHUkuWhdBsV88oNsJg=;
        b=JHjcgl2q+MnieaVTS78dbOW3M1Aqj8y7LlUtmKHO1JRgEn53v3PS6I3bQsT8i1Owpc
         TlETZcu/R3WpanLycF+CpsbQuDPuP3GcunOJVD94QuDrJHm+tuXJiUM2GO0/nHmWpJjc
         8IZUeGa/zuve9vWadOGbOskaMcP2auJPv759zsOqyi6IVNar4UAF6zc4QwQgzrqT31eu
         Brv/Tv8yq/Jtc4V6vIxA52UoxSjBp4/EVmyIh6ualUZJFHsGB/InehMHG+cb0ENykG/f
         yHpwrTXXnWIUWB3Il2OOL5bX/IKiGFTN4/zXn5BhxJfl8goHDnJQRUL6cUnCY2VHyONJ
         su3Q==
X-Gm-Message-State: AJaThX7hry7sBHU632k2sHnnTOnJd+hDZleCwaqA9ksY0/1KPbjy/Rke
        rAKW35kn+/ZC/FajhJujgwU=
X-Google-Smtp-Source: AGs4zMacCYp2FcTnuhpJy1GaVHx+TLUvxu1qBfgc3QHhlCFARI3k97Sf7njv8bHUeDVIBeOQhf1Uog==
X-Received: by 10.28.178.135 with SMTP id b129mr16559124wmf.103.1511787139096;
        Mon, 27 Nov 2017 04:52:19 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id r63sm22986787wmg.13.2017.11.27.04.52.18
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Nov 2017 04:52:18 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: git-p4: cloning with a change number does not import all files
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAL1_K8AYf1jKDO8+czcqkUxDAuOODgKv9avaiikWi+4zpqenMQ@mail.gmail.com>
Date:   Mon, 27 Nov 2017 13:52:17 +0100
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <57A92686-9161-4234-8341-CD6FAD7AE049@gmail.com>
References: <CAL1_K8AYf1jKDO8+czcqkUxDAuOODgKv9avaiikWi+4zpqenMQ@mail.gmail.com>
To:     Patrick Rouleau <prouleau72@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 25 Nov 2017, at 21:35, Patrick Rouleau <prouleau72@gmail.com> =
wrote:
>=20
> Hi,
>=20
> I created a git repository with these commands:
>  git p4 clone //perforce/path@123456 repo
>  cd repo
>  git p4 rebase
>=20
> Some files created before the change 123456 do not exist in git
> history. I do see why,
> but those files were not modified after that change number.
>=20
> If I use "git p4 sync --detect-branches" instead of "git p4 rebase",
> the branch contains
> all the files, but not the main trunk, and they appear to be added in
> the first commit of
> the branch.
>=20
> To avoid the problem, I must clone with "@all" or with the change =
number when
> //perforce/path was created, which is significantly longer.
>=20
> Regards,
> P. Rouleau

Hi Patrick,

what is your goal here? Do you want to convert the repo to Git or do you
want to use Git to interact with a P4 repo?

I mainly do the former and use the @all switch. You can greatly reduce
the time if your `git-p4` machine is close to the P4 server and if you
reduce the P4 client spec used for the migration.

- Lars=
