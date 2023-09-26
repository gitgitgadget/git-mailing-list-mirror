Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FA7E7E635
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 13:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbjIZNxd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 09:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjIZNxc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 09:53:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49607AF
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 06:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695736392; x=1696341192; i=johannes.schindelin@gmx.de;
 bh=aDvyaJHuOo+PCGd5MyAcejmqf5kD87Cx27yxRcdJUlA=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=XLT0TedjsD+lesYm+pAiywiQ6VcjRkZ2gmsRGkzBntARMiMjYFOS4UYO20komdtHRiPi2lv02dD
 agY0Rk+KSDzo0JzWOaI//k7oy5vFGNRThHX3YzwIlLpT9r8qFInDidhEU5RpTHLEuhH3jedI3U0aK
 LhEIvt6dB0Jitv6x2PMWk/V/G/a91vTYVQd6yjSzR8mzqBJOsQC5+JinW/1RCFELbvWhuLsc0bzz7
 uVaR9DQjzcQmAniL6oHb4KfROXEMsKLO5Y4U3E17rAfl7mzTRIcVANYunY1GLsBYZC2QwGzP7CRnl
 4fNhyXOTREkiDEsEls1PnYjXIprnFIAlPQNg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.206]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvsIv-1rcYSm43OB-00srcS; Tue, 26
 Sep 2023 15:53:12 +0200
Date:   Tue, 26 Sep 2023 15:53:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     Robert Smith <robsmi_ms@hotmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Request for Curl.exe update included in Git binaries
In-Reply-To: <ZRIBmxT4mh5Rlt3-@tapette.crustytoothpaste.net>
Message-ID: <45a55b80-1a58-7a7a-bed2-250cf7b55f99@gmx.de>
References: <IA1PR02MB9088F7E0AB55FE03CF0C38B186FCA@IA1PR02MB9088.namprd02.prod.outlook.com> <ZRIBmxT4mh5Rlt3-@tapette.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+OczeoN996gKskJkjw52cMDXYUWQmjE243SUo0eW3ACAab96b69
 bAahL2iX+FhRXwRfMY9fRyH3e/0UhiDmnEFzip9Z878evKJs7hcndILzudMP3gGYNfsBIxP
 FD1Zlffjoj/q1y8ABg/itP7N9SPNjMByo675nxZ4QCBH4dYQ2Nog7FOJ74v2itu+SAkYjaP
 teUswgY9mGw9lFk46I53g==
UI-OutboundReport: notjunk:1;M01:P0:wUoNXwKhEY0=;lue44UQjAewSV7UFqCBuAHOqN3H
 pSMd52gbs1/m8ETgiQ1Z3RXYPJDpq7aG18g3Rgg/sXYKofMMhNCpdWSuIdUiuCcmCkMwKuIUI
 9nXcbqS060s3/hgX99lWte3QfdQBmEH2goDiavQH/0Rza+Apw5wDVXoyfKvTO47KYk6ybG8SN
 EoMQ0aUxm5RQXDdQBdDONyz+W5mMsrMdEJvwE+mVQDliEzkeS6DshmyIrtfq0Ke1jZtw1kwTU
 4ryd1m8oqlF/p+9+znRRwihYRB8GrMl9ypN37InrSZCpIt2qfeE+qe8jN0yG/OIYZovg3g2u1
 vCHDSZC4Tp3PUhnbKShGEikFNeISACaNYPHHWHnT77FJ4GhGmyATueRZwShI4CS7TMn4fjMeq
 n5TseA9yMiK4ZbOiEGr3MMqruwCelX315m3i4j8/Rn/SXXycGOJBsbdPDZSTPHg+6lBe0nqeC
 bxISsbPwXpDfi6slftPbcRurPffwHPHMN4KnE7Qw6TPtLmF947BbGsVBDQSEPumkuE0nC427k
 bfqBZMnFe/OptfxGglRQ/jed31FOuHmBIKgoelvZG097MwW+FlH3RT7fDe5UBr5icdACjFWC3
 wQZXRRpVpLJJjAJ1gNJBOAYof/NZkiJX1juxeOJFhQwfbFm+uAxNvhPRk6bYBBK7/9t6KgZ4W
 bJB/+y1r4wlzlTkI944xtz31cVMspTz9KypD3sNfVKBtSrVpWr/ur4KQjuJnOEyoItxeTBNO0
 lUlbKv/bnstRouJkNo02KwZdbC+Rjp3NGmAuOT7N2EjcnJGQCxnc0NzSQKpDtBBXXCrgQcLDz
 2OnBKOa6oPm6faFF/csYbs0XsqTaEITSO29Ay/DPjFyK7f+q9yD6yB3Cl3Y4VDhlMgD0bt5L6
 h7ZFjIOAKjge5snRX7/b1Chq9qACB0zWnazLcYGmNsLh8ImRdL3zgD8n8gBE2OyHfdWJCUcRX
 p4VgYA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian and Robert,

On Mon, 25 Sep 2023, brian m. carlson wrote:

> On 2023-09-25 at 15:37:46, Robert Smith wrote:
>
> > Regarding this CVE:
> >
> > https://curl.se/docs/CVE-2023-38039.html

In the future, please consider sending security-relevant enquiries to
git-security@googlegroups.com instead of the regular Git mailing list.

In this case, not much harm was done, but let's not risk anything. I say
not much harm was done because that CVE would appear to be very low risk.
The cURL project itself says this:

	When curl retrieves an HTTP response, it stores the incoming
	headers so that they can be accessed later via the libcurl headers
	API.

	However, curl did not have a limit on the size or quantity of
	headers it would accept in a response, allowing a malicious server
	to stream an endless series of headers to a client and eventually
	cause curl to run out of heap memory.

So the most damage that can be done by exploiting this vulnerability is to
host a Git server from which a user targeted by the attack simply cannot
clone because the process will fail with an out-of-memory condition.

The Git for Windows project carefully vets any security updates of any of
the components distributed with Git for Windows, and if it is determined
that they constitute a vulnerability that can be exploited via regular Git
usage, we aim to release a new version as swiftly as possible.

In this instance, it was determined that the severity is low (deviating
from cURL's assessment because Git's usage of libcurl has a narrower focus
than general cURL usage), and no new Git for Windows version was deemed
necessary.

> > Is there any plan to update Git for Windows to include the updated
> > 8.3.0 Curl binaries?

Ever since https://github.com/git-for-windows/git/issues/4605 was
addressed, the v8.3.0 cURL binaries have been ready to go for the next Git
for Windows version.

> The Git project doesn't ship any binaries at all, and we don't ship
> curl.  Git for Windows does ship a substantial amount of other software,
> including curl.  You can find their issue tracker at
> https://github.com/git-for-windows/git/issues, but I believe this has
> already been fixed in https://github.com/git-for-windows/git/issues/4605
> and will be included in the next version.

Precisely.

> I'm not certain about their release policy,

Git for Windows' release policy is documented at
https://github.com/git-for-windows/git/security/policy.

> but I seem to recall that they don't issue updates for dependent
> packages until a new release would normally be done.  To be certain,
> you'd have to inquire with them.

Git for Windows does follow "upstream" Git releases. That is, every
official Git version on the latest major version release train is followed
shortly thereafter with a corresponding Git for Windows version.

As documented at
https://github.com/git-for-windows/git/security/policy#version-number-sche=
me
sometimes Git for Windows releases versions that do _not_ correspond to
upstream Git versions. Reasons for that include security bug fixes in
dependencies that affect Git usage, and bug fixes that are specific to Git
for Windows which are considered important enough to deliver to Git for
Windows users as quickly as possible.

In this instance, I do not see any reason to risk upgrade fatigue and
expect to publish the first Git for Windows version that includes cURL
v8.3.0 in the wake of Git v2.43.0 (slated for November 20th, 2023, see
https://gh.io/gitCal).

Robert, if you still feel very strongly that you need to have a Git for
Windows that includes an updated `curl.exe`, I invite you to install the
latest snapshot at https://wingit.blob.core.windows.net/files/index.html.
These snapshots are designed to be as robust and dependable as full Git
for Windows releases, the only difference being that snapshots are
released with every update to Git for Windows' `main` branch, i.e. at a
much faster cadence than official Git for Windows versions.

Ciao,
Johannes
