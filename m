Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FAC61F516
	for <e@80x24.org>; Thu, 28 Jun 2018 17:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933879AbeF1RVX (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 13:21:23 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43139 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932186AbeF1RVW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 13:21:22 -0400
Received: by mail-wr0-f194.google.com with SMTP id c5-v6so6286715wrs.10
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 10:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=p1FcJjiFCSrexwRnWx7u8yd5fk233T4hYzVxpbrJ1BY=;
        b=bkJrDVFWCHbW483y277pYj0HO+dX+PbU7DtOEoWjiEqXlcdg3rWlB6hNBhlfB9GuRo
         01qAkSxjCmeCuSnRwC6uwsdGMjlKpkyKsGS1SJtRtgehL3XEOVHwfhdhvTKRyzWHBDex
         Chdb1C0d7pxm3Fy0zKQW2cvFXusDonk2l0d/N8GeMinTXTBYqDLFoJEzFj9X7rMSJvgi
         ucryDCDwHR8io+bi+0Yy69S+8KWV5zyUQV9EO1qdWN9ll1uJx/kfrPYRtHg00KfShCuf
         QxyTtSY2C3mm4+/emz15NtZLexK8tyBowX1YI7u6yEMhS574UZHpLNKfiG6IYCjR1OR6
         uXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=p1FcJjiFCSrexwRnWx7u8yd5fk233T4hYzVxpbrJ1BY=;
        b=TZrDN6mqKtw4Hbc5/2t/J+JAx9Uoe+aoIZKM5mJvbHCIMXwIJAteQxjg3nbaNV3iB5
         07v8iI4NZFrLO8bSRHIFa1nT4B/m8eCa3tsKbGu/AoaSU9KewGisIDPYu1YhzX7/nk2J
         fk5uL4rRXFTiy9OQ//xKVglbZUeEix6sDxGs8qy0NejbrZru1u428w8qe6B4K3AqIXHl
         qw86pEpe3fWjCjJOV4pzDpKdp7T0mdko6IsEZ+Ik9r/9Je8KuKReVlJOKzMBQbdxdGPN
         mqqDJsuiRPY7TJkcgJ5UBTIDVc9QS5UUmQx+B6ms5kQeq9fk5uMNk61nUbVF7Nm5AhGk
         hugA==
X-Gm-Message-State: APt69E3Qw6Q9bB2HIBAv3iFiTIFGrAJdJnOUSEXvGp9nU1DuJFb9oXN0
        GrMoBe0NCW5Or0cVmW62vjY=
X-Google-Smtp-Source: AAOMgpctzJQ8pWOBhFLiBdL9V3MxAzx5CHQIqzsKDGYNlDo0V+YWFBvtBO6bwFjK8/QpnHtf/9sIZA==
X-Received: by 2002:adf:c7c3:: with SMTP id y3-v6mr9516577wrg.230.1530206481212;
        Thu, 28 Jun 2018 10:21:21 -0700 (PDT)
Received: from larsbook.fritz.box (p5DDB68D2.dip0.t-ipconnect.de. [93.219.104.210])
        by smtp.gmail.com with ESMTPSA id i14-v6sm6160735wro.11.2018.06.28.10.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 10:21:20 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: Use of new .gitattributes working-tree-encoding attribute across
 different platform types
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20180628143405.GA16657@sigill.intra.peff.net>
Date:   Thu, 28 Jun 2018 19:21:18 +0200
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Steve Groeger <GROEGES@uk.ibm.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4E8CDDC9-2957-401F-9BBE-93276C026848@gmail.com>
References: <OF5D40FE06.C18CD7CD-ON002582B9.002B7A02-002582B9.002B7A07@notes.na.collabserv.com>
 <20180628024446.GD644867@genre.crustytoothpaste.net>
 <20180628143405.GA16657@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3445.8.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Jun 28, 2018, at 4:34 PM, Jeff King <peff@peff.net> wrote:
>=20
> On Thu, Jun 28, 2018 at 02:44:47AM +0000, brian m. carlson wrote:
>=20
>> On Wed, Jun 27, 2018 at 07:54:52AM +0000, Steve Groeger wrote:
>>> We have common code that is supposed to be usable across different =
platforms and hence different file encodings. With the full support of =
the working-tree-encoding in the latest version of git on all platforms, =
how do we have files converted to different encodings on different =
platforms?
>>> I could not find anything that would allow us to say 'if platform =3D =
z/OS then encoding=3DEBCDIC else encoding=3DASCII'.   Is there a way =
this can be done?
>>=20
>> I don't believe there is such functionality.  Git doesn't have
>> attributes that are conditional on the platform in that sort of way.
>> You could use a smudge/clean filter and adjust the filter for the
>> platform you're on, which might meet your needs.
>=20
> We do have prior art in the line-ending code, though. There the
> attributes say either that a file needs a specific line-ending type
> (which is relatively rare), or that it should follow the system type,
> which is then set separately in the config.
>=20
> I have the impression that the working-tree-encoding stuff was made to
> handle the first case, but not the second. It doesn't seem like an
> outrageous thing to eventually add.
>=20
> (Though I agree that clean/smudge filters would work, and can even
> implement the existing working-tree-encoding feature, albeit less
> efficiently and conveniently).

Thanks for the suggestion Peff!=20
How about this:

1) We allow users to set the encoding "auto". Example:

	*.txt working-tree-encoding=3Dauto

2) We define a new variable `core.autoencoding`. By default the value is=20=

UTF-8 (=3D=3D no re-encoding) but user can set to any value in their Git =
config.=20
Example:

    git config --global core.autoencoding UTF-16

All files marked with the value "auto" will use the encoding defined in
`core.autoencoding`.

Would that work?

@steve: Would that fix your problem?

- Lars=
