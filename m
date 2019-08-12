Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED6811F45C
	for <e@80x24.org>; Mon, 12 Aug 2019 16:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfHLQZE (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 12:25:04 -0400
Received: from sonic315-13.consmr.mail.bf2.yahoo.com ([74.6.134.123]:37592
        "EHLO sonic315-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726500AbfHLQZD (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Aug 2019 12:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aim.com; s=a2048; t=1565627100; bh=k4v2+q84NMmRZGsR03TngMr0Mo0sXEZ7aOC+hbafpp8=; h=Date:From:To:Subject:References:From:Subject; b=TpOu+XidjqC1kpy3kMxClWpKq8Fbf87rNT1Wpzqzn8k6m2oIzCrs5qvX024BcJK/+yNDixx86duD7rDSqclR6xGF40uuru9CHP39fw+YD2Rm26vOH7fagKo1iOdpgXTSjpth1KIsD+c9Vq7zKdsElqX2ozWYtJbLlIIWSZyd0hWgumvwZAdQfirqnjVBtBHTYhbTDveTeFgvKoYn/0vQJQvZlo4w812SuNiJ+3gw3L665vWTTLstnL1+r4NIxl3vz+y+j9Sh0G9MYO0Y7knzItQvpk79KhkuR/7mhDKOP7KFVbcZyIuPDAAZ9CNlmL2/zFF3WWsc2hWXwr2EXh3ZNA==
X-YMail-OSG: KOqoy5kVM1nIgXRYZi_YRVhsOp9INREGVUK1OXPtV8UN3eQOV8XixFPV4jaPFiq
 CILZEGcS7SqOAse4Iw.IBGFVSmh2tulPcBxV12dhySZMst7At5hJxCBV4HpNTs_UUQTGFrcByg9n
 dIV6fcw09zWB4oHxFMzM9tsBlJ14k7.s6nGnVnvNz.QpY0hZ3wOmvlPh5P8rfkY26KscozfZM7VG
 MlTQqD0A6BvDI4AcyePumx6lo8qSAY0WMn4BVpjr1dTw18_.qCJ0YOhg9uRkcgcAhkLID7sTslec
 yG1poZAU7EjLqZuD1vyzI3Rxis_wpG4vLyq_6pdBVpgmq2B5aj__fbkwO90u0R.te0.0LGcpQwBo
 UFX.vR6y_dFgZP9Y10_Chm4Axtse21.nVL9I558uR6rVZZkM6s_JZX8Klw.GlZZFBKehzbTXSlE.
 J8VYnLSGMNLDAoT4nDJNq7OeP4jtHbACrWSrFec7_N34O.HxjYT54rJKcAkbQPZdMwq7CqmspZC.
 12PjnTxAtk0joYyGzdL09cT5OGIFbSwHFsrbJl6yEX44cVMXSZ6VmS3wv5.3o60Ydc_SYUEXhtR7
 F68VO6v_PayABZXhbDWjh0u0tBXerMXr5xXj25dAX.FUGZnUIMfzxKmHLjmSPDeEjLhDVp2kRoSa
 0ZlRiTS5hUITedA1OS1B.81JHYGrVPX9cHB3P5KO8qAvEFQXrUnCxZGrAeHinhAdYRjNIlLnxzsU
 wZEO5Non12QRkds5SvtdgS3e4cpjOGtkYJvFxJnYz3aBNN2cty_NJnZyeGQMkMVB5DxO17hyreVb
 DMOFeBDmdWt4VXa5ypTH_iDConVY5qQLht98oJF23aKExnPe8WWIrpmyY_IzjgqVn2iWPnsXGgsF
 1yhf.Y37oAuiYgQsOR72h_gTu19H0XCllYjMPHOtrY6ejqHsAqOsAlrifTaWrlzp7aa4s92cCECx
 hJLbOOpOj0Sk3h84xVrEfN.K9i2m94uRuqOl7iUKQ1JXDsOvf_t8QhwgHIfuBSmommxcwdWfQhPQ
 .q42Z_vS_lboJFz.98XiqXTSdXnzTTkN97o5ZQv_FNsLkDal1sdClcPDypQdplbaJ8LNFaB4LktM
 vRklCpAj1wxmY_4y5nY081zEs7pYbr2jMcQ20PksGIDwBbcq61.SsBK4o7PPh1fFg0VF1.RN9u1.
 RP.M5fXnwEJ2mzkhU6.Yr
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Mon, 12 Aug 2019 16:25:00 +0000
Date:   Mon, 12 Aug 2019 16:24:59 +0000 (UTC)
From:   geoffsimons@aim.com
To:     git@vger.kernel.org
Message-ID: <1229468090.3098018.1565627099656@mail.yahoo.com>
Subject: Git add claims path is ignored, but git check-ignore returns no
 results
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1229468090.3098018.1565627099656.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.14097 aolwebmail Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I=E2=80=99m struggling with this.  Adding a renamed file to git claims that=
 it is ignored, but git check-ignore returns no results. =20
I can=E2=80=99t find anything relevant in .git/info/exclude either, or any =
of the .gitignore files I could find.

git check-ignore .\Source\UI\Website\LiveFeeds\Releases\IO\ReleasesSerializ=
er.cs
git add .\Source\ui\Website\LiveFeeds\Releases\io\ReleasesSerializer.cs
The following paths are ignored by one of your .gitignore files:
Source/ui/Website/LiveFeeds/Releases/io/ReleasesSerializer.cs
Use -f if you really want to add them.

I get a similar result for adding files in that directory, or the parent di=
rectory (releases), but the grandparent directory (livefeeds) works fine.  =
Any ideas what might be causing this?

Regards,

Geoff
