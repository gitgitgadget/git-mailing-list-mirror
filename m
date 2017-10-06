Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8563D20370
	for <e@80x24.org>; Fri,  6 Oct 2017 18:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752982AbdJFSJl (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 14:09:41 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44425 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752974AbdJFSJj (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Oct 2017 14:09:39 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 7465F20D31
        for <git@vger.kernel.org>; Fri,  6 Oct 2017 14:09:39 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 06 Oct 2017 14:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-sender:x-me-sender:x-sasl-enc
        :x-sasl-enc; s=fm1; bh=BpZwAi92nNaEwkoAvbMJ7J0hR8G9m+2FGjh7nIBf4
        s4=; b=hQmUKHZb8Ym84sgPS6XdPBhJbGTMPrDmewNvgzXqWe2JvHC5saO/4m6CD
        baIhcU416C5JTY8Y6NtdHqnNHJnAA92jgltzKsnC6AZut45n/++ki2N2IHqCXmmN
        TWBw7701paF5SzfNVYs7G0sqPGW+1d9JW1OiA656wYzAnOh7kRku/9HkzOqr+mfn
        1WtXExc4ME1Gj8wBriPDfSYpc7D8K+DootwEpbHNJcUbg8eeeyWVuw5kmY/aqdT4
        FG9gU8zHy8ClQ/R8pAxPVklcdtSQVSyJrjSFAu46iqrBTdBM0hM2A2kqV8Ia1sfN
        s+W0lHbE4S0Oczll1m7T5HJs2oMSQ==
X-ME-Sender: <xms:48bXWcNG_L4iMPO_qsg8hzwDkufaWWUgxL0F8MFftA7qYmBd0OOe_A>
X-Sasl-enc: h+oWmA1tKierTmVRPNQ0zXIAnzOC1BGV5Iy1eGdGC5PP 1507313379
Received: from [192.168.1.8] (c-75-72-214-216.hsd1.mn.comcast.net [75.72.214.216])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3888724810
        for <git@vger.kernel.org>; Fri,  6 Oct 2017 14:09:39 -0400 (EDT)
From:   Jake Bell <jake@theunraveler.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_19F54ECE-133B-4B25-83C2-70EEA28844B7";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Subject: git add --patch displays diff and exits
Message-Id: <AE36B16D-0284-4AC0-BD5E-CD346036D69D@theunraveler.com>
Date:   Fri, 6 Oct 2017 13:09:37 -0500
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.1.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_19F54ECE-133B-4B25-83C2-70EEA28844B7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hello,

I'm not sure if this is the right place to report this issue, so =
apologies in advance if it isn't.

Recently, I upgraded from git 2.14.1 to 2.14.2, and noticed that "git =
add --patch" does not work properly. It just prints a diff of what's =
changed and exits, instead of presenting the dialogs to add changes to =
the index. I did some bisecting and tracked the bug down to this commit: =
https://github.com/git/git/commit/136c8c8b8fa39f1315713248473dececf20f8fe7=
.

Unfortunately, I'm not familiar with the codebase and don't know C well =
enough to debug the issue. Please let me know what additional =
information I can provide to help you all figure it out.
Thanks!

-- Jake


--Apple-Mail=_19F54ECE-133B-4B25-83C2-70EEA28844B7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENFtmcOhOFMZ2oYMozkHV3VyCET4FAlnXxuIACgkQzkHV3VyC
ET5BOBAAqr5bmQuj1/XFn38TD0UobH5AoDaiEEjnT+UG7EWv9MSKCCGffK9fXKUm
3OunVw+O2tUo7lzW2HJfjoUCKan4cK0AtN+d5SzmJawg8sNdrJE3QLPwAh6JEEgB
jRRQ71acUJZy5i79IBeHEKBeMYV6YyyhHfTpmZBkGxgee7GcFCP90e1qUMlrD028
VlU2Yk5OHl8jNG6xsIhxscA2xwGdo9f+Mr+z1LPb4q8pI0YXQ+AUBMBU6DLyBXLy
JJLxZ71rw0pLZMsR3RucvXXAYQtCdjxHYHIO/LlKVO98yCLIludKzdm2FY/YzUct
k1dl91O/3H9j7lm06J3iH60R07oys2vRTA+4ecViZFGmKbP+gkXympIt9sBIWmm4
qa8MBrY2B4UiACNxoORSlAwHEzbUnEG/h3vLj8yO0NyfLtB4yIayEpYTm6r0fhed
Q1Ef7nAXMeihgguTHGvSmv5HmVTUxT/2nUo51YR8J/5yxik/HdGeAyDmevWvJtl0
YHWNeqJx4t7N7sleE4oArzZoo3fkkCowzmWanY+bYsdze0yZguubvRvg/c6XeHvs
+fdDSsfj1mJjZrvNItpm3VaHyprSZqaCw07FRiiOvSGp/goqwKiZvzmyWzm4Qrbb
mEUPUm00pcgxlYwah17CHDufPnu4itUBczm4tLoDmFTvXdGq+SM=
=jC5l
-----END PGP SIGNATURE-----

--Apple-Mail=_19F54ECE-133B-4B25-83C2-70EEA28844B7--
