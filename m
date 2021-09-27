Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A03C433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 13:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D143C60230
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 13:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbhI0NiQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 09:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234487AbhI0NiP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 09:38:15 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9101C061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 06:36:37 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d6so51857648wrc.11
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 06:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=5pzddiYO2NHNNOFUflWeBY4lqPmaYpANvWDz4PRtx0A=;
        b=PaHQ2UVVS98kwbwC9JO+v5+ZF4X7l4n+W9jMYfDzssVqLB0fZkQk7lAjWmIz9dno2O
         /n3ocCYPDZrGqpFjNNWui35j3AU3lNY4NyobE7yPBT39V4G5LCXvb0sWSznryqmW5MYH
         QBLK/sBMfDyCA8DurUPfK/V10PBQndObDiMRY2q+NE4sGlpW3mAH5lEqTl2lNDaN1Rx+
         xHBeobNKWqxjUpYdy1W0u49vjqiHeIcw9UP74ZpfeseUqzRxuOUps3a/gdaLhvlymLwi
         UVl5/z1GcxCzSpype5LIp2GHuSS9P/ovkZeGzJVxKYAWKIaOII3vQ8lQSKHZz5Q2CdfQ
         cWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=5pzddiYO2NHNNOFUflWeBY4lqPmaYpANvWDz4PRtx0A=;
        b=jBZrUvVfENkWDbplYeLQx/nh8cc7RuqLMgQPvJV/7sssf0WIAnCa34lIqKYT8JbOnh
         ZE1z5rJo1WMyeU+eaT8/Zog7O3ryz2fIB+ERbHEIXXo72TD82Psrx36nLLfO/EBTGNQi
         ftjXXGMzNN0cgFUnZ55K27tN212mCQUyqVoymIrvDl7BJ6Ll/bOGywrKWFv2sX7zKQ6n
         8AHHVQEpqnXnSMpN8RX1VAelgEE61c4/hu6sfss6plsVsayeSGeWnMevSJhtBrmXkE7H
         PJuIo4p7PZtpq76FbBaF+k+B0zRR9C/vHhWNMlAuUmqzInyiG9JRpuBrcjZfbsZek17b
         wCEw==
X-Gm-Message-State: AOAM533NyTO+7rfFBetCv5W0/hEl9ODQRQR72bJZspL1W+EppPDuH/oC
        p00iH4Rj4PV/HSWCAAR2d9ahxy6uRyN5a49vmqilhgrc
X-Google-Smtp-Source: ABdhPJwKspcQh9PgOutClFI5uwA/RUZEJVDA7vAKWB0LIXr+xnCkFsbTqF+esPsctbKmhPn1avw4UuMw7Mz8XlP/qZ4=
X-Received: by 2002:adf:e44f:: with SMTP id t15mr28569224wrm.394.1632749796077;
 Mon, 27 Sep 2021 06:36:36 -0700 (PDT)
MIME-Version: 1.0
From:   Calvin Taylor <coolcatt@gmail.com>
Date:   Mon, 27 Sep 2021 10:36:24 -0300
Message-ID: <CAP9BFHVdg_BWZ2wvdv8t-mN3WKjW4fA+v2181WRYQGsrgmvKmA@mail.gmail.com>
Subject: Bug Report: git ls-files -d
To:     git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000009a4a5d05ccfa2f2f"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--0000000000009a4a5d05ccfa2f2f
Content-Type: text/plain; charset="UTF-8"

-- 

Calvin Taylor
506 260-2866

--0000000000009a4a5d05ccfa2f2f
Content-Type: text/plain; charset="US-ASCII"; name="git-bugreport-2021-09-27-0939.txt"
Content-Disposition: attachment; 
	filename="git-bugreport-2021-09-27-0939.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_ku2p1pkr0>
X-Attachment-Id: f_ku2p1pkr0

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQpQbGVhc2UgYW5zd2Vy
IHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zIHRvIGhlbHAgdXMgdW5kZXJzdGFuZCB5b3VyIGlzc3Vl
LgoKV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8gcmVw
cm9kdWNlIHlvdXIgaXNzdWUpCiBoYXZlIG1hY29zIGFuZCBJIGhhdmUgc29tZSBjb21tYW5kcyBw
b3NzaWJseSByZW1hcHBlZCBsaWtlIGdzZWQsIGdmaW5kIHRvIHNlZCwgZmluZAoKV2hhdCBkaWQg
eW91IGV4cGVjdCB0byBoYXBwZW4/IChFeHBlY3RlZCBiZWhhdmlvcikKZ2l0IGxzLWZpbGVzIC1k
IHRvIHNob3cgZGVsZXRlZCBmaWxlcyBpbiBteSByZXBvc2l0b3J5CgpXaGF0IGhhcHBlbmVkIGlu
c3RlYWQ/IChBY3R1YWwgYmVoYXZpb3IpCm5vdGhpbmcgaXMgc2hvd24sIEkgZW5hYmxlZCBHSVRf
VFJBQ0U9MSwgYW5kIHN0YXJ0ZWQgYmFzaCBpbmNhc2Ugb2gtbXktenNoIG1pZ2h0IGhhdmUgYmVl
biBpbnRlcmZlcmVpbmcsIGFuZCBnb3Qgc2ltaWxhciByZXN1bHRzCgokIGdpdCBscy1maWxlcyAt
ZAowOTo0Mjo0Ny42OTI4ODAgZXhlYy1jbWQuYzoxMzkgICAgICAgICAgdHJhY2U6IHJlc29sdmVk
IGV4ZWN1dGFibGUgcGF0aCBmcm9tIERhcndpbiBzdGFjazogL0xpYnJhcnkvRGV2ZWxvcGVyL0Nv
bW1hbmRMaW5lVG9vbHMvdXNyL2Jpbi9naXQKMDk6NDI6NDcuNjkzNTkxIGV4ZWMtY21kLmM6MjM4
ICAgICAgICAgIHRyYWNlOiByZXNvbHZlZCBleGVjdXRhYmxlIGRpcjogL0xpYnJhcnkvRGV2ZWxv
cGVyL0NvbW1hbmRMaW5lVG9vbHMvdXNyL2JpbgowOTo0Mjo0Ny42OTUwNTMgZ2l0LmM6NDQ0ICAg
ICAgICAgICAgICAgdHJhY2U6IGJ1aWx0LWluOiBnaXQgbHMtZmlsZXMgLWQKMDk6NDI6NDcuNzY0
MDg5IGV4ZWMtY21kLmM6MTM5ICAgICAgICAgIHRyYWNlOiByZXNvbHZlZCBleGVjdXRhYmxlIHBh
dGggZnJvbSBEYXJ3aW4gc3RhY2s6IC9MaWJyYXJ5L0RldmVsb3Blci9Db21tYW5kTGluZVRvb2xz
L3Vzci9iaW4vZ2l0CjA5OjQyOjQ3Ljc2NDkyMSBleGVjLWNtZC5jOjIzOCAgICAgICAgICB0cmFj
ZTogcmVzb2x2ZWQgZXhlY3V0YWJsZSBkaXI6IC9MaWJyYXJ5L0RldmVsb3Blci9Db21tYW5kTGlu
ZVRvb2xzL3Vzci9iaW4KMDk6NDI6NDcuNzY1OTE5IGdpdC5jOjQ0NCAgICAgICAgICAgICAgIHRy
YWNlOiBidWlsdC1pbjogZ2l0IGNvbmZpZyAtLWdldCBvaC1teS16c2guaGlkZS1kaXJ0eQoKV2hh
dCdzIGRpZmZlcmVudCBiZXR3ZWVuIHdoYXQgeW91IGV4cGVjdGVkIGFuZCB3aGF0IGFjdHVhbGx5
IGhhcHBlbmVkPwpJIGhhdmUgc2V2ZXJhbCBkaXJlY3RvcmllcyBJJ2QgbGlrZSB0byBkZWxldGUg
dGVtcG9yYXJpbHkgc28gSSBjYW4gc2ltcGxpZnkgYW5kIHN0dWR5IGJ1aWxkIHByb2Nlc3NlcwoK
QW55dGhpbmcgZWxzZSB5b3Ugd2FudCB0byBhZGQ6CgpQbGVhc2UgcmV2aWV3IHRoZSByZXN0IG9m
IHRoZSBidWcgcmVwb3J0IGJlbG93LgpZb3UgY2FuIGRlbGV0ZSBhbnkgbGluZXMgeW91IGRvbid0
IHdpc2ggdG8gc2hhcmUuCgoKW1N5c3RlbSBJbmZvXQpnaXQgdmVyc2lvbjoKZ2l0IHZlcnNpb24g
Mi4zMC4xIChBcHBsZSBHaXQtMTMwKQpjcHU6IHg4Nl82NApubyBjb21taXQgYXNzb2NpYXRlZCB3
aXRoIHRoaXMgYnVpbGQKc2l6ZW9mLWxvbmc6IDgKc2l6ZW9mLXNpemVfdDogOApzaGVsbC1wYXRo
OiAvYmluL3NoCnVuYW1lOiBEYXJ3aW4gMjAuNi4wIERhcndpbiBLZXJuZWwgVmVyc2lvbiAyMC42
LjA6IE1vbiBBdWcgMzAgMDY6MTI6MjEgUERUIDIwMjE7IHJvb3Q6eG51LTcxOTUuMTQxLjZ+My9S
RUxFQVNFX1g4Nl82NCB4ODZfNjQKY29tcGlsZXIgaW5mbzogY2xhbmc6IDEyLjAuNSAoY2xhbmct
MTIwNS4wLjIyLjYpCmxpYmMgaW5mbzogbm8gbGliYyBpbmZvcm1hdGlvbiBhdmFpbGFibGUKJFNI
RUxMICh0eXBpY2FsbHksIGludGVyYWN0aXZlIHNoZWxsKTogL2Jpbi96c2gKCgpbRW5hYmxlZCBI
b29rc10K
--0000000000009a4a5d05ccfa2f2f--
