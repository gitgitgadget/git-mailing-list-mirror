Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FBD4202A2
	for <e@80x24.org>; Fri, 20 Oct 2017 23:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752752AbdJTXtY (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 19:49:24 -0400
Received: from mail-vk0-f43.google.com ([209.85.213.43]:47183 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752498AbdJTXtX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 19:49:23 -0400
Received: by mail-vk0-f43.google.com with SMTP id j2so8278588vki.4
        for <git@vger.kernel.org>; Fri, 20 Oct 2017 16:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TQrMkJzM98cqVczmxom3ADpRnYsOTF1Ut/gNEgWuwKo=;
        b=1LB6UXObWqLpN1E9xBNDmzo8cEVRgmIPyzS6J2xJaZCC8Wv6RZFc3mkWxxBGIUoj3K
         QojnSKaRRsg819MOdGDcUUTOTDOLqMIZ2ULoRC/IVeJ0mGxXXt6ULkU9lzn2SWXQGJm3
         rR43tMcCo8VV2URSstU9yQkVQQ/ZqMZ/J/N/G0dvZLq3JcMEaFRw0SCGmJBSxbTv1rDy
         o3coYMvdNNnR+BItPQh/Q5MTakZdg2vleVYVsuL1qFGSO4tLRXP7+AIRhSBNsLN9cB8H
         Ee2xdJsIQCWFGMvtkK2Xax3dfBEVRXAtjlq0C2F5lg3RDUmtyjS5X7YJjqNRnYOwe+RQ
         JWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TQrMkJzM98cqVczmxom3ADpRnYsOTF1Ut/gNEgWuwKo=;
        b=QMOvmJE3VpG0J7Dcl8/0L/hz5hWGA0uewRloGEsmTc3uvGmu++yT+HiaLuW9mpEBCb
         6vdSC5K5CHDYcnDt0Yazocx3NLLsSWOl5/ocjEnUkMyH+bFYeupFBfHjgr985wyesKJf
         r8J8Sl6hT7opvh6UXa6574EY5+SHcnq3Nd5EeqieGC6MDXYDT7teKh4WM8Bb3vU4g+f7
         uBVmDZuK9Z15syA0oNHT5yxVX3FLc8t+o4Oi8q3JW1AX9wuGDohnFeho76SP9CWeeYLB
         5HJVOo08SumBqM/NaLxlLshctdzhH92kcvpWCPKdfuCcG7uFjx6NQIZwCoGG95FU7DLJ
         NLFw==
X-Gm-Message-State: AMCzsaVZ3PMENDN8VA1QoBkAq4xh8QuTP6wczK4C+9Vq0wp22gyiVDhg
        a/d8DjZEb9Rz0I/fjeKkDCwIvYZYKHaMz5XLLSO1Iw==
X-Google-Smtp-Source: ABhQp+RF4DvmP4uejSd6GPTajFk6dSTE4YNgL9jhkDiQMIfgZqkNjQl4nigNObzWOaeDSx90/7ZfPzZM9jc+OOckXfs=
X-Received: by 10.31.26.3 with SMTP id a3mr4867800vka.43.1508543362476; Fri,
 20 Oct 2017 16:49:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.30.139 with HTTP; Fri, 20 Oct 2017 16:49:22 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1710210020290.40514@virtualbox>
References: <xmqqr2tygvp4.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1710210020290.40514@virtualbox>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Fri, 20 Oct 2017 16:49:22 -0700
Message-ID: <CAGyf7-HCsTaqa-CC1omtT+O9A4P_SspaNZUf4UbZHcUbh71+OQ@mail.gmail.com>
Subject: Re: Git for Windows v2.15.0-rc prerelease, was Re: [ANNOUNCE] Git v2.15.0-rc2
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>,
        git-for-windows@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 20, 2017 at 3:22 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi team,
>
> [cutting linux-kernel]
>
> On Fri, 20 Oct 2017, Junio C Hamano wrote:
>
>> A release candidate Git v2.15.0-rc2 is now available for testing
>> at the usual places.
>
> The Git for Windows equivalent is now available from
>
>     https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_git=
-2Dfor-2Dwindows_git_releases_tag_v2.15.0-2Drc2.windows.1&d=3DDwIBAg&c=3DwB=
UwXtM9sKhff6UeHOQgvw&r=3DuBedA6EFFVX1HiLgmpdrBrv8bIDAScKjk1yk9LOASBM&m=3D3D=
dPEJGQe01zvIuHjX8rNURKuGEY_cPkUXvnur9xlNg&s=3DZC45D6NoNiE4A8qs_F1ZDMJlGMdXc=
Q9DwDIpE1-whrU&e=3D
>
> Please test at your convenience,

Thanks for publishing this, Johannes. I've run it through our Windows
test matrix for Bitbucket Server (~1450 tests) and all pass. I've also
added it to our CI build as a canary (pending the final 2.15.0
release). I've done the same for 2.15.0-rc2 on Linux as well.

Best regards,
Bryan Turner
