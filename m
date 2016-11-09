Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EA6E2021E
	for <e@80x24.org>; Wed,  9 Nov 2016 22:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752877AbcKIWMJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 17:12:09 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36488 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752312AbcKIWMI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 17:12:08 -0500
Received: by mail-wm0-f66.google.com with SMTP id c17so31902233wmc.3
        for <git@vger.kernel.org>; Wed, 09 Nov 2016 14:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wAznYGtxK6V7Zb+f6mizwtDIsSLUqUSGrF6aeAm8Mp4=;
        b=OhYlywtvM5f+7UB86fTIbn78scM7QFs6qedx6/PuhTRiGkKoOj8ZdaawAI5rUbaiVw
         8lMhRNhxZgmz0mX3fmESaGQC0YSkIxKHsIjGX3s3X03eokFwI87FitzTXwr7KG+htSDm
         WR6jWDXvrpMFd3iK06dTkwlV6XzWkZiy0+IEBZYKpHR4piLULeuK3A82Z+MFQ+MznGWL
         u4FgebAYnZhrt9STrNgkeYo79kRHgyvyqWxKCkCJ6PgrYf00qdQ5qulsefcaMzB2g6LX
         Ry7W+nUkJ6GEarcgzU/igybtLaqqy2U4tEfnUNqkI3vMGJrkb+N5qp82IU8O7ynKoXgB
         Oauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wAznYGtxK6V7Zb+f6mizwtDIsSLUqUSGrF6aeAm8Mp4=;
        b=OEP28Y8JBZccAkBGZPyi66VMAP9cQogYyatGJESmNU3JykVr/ZmaQ1JI6WrU491E22
         BQgG4O8v3FeYegEitzfRxl7fSZ0DeRoDxVGaQzdYKaDVc8VJtE9+I6CnygEJCy1GTwcg
         +CCnQzG+45hgdZS+py7zZTpQ/eIdeF2yzG7FFb0fTdIkWSnFRQRRMuhI7hz5vuwQ/FF5
         J+BXgHrc+O+OB1weEnghhw0gDy2xrRc3DELuoXbOrjChFr5/FgHWhSJGWyzHtQnVZOSH
         lD+s8edVY+vyzR84ZmnEXCIKWFglfyTNcfqaBtLWHr70eljH6nq3hEqtZfhzKMWDty29
         mytg==
X-Gm-Message-State: ABUngveR/DACqaFSQVRQhr8JTjuW2uOYBnFwN6JyRqZ+FSF3f8D0cR4XTsAbS02JdBqQ4g==
X-Received: by 10.194.94.166 with SMTP id dd6mr1841786wjb.88.1478729526809;
        Wed, 09 Nov 2016 14:12:06 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB4B5F.dip0.t-ipconnect.de. [93.219.75.95])
        by smtp.gmail.com with ESMTPSA id f3sm9353863wmf.10.2016.11.09.14.12.05
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Nov 2016 14:12:06 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [git-for-windows] [ANNOUNCE] Prerelease: Git for Windows v2.11.0-rc0
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <alpine.DEB.2.20.1611051025030.3108@virtualbox>
Date:   Wed, 9 Nov 2016 23:12:05 +0100
Cc:     git-for-windows <git-for-windows@googlegroups.com>,
        Git Mailing List <git@vger.kernel.org>, me@ttaylorr.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <B2BEB5B4-5CF0-4CD7-A8E2-50D51E00D2FF@gmail.com>
References: <alpine.DEB.2.20.1611051025030.3108@virtualbox>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 05 Nov 2016, at 10:50, Johannes Schindelin =
<johannes.schindelin@gmx.de> wrote:

> Dear Git users,
>=20
> I finally got around to rebase the Windows-specific patches (which =
seem to
> not make it upstream as fast as we get new ones) on top of upstream =
Git
> v2.11.0-rc0, and to bundle installers, portable Git and MinGit [*1*]:
>=20
> =
https://github.com/git-for-windows/git/releases/tag/v2.11.0-rc0.windows.1


I tested a new feature in 2.11 on Windows today and it failed. After =
some=20
confusion I realized that the feature is not on your 2.11 branch. =
Consider this:

My last patch on your 2.11 branch is=20
"pack-protocol: fix maximum pkt-line size" (7841c4):
=
https://github.com/git-for-windows/git/commits/v2.11.0-rc0.windows.1?autho=
r=3Dlarsxschneider

My last patch on the Git 2.11 branch is=20
"read-cache: make sure file handles are not inherited by child =
processes" (a0a6cb):
https://github.com/git/git/commits/v2.11.0-rc0?author=3Dlarsxschneider

Do you have a clue what is going on?

Thanks,
Lars

