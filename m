Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFACF2070F
	for <e@80x24.org>; Thu, 15 Sep 2016 19:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753974AbcIOTgO (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 15:36:14 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32946 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754029AbcIOTgM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 15:36:12 -0400
Received: by mail-wm0-f66.google.com with SMTP id b187so208032wme.0
        for <git@vger.kernel.org>; Thu, 15 Sep 2016 12:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qDtYxIDOZ9t7hiMyXVxVXPS24iE3UTgF8aBlPU4yQkI=;
        b=JZdkOiO79mvICcqsbQ97I+aYbVlpmyILhLABWf+nFjcb50F+V1ZiC6835tYZw6cSyY
         q6waWHyTqyIbJrywc2EOCkhg+dWLGVVYwIyXLmhF/hzcS/hRDvg5yTYpZu2Dk9nG8sZe
         2womjyqQZUSFNsoGMvIKd3RpxOT7w+A95HlWgmvn3aySR/dIb4YreBbqZtuhGs0sPhOj
         K0EEiZJy/PGZ2J0SokXpx4i8Dl8NyGoP6hUQp7ixiJyyDTKUd2rug8yudQs6DhWgs4r2
         HghX2n4qae8ApAJjRTFi6KRibr6Gp3QNqPd4QmQnKlYvzY5oYvpwDl4v/93FFdj+ujuw
         cr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qDtYxIDOZ9t7hiMyXVxVXPS24iE3UTgF8aBlPU4yQkI=;
        b=QrT+v8k+DnvaRgjvdawQiNmtzfU2BJJ+fDBneqaGOODB3Bm9wr+EBdnlrcpyflQXuh
         soENZaKXnwASmo7DyMGll9RxxutJ4YfvfmNX52uG/vT7hdwCp+yI+WU+hTi4blJyryX+
         0r1CSmODLJZBCb8suXlfyEy6Bg0YGECnEHJV5Xs2PH4fsottj5ow212PbKzYTURX0Usl
         Nm9w4J9hahZrWQao2G4PBmRS+CaqK9zhz039UHcGhyZszC9xXpK7hYfbRx33FRbnMSVb
         q3hkYNcCewzH7z3LC1f9J3zrBxSFtZESKldXy01QfTUYehMK/Ioty4oNLyCx4TkepX+P
         1apg==
X-Gm-Message-State: AE9vXwOE2USRkNMKAU7EmaFolcIDSgkOCCZBCotdk0glf1nAVybxycgi5dtphlYvJ0DthA==
X-Received: by 10.28.170.197 with SMTP id t188mr4408068wme.42.1473968171106;
        Thu, 15 Sep 2016 12:36:11 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB61FE.dip0.t-ipconnect.de. [93.219.97.254])
        by smtp.gmail.com with ESMTPSA id b188sm3797450wmg.24.2016.09.15.12.36.08
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Sep 2016 12:36:10 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v7 10/10] convert: add filter.<driver>.process option
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqvaxzvjj0.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 15 Sep 2016 18:23:25 +0100
Cc:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Git Mailing List <git@vger.kernel.org>, peff@peff.net,
        sbeller@google.com, Johannes.Schindelin@gmx.de, jnareb@gmail.com,
        mlbright@gmail.com, jacob.keller@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <5E675A29-628F-4076-A5D9-E359CCF04295@gmail.com>
References: <20160908182132.50788-1-larsxschneider@gmail.com> <20160908182132.50788-11-larsxschneider@gmail.com> <20160910062919.GB11001@tb-raspi> <10020380-76ED-4371-A0BA-59D07AF33CE0@gmail.com> <96554f6d-988d-e0b8-7936-8d0f29a7564f@web.de> <xmqqvaxzvjj0.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 13 Sep 2016, at 17:42, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> I would really consider to treat pathnames as binary, and not add a =
trailing '\n',
>> are there other opinions ?
>=20
> It would be the most consistent if the same format as
> write_name_quoted() is used for this, I would think.

Is that the solution you had in mind?

	quote_c_style(path, &quoted_path, NULL, 0);
	err =3D packet_write_fmt_gently(process->in, "pathname=3D%s\n", =
quoted_path.buf);

Wouldn't that complicate the pathname parsing on the filter side?
Can't we just define in our filter protocol documentation that our=20
"pathname" packet _always_ has a trailing "\n"? That would mean the=20
receiver would know a packet "pathname=3DABC\n\n" encodes the path
"ABC\n" [1].

Thanks,
Lars


[1] Following Torsten's example in=20
http://public-inbox.org/git/96554f6d-988d-e0b8-7936-8d0f29a7564f@web.de =
)

