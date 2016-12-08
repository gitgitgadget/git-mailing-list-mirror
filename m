Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A1B21FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 14:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932105AbcLHOdQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 09:33:16 -0500
Received: from mail-wj0-f195.google.com ([209.85.210.195]:34377 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752721AbcLHOdP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 09:33:15 -0500
Received: by mail-wj0-f195.google.com with SMTP id xy5so54731991wjc.1
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 06:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BrHkfuI8uqPdSUcmdFHX+l8BXASW+YB1O7kyAwBEr7A=;
        b=YHtBQDXJ+r2a7NCKKntqhKnxmv2O72hU5qO1Yfqf3nS9FfMneTTARsMCFEBhaq8OO9
         RhJBdkHVTWQxSnEWhU+FNFSgvpe0Nw+aV9m5lfU0BEgVBhCrjrspb3EXpspUvGt63uMz
         ibeHy2QI9s6KuUK5iMeO4y659jFpH4ojkkwqmY3XtHX6FzZx/9ytyR/WrjB9WMnUXT68
         3CbNj+z2g1g3VJNEggXyGJjAKdID+byIp8fCXk0iB1NZ8Qe/fVVMZCFAebglJbW20s0S
         Wus+Oqwhq0Dd+MibltWgyYZ8zRSzyiBS1UUhd6KdD/Y5wY0IWyymbtq3Fkkz4BW5PaxW
         2KxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BrHkfuI8uqPdSUcmdFHX+l8BXASW+YB1O7kyAwBEr7A=;
        b=JxeQ3QjUjk7CMKdy02XYYm55jeejf5tSkAHbGolIerrE7PHgNmdNJHtTogJQSacQ8A
         fJT2pJ8KUYkvtGcPdyMW5rd/wGF3PnlR6kxHcG2eHEMr+5tbPPWx/xwalJRGXDWeC7Bp
         7dlf2doKux4Sv8wahtbR8fUDBveY/vwQkr0613LphykT1J69OLJyAyNWC2ry3DhXEiIA
         wzeAes5rxH4y3j+4dyje6Z+e/W0che6z8nhKwwHWiGWZjhU/cylzWh90I8LTwBXphFCC
         ZCnYYzItfQwP7t2JkgH5WzY2TDlVpyBM03UHlvI2Lb7r/QILetmBB0Q3nGKyJ+l/j2yg
         GYug==
X-Gm-Message-State: AKaTC03eUkY6E3OWVzFjIXV/ai0peJ6THa1RT7sfGhQr1CvoFJwtOXRD3tg5pHOaQWdBOw==
X-Received: by 10.194.10.72 with SMTP id g8mr76095954wjb.57.1481206698024;
        Thu, 08 Dec 2016 06:18:18 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id w79sm15500134wmw.0.2016.12.08.06.18.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 06:18:17 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Serious bug with Git-2.11.0-64-bit and Git-LFS
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CABW+60za0shXucPgg_jGYt4f8QbkLzLmS5GRf8czE67Taqd+zw@mail.gmail.com>
Date:   Thu, 8 Dec 2016 15:18:30 +0100
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D1437EA2-F4D3-4190-8D79-020C06CFA3DB@gmail.com>
References: <CABW+60x0PSw7uNQZg4SeN7EAbNpraR_HWvnVFz1-fVLYX=B8RQ@mail.gmail.com> <06520F42-BD49-4349-83B3-74DCA1E260CD@gmail.com> <CABW+60za0shXucPgg_jGYt4f8QbkLzLmS5GRf8czE67Taqd+zw@mail.gmail.com>
To:     Nick Warr <nick.warr@bossastudios.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 08 Dec 2016, at 15:00, Nick Warr <nick.warr@bossastudios.com> =
wrote:
>=20
> That looks pretty much like the error we're dealing with, any reason
> why going back a point version on Git (not git-lfs) would resolve the
> issue however?

Going back to GitLFS 1.4.* would make the error disappear. However, I =
think
you should fix your repository. Try this:

git lfs clone <YOUR REPO URL>
cd <YOUR REPO>
git rm --cached "workers/unity/Assets/3rdPartyAssets/FORGE3D/Sci-Fi =
Effects/Effects/Debris/Meshes/debris_junk.FBX"
git add --force "workers/unity/Assets/3rdPartyAssets/FORGE3D/Sci-Fi =
Effects/Effects/Debris/Meshes/debris_junk.FBX"
git commit -m "Move files properly to GitLFS"
git push

Afterwards you should be able to use the latest version of Git and =
GitLFS
without trouble.

Cheers,
Lars

PS: Top posting is not that popular in the Git community ;-)


>=20
> On 8 December 2016 at 13:57, Lars Schneider <larsxschneider@gmail.com> =
wrote:
>>=20
>>> On 08 Dec 2016, at 12:46, Nick Warr <nick.warr@bossastudios.com> =
wrote:
>>>=20
>>> Using Git-2.11.0 with the latest git-lfs 1.5.2 (also tested with
>>> 1.5.3) cloning from our locally hosted gitlab CE server via HTTPS.
>>>=20
>>> When cloning a repo (large, 3.3 gig in git, 10.3 in LFS)  for the
>>> first time the clone will finish the checkout of the git part, then
>>> when it starts downloading the LFS parts it will reliably finish =
with
>>> a smudge filter error.
>>>=20
>>> This leaves the repo in an unstable condition, you can then fetch =
the
>>> lfs part without issue, but checking out the lfs files or trying a =
git
>>> reset --hard will continue to spit out the same error. As you can =
see,
>>> the actual error is not particularly useful.
>>>=20
>>> fatal: workers/unity/Assets/3rdPartyAssets/FORGE3D/Sci-Fi
>>> Effects/Effects/Debris/Meshes/debris_junk.FBX: smudge filter lfs
>>> failed
>>> Unknown command ""
>>>=20
>>> Possibly it's due to the file extension being all capital letters, =
we
>>> did manage to change the error by recommitting the file with a
>>> lowercase extension, but it failed on the next file (which also had =
a
>>> capital letter extension).
>>>=20
>>> This has happened on multiple fresh windows 10 64 bit installs,
>>> different machines and target directories (to hopefully remove the
>>> possibility of file permissions) where cloning is taking place.
>>>=20
>>> The solution is to back level to Git 2.10.2 and the error =
disappears.
>>>=20
>>> More than willing to provide any further information,
>>=20
>> Hi Nick,
>>=20
>> debris_junk.FBX is not stored properly in Git LFS.
>> I explained the problem in detail here:
>> https://github.com/git-lfs/git-lfs/issues/1729
>>=20
>> You should add the file properly to GitLFS to fix the problem.
>> However, I think this is a regression in GitLFS and I hope it will
>> be fixed in the next version.
>>=20
>> No change/fix in Git is required.
>>=20
>> Cheers,
>> Lars

