Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043DAC55178
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 12:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9526921734
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 12:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="MjnT5Ylq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbgKDMUA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 07:20:00 -0500
Received: from st43p00im-ztbu10063601.me.com ([17.58.63.174]:41217 "EHLO
        st43p00im-ztbu10063601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728645AbgKDMUA (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 4 Nov 2020 07:20:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1604492398; bh=985D8fqSDHACorunSlq2zbklrpieIsO/xrM1UBRzDt0=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=MjnT5YlqJO4pMxvkokTGgzgFexJN2GALLG4JHBYN7Dubmy39JvPZZSO9i/5mWt07k
         lr6S0yXOYW/eDhFv1ppoui54xrPLLikg3yF7M3+Fj4itM5Xi5yvg3RbhMJ8qNJq/gN
         UWecREOPmZmOyRZj9p7yO1eBXUJvu/0G4H3P4wd5t5pQTB1+4qtEvUqWTJpTEcBRgQ
         NdUHwGhPEiMchAynN1jiC9iuFChfPVFk/YL9T4gWVMpWamcZxgkAa6huzVfOOwZZx/
         2k0vr40fN6/zXo8kTTGok3AdyVou4TjnQvQJRk/8xGsA/OzYpsE0kHnCa+IqcNBIQS
         LKsiXlZ/zvVUA==
Received: from [192.168.0.121] (ip98-169-36-218.dc.dc.cox.net [98.169.36.218])
        by st43p00im-ztbu10063601.me.com (Postfix) with ESMTPSA id 6044F70086B;
        Wed,  4 Nov 2020 12:19:58 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: Git Help
From:   Joe Fabre <joefabre@me.com>
In-Reply-To: <CAH5451kZYL0LsXqVUxJhAA7iQ7GWS5zic5Z1jX_CbCjZWSGW1Q@mail.gmail.com>
Date:   Wed, 4 Nov 2020 07:19:57 -0500
Cc:     git <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5D4B5539-DAC4-44FF-9EEB-BB790953200C@me.com>
References: <46BA69FB-B082-4575-ACF1-DC959527558E@me.com>
 <CAH5451kZYL0LsXqVUxJhAA7iQ7GWS5zic5Z1jX_CbCjZWSGW1Q@mail.gmail.com>
To:     Andrew Ardill <andrew.ardill@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-04_08:2020-11-04,2020-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2011040093
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

HI Andrew,

Your assessment and advice was exact.  I found this out through trial =
and =E2=80=9Cno error=E2=80=9D (thank goodness).  The discovery came by =
accident.  I installed iTerm2 and had it themed, and again by accident, =
so that when in a .git folder the terminal indicated =E2=80=9Cmaster=E2=80=
=9D.  I then tested out if I could make changes and push to GitHub from =
my remote computer(S).  Success!

Thank you for your response!

GIT=E2=80=99fully,
Joe

> On Nov 4, 2020, at 6:45 AM, Andrew Ardill <andrew.ardill@gmail.com> =
wrote:
>=20
> On Tue, 3 Nov 2020 at 04:37, Joe Fabre <joefabre@me.com> wrote:
>>=20
>> Hi Git!
>=20
> Hi!
>=20
>> I need some serious assistance.  I have a local repository on my =
primary laptop, and that repo folder is shared on the local network. The =
primary laptop died (grrr); and I want to create a repo on my back up =
laptop which has access to the shared folder, but no .git file.  Also, =
I=E2=80=99d like to link it to my GitHub account.
>>=20
>> Any ideas?
>=20
> Where was the .git folder located for this repository? Typically it is
> a subfolder of your repo.
>=20
> If it was, it will be on the local network share, and the repo should
> be intact. Install git is on the backup laptop and try to access the
> repo like normal.
>=20
> If the .git folder was not stored there, or for some other reason has
> not been synced to the network share, it may be lost. In that case you
> will have lost the history of your repo, but not the latest workstate
> that was checked out.
>=20
> There are lots of guides on how to upload your repository to github -
> here is one, many more can be easily found by searching:
> =
https://www.techrepublic.com/article/how-to-push-a-new-project-to-github/
>=20
> If your existing repository is still intact you can start from the
> 'adding a remote' step.
>=20
> Hope that helps!
>=20
> Andrew Ardill

