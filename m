Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71D161F516
	for <e@80x24.org>; Mon,  2 Jul 2018 14:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbeGBOJh (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 10:09:37 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39655 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751493AbeGBOJg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 10:09:36 -0400
Received: by mail-wm0-f66.google.com with SMTP id p11-v6so8855573wmc.4
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 07:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bqmhRWOQf7YDg71ygU/BSCXGOBREmySzVCI6T8vVE+s=;
        b=R3RPZv7qnfb+e0jQVYyr39OpWh4LQVJv21S3jKSvWHnTElCS3kdNleZRKWjjHVf4bM
         t8JuIHMlfhrIX5SLT2TPrx5iEYuA/G4i6ZaEBtoGNCS+67Z/Je6VhAypu6DwI0ugsNt5
         wlo5/ihoGn2s8tyX15Ap6Iafi7WHBQsYcE+oo39RRtoyNBaX1ZU0Dw+KOxAFKbsC7I6O
         Lo79rI2ruu4Y9CVXmymRGp3IvIiAIniuMN5A7Rjc4+nie2Bfxtu/xSXc99Yd5a7DbfIi
         nB1fswIVjtrrZ2ndqWtCibEmNRhS+jy99ubkydfnMfcS2jTmFqT63XOzKxBVv1gGo95G
         GkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bqmhRWOQf7YDg71ygU/BSCXGOBREmySzVCI6T8vVE+s=;
        b=DvSWdl+8OLeB3X8BuKSm8HawDJABKvq9BJjh63iGZTgR/s48pJ3GJEXVNvnffInnHs
         Iw/RF8sitvse1YhbBULkGPingCCrPp3o/xWTSZTFkx1lCoNmcgyJ1IASCGUynHRXR3dI
         GZLnpBnceD/iC/XNtTT4SrWsEzFVfEtIkiPQSTPDZWjmFk7RRenMxCIrIvNQkUC/gLRT
         OUcBBasJgoaL2BSk3dgcGj1J51tQN95s2Emm4+mpskMDKTPY7edfU1eC/Hf7Mcnl8szc
         xL/QFhGCcf8H2+Jtsm5GEvHXsNQQJnlMovSneZY2FQcz9IdO6geM1WKeJpzWYUO6DZCk
         I9JA==
X-Gm-Message-State: APt69E1K++nTuvdCEojIv79Muu1ekqR2D0IhCpDz0/Oa88u6wHmaGQVy
        mTIQXRTVURyeMptowW+Y4OZn9l9k
X-Google-Smtp-Source: AAOMgpfEnWNkPS4PPZb8+dqtUxMaa3Ix8/IQgeo1hnncuJPypY8wzgnBvj1u1nPlgDubZI5NCcU1Kg==
X-Received: by 2002:a1c:1808:: with SMTP id 8-v6mr9106592wmy.113.1530540574923;
        Mon, 02 Jul 2018 07:09:34 -0700 (PDT)
Received: from [192.168.88.175] ([217.9.127.14])
        by smtp.gmail.com with ESMTPSA id o131-v6sm7117683wmo.22.2018.07.02.07.09.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 07:09:33 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: Use of new .gitattributes working-tree-encoding attribute across
 different platform types
From:   Lars Schneider <larsxschneider@gmail.com>
X-Priority: 3 (Normal)
In-Reply-To: <OFAD36A6D5.F36D27E7-ON002582BE.0043296C-002582BE.0043297F@notes.na.collabserv.com>
Date:   Mon, 2 Jul 2018 16:09:32 +0200
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4621C69D-B837-43ED-8570-462D4CF2BBA0@gmail.com>
References: <4E8CDDC9-2957-401F-9BBE-93276C026848@gmail.com>
 <OF5D40FE06.C18CD7CD-ON002582B9.002B7A02-002582B9.002B7A07@notes.na.collabserv.com>
 <20180628024446.GD644867@genre.crustytoothpaste.net>
 <20180628143405.GA16657@sigill.intra.peff.net>
 <OFAD36A6D5.F36D27E7-ON002582BE.0043296C-002582BE.0043297F@notes.na.collabserv.com>
To:     Steve Groeger <GROEGES@uk.ibm.com>
X-Mailer: Apple Mail (2.3445.8.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Lars Schneider <larsxschneider@gmail.com> wrote: -----
> To: Jeff King <peff@peff.net>
> From: Lars Schneider <larsxschneider@gmail.com>
> Date: 06/28/2018 18:21
> Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Steve Groeger =
<GROEGES@uk.ibm.com>, git@vger.kernel.org
> Subject: Re: Use of new .gitattributes working-tree-encoding attribute =
across different platform types
>=20
>=20
>> On Jun 28, 2018, at 4:34 PM, Jeff King <peff@peff.net> wrote:
>>=20
>> On Thu, Jun 28, 2018 at 02:44:47AM +0000, brian m. carlson wrote:
>>=20
>>> On Wed, Jun 27, 2018 at 07:54:52AM +0000, Steve Groeger wrote:
>>>> We have common code that is supposed to be usable across different =
platforms and hence different file encodings. With the full support of =
the working-tree-encoding in the latest version of git on all platforms, =
how do we have files converted to different encodings on different =
platforms?
>>>> I could not find anything that would allow us to say 'if platform =3D=
 z/OS then encoding=3DEBCDIC else encoding=3DASCII'.   Is there a way =
this can be done?
>>>=20
>>> I don't believe there is such functionality.  Git doesn't have
>>> attributes that are conditional on the platform in that sort of way.
>>> You could use a smudge/clean filter and adjust the filter for the
>>> platform you're on, which might meet your needs.
>>=20
>> We do have prior art in the line-ending code, though. There the
>> attributes say either that a file needs a specific line-ending type
>> (which is relatively rare), or that it should follow the system type,
>> which is then set separately in the config.
>>=20
>> I have the impression that the working-tree-encoding stuff was made =
to
>> handle the first case, but not the second. It doesn't seem like an
>> outrageous thing to eventually add.
>>=20
>> (Though I agree that clean/smudge filters would work, and can even
>> implement the existing working-tree-encoding feature, albeit less
>> efficiently and conveniently).
>=20
> Thanks for the suggestion Peff!=20
> How about this:
>=20
> 1) We allow users to set the encoding "auto". Example:
>=20
> 	*.txt working-tree-encoding=3Dauto
>=20
> 2) We define a new variable `core.autoencoding`. By default the value =
is=20
> UTF-8 (=3D=3D no re-encoding) but user can set to any value in their =
Git config.=20
> Example:
>=20
>    git config --global core.autoencoding UTF-16
>=20
> All files marked with the value "auto" will use the encoding defined =
in
> `core.autoencoding`.
>=20
> Would that work?
>=20
> @steve: Would that fix your problem?


On Jul 2, 2018, at 2:13 PM, Steve Groeger <GROEGES@uk.ibm.com> wrote:
>=20
> I think this proposed solution may resolve my issue.

Thanks for the confirmation!

Brian had a good argument [1] for an even more flexible system
proposed by Peff:


1) We allow users to define custom encoding mappings in their Git =
config.=20
Example:

    git config --global core.encoding.myenc UTF-16


2) Users can reuse these mappings in ther .gitattributes files:

    *.txt working-tree-encoding=3Dmyenc


Does this idea look good to everyone?

Thanks,
Lars


[1] =
https://public-inbox.org/git/20180701175657.GC7965@genre.crustytoothpaste.=
net/
