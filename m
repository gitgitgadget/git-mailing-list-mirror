X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: "Thomas Kolejka" <Thomas.Kolejka@gmx.at>
Subject: Re: Is there a way to trim old SHAs from a git tree (so it's not so
 large)?
Date: Fri, 17 Nov 2006 11:36:11 +0100
Message-ID: <20061117103611.183640@gmx.net>
References: <455B90AD.3060707@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 17 Nov 2006 10:36:34 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <455B90AD.3060707@freescale.com>
X-Authenticated: #20307258
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31687>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl150-0007u4-6g for gcvg-git@gmane.org; Fri, 17 Nov
 2006 11:36:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932873AbWKQKgO convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006 05:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755691AbWKQKgN
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 05:36:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:8646 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1755687AbWKQKgM (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 05:36:12 -0500
Received: (qmail 32339 invoked by uid 0); 17 Nov 2006 10:36:11 -0000
Received: from 141.130.250.71 by www109.gmx.net with HTTP; Fri, 17 Nov 2006
 11:36:10 +0100 (CET)
To: Timur Tabi <timur@freescale.com>
Sender: git-owner@vger.kernel.org


-------- Original-Nachricht --------
Datum: Wed, 15 Nov 2006 16:11:57 -0600
Von: Timur Tabi <timur@freescale.com>
An: git@vger.kernel.org
Betreff: Is there a way to trim old SHAs from a git tree (so it\'s not =
so large)?

> After doing a "make mrproper" in my Linux git tree, the result is sti=
ll
> 1.1GB=20
> of files.  Compare that with just the tarball, which is just one-fort=
h the
> size.
>=20
> Is there a way to "trim away" old commits from the repository, so tha=
t it
> just=20
> doesn't take up that much space?  I don't care about any commits made=
 in
> 2005.=20
>   As long as I can still do "git pull" from the source repo to update
> mine,=20
> that's good enough.
>=20
> --=20
> Timur Tabi
> Linux Kernel Developer @ Freescale

Is it possible to do this with shallow clone?=20
Shallow clone the local repository my.git (which should be trimmed) sta=
rting from the last needed commit to a new local repository my_trimmed.=
git. And then remove my.git (with something like rm -rf my.git) and ren=
ame my_trimmed.git to my.git?

Thomas
--=20
Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!=20
