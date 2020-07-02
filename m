Return-Path: <SRS0=gkpi=AN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A885C433DF
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 19:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5326D207E8
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 19:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pdinc.us header.i=@pdinc.us header.b="GI4wvDFs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgGBTZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 15:25:58 -0400
Received: from mail2.pdinc.us ([67.90.184.28]:44952 "EHLO mail2.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbgGBTZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 15:25:58 -0400
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id 062JPgBU023617
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Jul 2020 15:25:43 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mail2.pdinc.us 062JPgBU023617
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1593717943; bh=+Y93vHjLCfF8Zjtwb/ieeiBdyb8q+ex79jHf3N5N+eg=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=GI4wvDFsgFhfXyU7k3NeeW9CI9QhnvXeJQd/7viLzjBM+A45H84hQ/58giZGOAKlI
         tSpirvUBTcVHbidqa8qm7UXpsoz2eCjbJTLwOdyfjIez8X5ptHELXaBhmqCP2yB1PC
         NzAXpcefZKN42BrrXOhsm1OT5eCAhOoxU4mxpxE3dQCsdkUlRF2tHuRKHzs4VLEgaz
         7OfdAOP+/WjwWMas5EqGoOiD7mkf+RGf455N5vGpDtJo587KTt5v8ySuAET7zW+7dM
         uqUSdofkxXgUkw6kJ/cg9OwGMaLssjDcBrTm2WAWYTZyRGtvc5sKAWGi9z9TrX3wIl
         ifHphb0iRZyrA==
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Cc:     "'Matthew Horowitz'" <mhorowitz@pdinc.us>,
        "'Jakub Trzebiatowski'" <cubuspl42.1@gmail.com>,
        <paul@mad-scientist.net>
References:     <CAAF2pWYNbZF5fqZVuakTmAguK7End3nFbRgfT=mRXFfmgD9LNA@mail.gmail.com>     <0e9801d6508d$c1f55560$45e00020$@pdinc.us>      <CAAF2pWb8Namk1rpm4==PUrq4ft9fp4eD=t9WyMLv56dPZuGk2g@mail.gmail.com> <03bd4b4e9b172c4ee6cb44653bb9c5b26df76445.camel@mad-scientist.net>
In-Reply-To: <03bd4b4e9b172c4ee6cb44653bb9c5b26df76445.camel@mad-scientist.net>
Subject: RE: Is git compliant with GDPR?
Date:   Thu, 2 Jul 2020 15:25:53 -0400
Organization: PD Inc
Message-ID: <0f0e01d650a6$9a5b5b80$cf121280$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQI3a36ohrugQlw4W93V7edqWZTq6QHTAPwuAc3sm60CTFkf4agDCPng
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Paul Smith=20
> Sent: Thursday, July 2, 2020 2:38 PM
>=20
> On Thu, 2020-07-02 at 19:06 +0200, Jakub Trzebiatowski wrote:
> > But you said that git itself (as a software) doesn't fall under =
GDPR,
> > and that's the only thing I'm not sure about. I was wondering if
> > someone with a deeper understanding of GDPR would tell my _why_.
> > Because when interpreting the law literally, it sounds like it does.
>=20
> You might be interested in reading the conversation that was had on
> this list the last time this subject was raised, in 2018:
>=20
> https://public-inbox.org/git/5587534.o6tcmYBVvN@mfick-lnx/T/
>=20
> I can't say whether it will satisfy you or not.

IMHO the most valuable bits were (I left out the discussion of changes =
to Git):

1:=20

From: David Lang=20
Date: Wed, 6 Jun 2018 18:38:55 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1806061831340.7659@nftneq.ynat.uz> (raw) =
https://public-inbox.org/git/alpine.DEB.2.02.1806061831340.7659@nftneq.yn=
at.uz/#t

I'm going to take the risk of inserting actual real-world data into the =
mix=20
rather than just speculation :-)

Here is an example of that the Rsyslog project is doing (main developers =
based=20
in Germany). I'll say as someone who's day job has been very involved =
with GDPR=20
stuff recently, this looks like a very reasonable statement to me. But I =
am not=20
a lawyer. I will also say that I think it would be very reasonable for =
projects=20
to not accept code from someone who doesn't give them any way to contact =
them=20
later in case there is a question about authorship or licensing.

David Lang


https://github.com/rsyslog/rsyslog/pull/2746/files

LEGAL GDPR NOTICE:
According to the European data protection laws (GDPR), we would like to =
make you
aware that contributing to rsyslog via git will permanently store the
name and email address you provide as well as the actual commit and the
time and date you made it inside git's version history. This is =
inevitable,
because it is a main feature git. If you are concerned about your
privacy, we strongly recommend to use

--author "anonymous <gdpr@example.com>"

together with your commit. Also please do NOT sign your commit in this =
case,
as that potentially could lead back to you. Please note that if you use =
your
real identity, the GDPR grants you the right to have this information =
removed
later. However, we have valid reasons why we cannot remove that =
information
later on. The reasons are:

* this would break git history and make future merges unworkable
* the rsyslog projects has legitimate interest to keep a permanent =
record of the
   contributor identity, once given, for
   - copyright verification
   - being able to provide proof should a malicious commit be made

Please also note that your commit is public and as such will potentially =
be
processed by many third-parties. Git's distributed nature makes it =
impossible
to track where exactly your commit, and thus your personal data, will be =
stored
and be processed. If you would not like to accept this risk, please do =
either
commit anonymously or refrain from contributing to the rsyslog project.

2:

From: "Philip Oakley"
Date: Sun, 3 Jun 2018 23:28:43 +0100
Message-ID: <5F80881E35F941E88D9C84565C437607@PhilipOakley> (raw) =
https://public-inbox.org/git/5F80881E35F941E88D9C84565C437607@PhilipOakle=
y/#t

> On Sun, Jun 03, 2018 at 04:28:31PM +0100, Philip Oakley wrote:
<snip/>
> You provide a lot of arguments about why it is not a necessity to have
> this, but let's assume it is; is there any actual problem you see with
> the proposal, except that someone would have to implement it?

It's the strawman problem. If it was a real 'real issue' then it would =
have=20
already shown up with companies clamouring to pay folk to fix our =
(git's)=20
latest problem. But the haven't, so I think it's a much more balanced =
issue.

