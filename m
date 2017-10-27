Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EF1E2055E
	for <e@80x24.org>; Fri, 27 Oct 2017 07:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751988AbdJ0HRN (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 03:17:13 -0400
Received: from smtpoutz11.laposte.net ([194.117.213.174]:54231 "EHLO
        smtp.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751072AbdJ0HRG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 03:17:06 -0400
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout003 (Postfix) with ESMTP id 49B9243203CC
        for <git@vger.kernel.org>; Fri, 27 Oct 2017 09:17:04 +0200 (CEST)
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout003 (Postfix) with ESMTP id 3DE3643203C3
        for <git@vger.kernel.org>; Fri, 27 Oct 2017 09:17:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=laposte.net; s=mail0;
        t=1509088622; bh=KvmBY+KF6wgkgHNnvymerpAuNEdRGoq4rvslpsmQgiU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject;
        b=T/hn7YO8IFMJgxfoeE/h0ZLAGFMl99LIzTbxJEcl0NRtWog+tLcs0bngKLIM7toJr
         e+bkWAHMOhtaN5vxINhgx3NxexeT7m07ckK1K+0Di9R8COxhaW313ou+upIw4D+SVl
         CyLvBGNNBmJ5vRR8MjlWn2gaSH4ZklW3f5uF64GhxU8KGUWmVg6YmtKHluQHvbGtFp
         g9CSC2Gb2g64ZWsb9wJjdq6HHBDB7zM6I7sp48h6uv5PkrtDX9wTdEbf2Pj9Ep9X8j
         DmBa6cctIVHvJ5vbjRwjiED6cXj/1ZW7U/wYJ4GTHdLrHk84gjBDiSAiFQQsgIZ6m1
         XbGXCbb3CjZzw==
Received: from lpn-prd-mstr088.laposte (lpn-prd-mstr088 [10.128.59.114])
        by lpn-prd-vrout003 (Postfix) with ESMTP id 9CBE643203AB;
        Fri, 27 Oct 2017 09:16:57 +0200 (CEST)
Date:   Fri, 27 Oct 2017 09:16:57 +0200 (CEST)
From:   nicolas.mailhot@laposte.net
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Message-ID: <2143560244.170063.1509088617483.JavaMail.zimbra@laposte.net>
In-Reply-To: <7DC2A15E-0B47-4398-8B62-DC39C5EA1343@gmail.com>
References: <2089146798.216127.1508487262593.JavaMail.zimbra@laposte.net> <1290947539.4254.1508496039812.JavaMail.zimbra@laposte.net> <CAGZ79kYRq4OugvTfb2WNdk-M5DMAZC0JpJHqC1KSeJY2eNN1=Q@mail.gmail.com> <1760206035.56692.1508594211365.JavaMail.zimbra@laposte.net> <7DC2A15E-0B47-4398-8B62-DC39C5EA1343@gmail.com>
Subject: Re: [RFE] Add minimal universal release management capabilities to
 GIT
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [192.196.142.67]
X-Mailer: Zimbra 8.0.6_GA_5922 (ZimbraWebClient - FF57 (Win)/La Poste)
Thread-Topic: Add minimal universal release management capabilities to GIT
Thread-Index: g1heRbNIxt9f90kXtzaTKBpZHxFhiA==
X-VR-SrcIP: [192.196.142.67]
X-VR-FullState: 0
X-VR-Score: -100
X-VR-Cause-1: gggruggvucftvghtrhhoucdtuddrgedttddrfeefgdduudeiucetufdoteggodetrfdotffvucfrrhho
X-VR-Cause-2: fhhilhgvmecunfetrffquffvgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhht
X-VR-Cause-3: shculddquddttddmnecujfgurhepfffhvffkjghfufggtgfgihfothesthhqtgdtredtjeenucfhrhho
X-VR-Cause-4: mhepnhhitgholhgrshdrmhgrihhlhhhotheslhgrphhoshhtvgdrnhgvthenucfkphepuddtrdduvdek
X-VR-Cause-5: rdehledruddugedpudelvddrudeliedrudegvddrieejnecurfgrrhgrmhepmhhouggvpehsmhhtphho
X-VR-Cause-6: uhhtpdhhvghloheplhhpnhdqphhrugdqmhhsthhrtdekkedrlhgrphhoshhtvgdpihhnvghtpedutddr
X-VR-Cause-7: uddvkedrheelrdduudegpdhmrghilhhfrhhomhepnhhitgholhgrshdrmhgrihhlhhhotheslhgrphho
X-VR-Cause-8: shhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-VR-AvState: No
X-VR-State: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



----- Mail original -----
De: "Jacob Keller"=20

Hi Jacob,


> I think that this could easily be built by a separate script which provid=
es git release command line and uses tags under the hood in a=20
> well formed way.

True, the difficulty is not technical, the whole scheme is basic and KISS.

> I wouldn't say that the method outlined here works for all projects but I=
 do agree it's fairly common and could work for many projects

I would be very surprised if there was a strong technical reason that stopp=
ed any project from adopting this scheme. Like I already wrote, Linux packa=
ging tools work by converting public release naming to this scheme (with so=
me additional twists, mostly there to help conversion of terminally broken,=
 tooling-hostile and usually legacy projects, not worth the pain to import =
in new tooling).

> I think most large projects already use annotated tags and tho they have =
their own format it works pretty well.=20

Raw tags are useless as release ids for tooling so everyone is forced to in=
vent something else as soon as the project complexity passes a threshold (t=
hat's the point were there is no choice but to redefine tags, not the point=
 were it starts being useful). I've already detailed why their laxity makes=
 them useless.

> Showing a tool that could help projects create more standardized release =
tags would be helpful.
>=20
> I think such a tool could already be built, scripted to create annotated =
tags with a well formed name. I don't think you necessarily
> need to have this in core git, tho I do see that your main goal is to pig=
gyback on git itselfs popularity

I see little hope for such a tool. Reimplementation is too trivial and conv=
ention drift only starts to be acutely painful past a certain size. At that=
 size you're almost certain to have already started using a custom implemen=
tation, with refactoring costs impeding switching to a generic tool.

Basically, it can only be done with a good probability of success by piggyb=
acking on something that already federates a large number of Git users:
=E2=80=93 Git itself, which is the correct most productive and least painfu=
l place for everyone involved
=E2=80=93 one of the big Git-based forges, ie GitHub or GitLab. I'd expect =
it would be very tempting for one of those to make something that would eff=
ectively be a better Git than upstream Git, the usual embrace and extend ef=
fect.
=E2=80=93 development language ecosystems (Python, Ruby, Go, etc). There ar=
e already many premises of such work since build automation needs ids that =
can be processed by tools.

The problem with letting forges or language ecosystems sort it is that you'=
ll end up with functionally equivalent implementations, but divergent imple=
mentation details that end up wasting everyone's time. Like, decimal separa=
tor differences, deb vs rpm, car driving side, we humans managed to create =
the same clusterfuck time and time again. And much swearing every time you =
have a project that requires bridging those divergences.

It would be worth it if the divergence and competition helped new ground-br=
eaking schemes to emerge but really, look at it, it's not rocket science. E=
veryone has been using about this scheme for decades with little changes. T=
he remaining differences are slowly being eroded by the wish to automate ev=
erything.

Regards,

--=20
Nicolas Mailhot

