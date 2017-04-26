Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DBE8207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 19:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753995AbdDZTlF (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 15:41:05 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38705 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753989AbdDZTlD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 15:41:03 -0400
Received: by mail-wm0-f51.google.com with SMTP id r190so14743978wme.1
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 12:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FyP5r629LJ/IK2e7KHg5BZP7qV1jqwQ3wz9k1r0FzEU=;
        b=dxDc9iJfmfIvIXpTHCtTGJnAzFqLdK+d9Ewh/gluglFbw71tWHuo1H+QG61wR69zJd
         ctXAhV46JaLqKnWrOHH/XEq9PdMTpq44Lz5RmjG65GZHjjrTdbKoxaVqJXFlQOz+5OaS
         OryMI4nYTqsPCCcn0Y/4H5fLYwU5o7osEwLB7aMYWDr1TYtwTsAkActVk6oNx+M/I5fu
         K+fvlPlRoGIpY5d+0LM7/9sXt3Zju9+dbVZiyz9bWSiqSFZb+h8n3xGodHqJcOy+XfTY
         Cl8oEBWJ4GNM/xncPnYaOADVw6YzU3o9PGR/rexxIaVYw0Oz//sRitnIEAW2nx2vYmX7
         YMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FyP5r629LJ/IK2e7KHg5BZP7qV1jqwQ3wz9k1r0FzEU=;
        b=kglgEZi0ME5ZCeZ5smXT+aMdhKByTNBfHdxJYU26g7Ko+Dg4wBU60CACyfsji/vXA2
         7j7CEwDi3NSOvUe0ASNEd/5IGn+7/nON9m3a+F8BNfWs0GGZNeA9mXrAQgMhXzBGKoW5
         /FEl7457FRHvt8+oLjISWv/UVBTi9JbcyBKpRZ1RDz76vRlwRmLH1vaMwOGPstlXP+cJ
         FHDlGDC2wSCt9T6inh35tmT1heGdHH2DpOkh40DEd0y37ovc/qfBKX+yk/dW1EA8pQj2
         IR4ycaW5zPn22qBH8VtMjoSU0Hyq/k+g88YtqRvy3abqZv/aFZFD6RrIiVRNAB0khDON
         xY4w==
X-Gm-Message-State: AN3rC/5cw90SuOcj4tfKYJGa+aCJALJzoTeUIt3hlsCgyIm9qnFIVSx4
        DOzdhLn3u6dKIQ==
X-Received: by 10.80.164.178 with SMTP id w47mr2096694edb.19.1493235662334;
        Wed, 26 Apr 2017 12:41:02 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id h29sm606079eda.45.2017.04.26.12.41.01
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 12:41:01 -0700 (PDT)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: t0025 flaky on OSX
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <72445da2-04eb-5d51-42f6-7e7fce4d4843@web.de>
Date:   Wed, 26 Apr 2017 21:41:00 +0200
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3AF5FF19-F0C6-43D2-85F6-7716CF22FA6B@gmail.com>
References: <461E433C-DC8E-42FE-9B23-4A76BEFE0D11@gmail.com> <e6343f94-3fad-e323-cb38-8ea1148cec3f@web.de> <11da00e8-a62c-bf07-d97e-ab755647082b@web.de> <7D9AE52B-6A2D-408B-855E-3988514AAC45@gmail.com> <72445da2-04eb-5d51-42f6-7e7fce4d4843@web.de>
To:     =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 26 Apr 2017, at 06:12, Torsten B=F6gershausen <tboegi@web.de> =
wrote:
>=20
>=20
>>>=20
>>> So all in all it seams as if there is a very old race condition =
here,
>>> which we "never" have seen yet.
>>> Moving the file to a different inode number fixes the test case,
>>> Git doesn't treat it as unchanged any more.
>>=20
>> Thanks a lot for investigating this! Would you mind posting the
>> fix as patch?
>=20
> That's ongoing.
> TC #3 and #4 are fixable, but #5 resists to be cured so far.
> I think we need a touch and sleep or so, more the next days (or weeks)

Cool! Actually #3 seems to cause most of the trouble.
Therefore I think a patch for #3 and #4 would already be valuable!

Thanks,
Lars=
