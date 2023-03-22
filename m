Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE029C6FD1C
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 17:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCVR36 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 13:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCVR35 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 13:29:57 -0400
Received: from qs51p00im-qukt01080101.me.com (qs51p00im-qukt01080101.me.com [17.57.155.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24982132D3
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 10:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mac.com; s=1a1hai;
        t=1679506195; bh=xue8mefLWba9qpm/G7HMu5Fx8x1A05Fu3NubHzDsbRU=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=G5z8gz1ekmXiBGqKkO1MzMN/c6GSgZ42FHFaWwIncpRj4oqr+l/OPBGumHssO9cO0
         Uuf6rWL31pWX0NU+vwquPzrEr9TBrzl6Ck94oIURaEMn7Au97l16iejA2N9U1U4MK1
         jFCIjJlBLNr7y2NvTfNOnEqJRVz3tFJ7ep2vo2sMoIc5E/EQcQRCC0n9n6A6SCcI/k
         PxBKZqEMfpqFxmAfR9YFfqcmbBlShzKxvS93dPoVz+X7CwUZtVTN0GlhMA+KxSfQXh
         QoFxBwD87yPT/125RmLoEIGz86NovpxpSpiR826s2ZhaSwQ/6m0QNzOtQrSu6uFEax
         F6VPUdMBKQyfg==
Received: from smtpclient.apple (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01080101.me.com (Postfix) with ESMTPSA id D8FA76180349;
        Wed, 22 Mar 2023 17:29:54 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: BUGREPORT: Modified files on a fresh clone on M2 MacBook Pro
From:   Sjur Moshagen <sjurnm@mac.com>
In-Reply-To: <CAJoAoZkKTGzgVyL2wM9a4VcFObx4YpjMSatH9Bpqcgyi=zzBrQ@mail.gmail.com>
Date:   Wed, 22 Mar 2023 18:29:42 +0100
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3FC6072C-5856-437F-9B4F-BC182921426D@mac.com>
References: <593742E7-F0FC-471C-AFF5-1E855A3788B0@mac.com>
 <CAJoAoZkKTGzgVyL2wM9a4VcFObx4YpjMSatH9Bpqcgyi=zzBrQ@mail.gmail.com>
To:     Emily Shaffer <nasamuffin@google.com>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Proofpoint-GUID: _5vq-5F5ejKvLIXqhBRRBygLMbXtSXLI
X-Proofpoint-ORIG-GUID: _5vq-5F5ejKvLIXqhBRRBygLMbXtSXLI
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.790,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-12=5F02:2020-02-14=5F02,2022-01-12=5F02,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1011 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2303220123
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

22.3.2023 kl. 17:46 skrev Emily Shaffer <nasamuffin@google.com>:
>=20
> On Wed, Mar 22, 2023 at 9:38=E2=80=AFAM Sjur Moshagen <sjurnm@mac.com> =
wrote:
>>=20
>> Thank you for filling out a Git bug report!
>> Please answer the following questions to help us understand your =
issue.
>>=20
>> What did you do before the bug happened? (Steps to reproduce your =
issue)
>> git clone https://github.com/giellalt/lang-sma
>>=20
>> What did you expect to happen? (Expected behavior)
>> Clone to be clean, as reported by git status
>>=20
>> What happened instead? (Actual behavior)
>> git status reported four changed files
>=20
> It would help to know which files, or what the difference was, so we
> have a chance to figure out what happens without having to go and buy
> a Macbook :)

Yes, of course :)

It only happens with binary files (.docx and .pdf files), which got me =
suspicious. It turned out that updating the .gitattributes file fixed =
the issue, cf

=
https://github.com/giellalt/lang-sma/commit/fb5b56fa9fa7f25be1a1d7190bbb4d=
12b5a908fd#diff-618cd5b83d62060ba3d027e314a21ceaf75d36067ff820db1266429441=
45393e

What is still a mystery to me is that there has been no issues with =
cloning files on Intel Macs (git version 2.39.2), or on Linux (git =
version 2.34.1), even with the old .gitattributes file - ie the cloned =
repos were clean on these systems. Only on M2 (possibly also M1) Macs =
did this issue pop up.

Please tell me if there is more I can do to help.

Regards,
Sjur

