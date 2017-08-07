Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B2DB2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 23:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751919AbdHGXUc (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 19:20:32 -0400
Received: from smtp74.ord1c.emailsrvr.com ([108.166.43.74]:38321 "EHLO
        smtp74.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751881AbdHGXUb (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 7 Aug 2017 19:20:31 -0400
Received: from smtp18.relay.ord1c.emailsrvr.com (localhost [127.0.0.1])
        by smtp18.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 0E91BE01ED;
        Mon,  7 Aug 2017 19:20:31 -0400 (EDT)
X-SMTPDoctor-Processed: csmtpprox beta
Received: from smtp18.relay.ord1c.emailsrvr.com (localhost [127.0.0.1])
        by smtp18.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 0A14BE046E;
        Mon,  7 Aug 2017 19:20:31 -0400 (EDT)
Received: from smtp192.mex09.emailsrvr.com (unknown [184.106.73.70])
        by smtp18.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTPS id D4931E01ED;
        Mon,  7 Aug 2017 19:20:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=statseeker.com;
        s=20170629-l0wbkvum; t=1502148030;
        bh=uNlNlE9N4BmoYcwid2c8p4u1+daghdWozHcXGoYUjQE=;
        h=From:To:Subject:Date:From;
        b=V1Vqx/Sc/+eynrPqo6O40XF6MzZkoVNYTRWLaQbajWZCJ87YluwIHIASdcU10UZzi
         Xtt+/6sVzfD0kHyLEkoZkTOhVvA3MGKb/YVNpfOhmfKMS19VzmV26QQsbs/F28AiS2
         DtmBIqiQSlghh+wP+1wzgJEWTynjCAx9anncNkF4=
X-Sender-Id: james.wells@statseeker.com
Received: from smtp192.mex09.emailsrvr.com ([UNAVAILABLE]. [184.106.73.70])
        (using TLSv1.2 with cipher AES256-SHA256)
        by 0.0.0.0:25 (trex/5.7.12);
        Mon, 07 Aug 2017 19:20:30 -0400
Received: from MBX04D-ORD1.mex09.mlsrvr.com (172.29.128.30) by
 MBX04C-ORD1.mex09.mlsrvr.com (172.29.128.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Mon, 7 Aug 2017 18:20:30 -0500
Received: from MBX04D-ORD1.mex09.mlsrvr.com ([fe80::40b3:1086:160a:405e]) by
 MBX04D-ORD1.mex09.mlsrvr.com ([fe80::40b3:1086:160a:405e%21]) with mapi id
 15.01.0669.032; Mon, 7 Aug 2017 18:20:30 -0500
From:   James Wells <james.wells@statseeker.com>
To:     Todd Zullinger <tmz@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: upgarding GIT
Thread-Topic: upgarding GIT
Thread-Index: AdMPQ2NPbrFDYd5KTIq487yWwoqxggAVCqkAAAyCtYAAAevSUA==
Date:   Mon, 7 Aug 2017 23:20:30 +0000
Message-ID: <f5d92196d19a4029bb4e282837c53a46@statseeker.com>
References: <9a2576ed8b7146459585af4238613286@statseeker.com>
 <871sonzlar.fsf@gmail.com> <20170807170745.GG25542@zaya.teonanacatl.net>
In-Reply-To: <20170807170745.GG25542@zaya.teonanacatl.net>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [14.203.103.145]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Todd

Thanks for replying, below is my current install information

Current ( STASH and GIT are installed on the same server ):

STASH ( BitBucket ) =3D 3.9.2
Git =3D 2.0.4 ( installed from tar Ball and not from an RPM as the RPM was =
too old.
Centos =3D 6.6

Required:

BitBucket =3D 5.2
Git =3D 2.2 + and above

https://confluence.atlassian.com/bitbucketserver/supported-platforms-776640=
981.html

As you can see my version of git is not supported with the current version =
of bitbucket. I will have to perform a two stage upgrade anyway as the vers=
ion of STASH I am running cannot be upgraded directly to bitbucket 5.2 as w=
ell.

Is there an easy way just to install a higher support version of git like 2=
.9 on the same server and then move all the repos and basically everything =
across. Can you install another TAR ball later version on top of another gi=
t , so it's like overwriting it.=20


Kind regards,

James Wells | Operations and Regional Account Manager ANZ=A0=A0=A0=A0=A0=A0=
=A0=20

www.statseeker.com

This email is intended only for the entity or individual to whom it is addr=
essed and may contain information that is privileged or confidential.=A0If =
you are not the intended recipient, you are hereby notified that distributi=
on, copying or any form of dissemination of the content of this email is st=
rictly prohibited.=A0If you have received this email in error, please advis=
e us immediately by return email and destroy the original message. Thank yo=
u.


-----Original Message-----
From: Todd Zullinger [mailto:todd.zullinger@gmail.com] On Behalf Of Todd Zu=
llinger
Sent: Tuesday, 8 August 2017 3:08 AM
To: =C6var Arnfj=F6r=F0 Bjarmason
Cc: James Wells; git@vger.kernel.org
Subject: Re: upgarding GIT

=C6var Arnfj=F6r=F0 Bjarmason wrote:
> On Mon, Aug 07 2017, James Wells jotted:
>> I am fairly new to git, however I have a challenge of upgrading git=20
>> from 2.0.4 to 2.4.12 and my initial 2.0.4 install was done via TAR=20
>> BALL on my server.
>>
>> I have a centos server running git and Atlassian STASH and my=20
>> challenge is for me to upgrade the STASH application I need to move=20
>> to a newer version of git.

Which release of CentOS are you using James?  And what git version is requi=
red for the Atlassian Stash (which is now called Bitbucket) release you're =
trying to use?  IIRC, they support as far back as git 1.8?

> You're going to want to install git via RPM/yum. CentOS already has a=20
> package for it.

Indeed.  (But I'm biased because I would never, ever install software via '=
sudo make install' on anything other than a throw-away test
instance.)

The one problem folks run into on CentOS/RHEL is that the versions may be s=
omewhat old.  CentOS/RHEL 6 ships with git 1.7.1, for instance.=20
CentOS/RHEL 7 is only a little newer, with git 1.8.3.  There are "software =
collections" which provide git 1.9=B9 and 2.9=B2, but personally I've never=
 liked using software collections for software that I need to integrate wit=
h other tools.

For users of CentOS/RHEL who want to run the current git release in a packa=
ged form, the Fedora git package maintainers take care to ensure that the F=
edora packages can be built for the current supported releases of CentOS/RH=
EL (6 & 7 at the moment).  Grabbing the current code and/or srpm from Fedor=
a should (almost=B3) always build cleanly using the mock build tool for Cen=
tOS/RHEL.

I also try to keep a semi-official COPR repo up to date, here:

    https://copr.fedorainfracloud.org/coprs/g/git-maint/git/

(Even as the primary maintainer of that repo, I'd still suggest that it's w=
ise to either mirror it locally or rebuild the srpm's in your own infrastru=
cture, to ensure that if the copr service is ever down you can reinstall im=
portant systems.)

=B9 https://www.softwarecollections.org/en/scls/rhscl/git19/
=B2 https://www.softwarecollections.org/en/scls/rhscl/rh-git29/
=B3 Right now, there's a slight issue building the current git for
  CentOS 7 because RHEL 7.4 moved the pcre2 package from EPEL into
  RHEL and CentOS 7.4 is not yet built.  The Fedora packages are
  built against pcre2 now (thanks =C6var ;).  So for a few weeks it
  won't be possible to build them for CentOS 7 without a minor change.

--=20
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Ocean, n. A body of water occupying about two-thirds of a world made
for man -- who has no gills.
    -- Ambrose Bierce, "The Devil's Dictionary"

