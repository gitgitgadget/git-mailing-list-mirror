From: Mike Stump <mikestump@comcast.net>
Subject: Re: cherry picking and merge
Date: Fri, 1 Aug 2014 15:24:05 -0700
Message-ID: <13DDD21A-F683-4116-9E07-F0D8AEF06A66@comcast.net>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net> <20140801024329.GA28914@vauxhall.crustytoothpaste.net> <53DBBFE8.8060607@gmail.com> <5AF18A76-DD3B-4B9A-BF70-EFE4BB852C3D@comcast.net> <CANQwDwc4YPdK+a0Oc-jWPTRyM5GiP-CMuRY1inxJY41GwUGBvQ@mail.gmail.com> <CANQwDwdKbmqLSLGsiyHTfGNZGfbeNZM3TN6Zk0G5G-8twRc_JQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git <git@vger.kernel.org>
To: =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 00:24:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDLFQ-00079A-2t
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 00:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754825AbaHAWYU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Aug 2014 18:24:20 -0400
Received: from qmta07.emeryville.ca.mail.comcast.net ([76.96.30.64]:54048 "EHLO
	qmta07.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754620AbaHAWYT convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Aug 2014 18:24:19 -0400
Received: from omta08.emeryville.ca.mail.comcast.net ([76.96.30.12])
	by qmta07.emeryville.ca.mail.comcast.net with comcast
	id ZZgJ1o0060FhH24A7aQK6p; Fri, 01 Aug 2014 22:24:19 +0000
Received: from [IPv6:2001:558:6045:a4:40c6:7199:cd03:b02d] ([IPv6:2001:558:6045:a4:40c6:7199:cd03:b02d])
	by omta08.emeryville.ca.mail.comcast.net with comcast
	id ZaQJ1o00K2ztT3H8UaQJeX; Fri, 01 Aug 2014 22:24:19 +0000
In-Reply-To: <CANQwDwdKbmqLSLGsiyHTfGNZGfbeNZM3TN6Zk0G5G-8twRc_JQ@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1406931859;
	bh=7g/M6QSQkeNhxlZYZ1Q9QNzux4JzjWhRKTegnWJb7VM=;
	h=Received:Received:Content-Type:Mime-Version:Subject:From:Date:
	 Message-Id:To;
	b=RYP1YASyBBnrFNNf3CEDXkkB5DGYkvd4dG+3QTbeT3Hg8mWQFkYEKqdbRwIFZApyp
	 oUtjjQhC/ecPPOevSF5AHucqt56YweGYN9hnTEVoVjb9/OEGKpm6wHJFqam9ONKYus
	 EcHP6caxq5nGK0IH1G7aPHB3Vdel96D1C+CUvOgoZq4rcDy9CkIX21OO37ZQclSiwQ
	 uoJnK94tA753/zQEoVPb3mDy8CImdlkVyfZKwLjjFXAHyAqqi2RTYg7w0huS7cA1uF
	 kyYVYQFZZ/m0gAtZAmkJA2L4v+I/bCVJpL42klxHZOQ2Lg8ulgXmzdmlDMOQe8JEGe
	 KHCBnhrOjKbSQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254674>

On Aug 1, 2014, at 12:01 PM, Jakub Nar=C4=99bski <jnareb@gmail.com> wro=
te:
> It can work in Subversion because Subversion stores information about
> what was merged in (and this includes cherry-picks, or whatever it is
> named in svn) in svn:mergeinfo property. Git does not track what was
> merged in, instead it represent the history as the graph of revisions=
,
> and tracks merges (by storing that it came from two or more commits)
> and not merged-in information.

So, as a dumb user that just wants it to work, I am unsympathetic to th=
e `but software is hard=E2=80=99 excuse.  I am aware that some bugs are=
 harder to fix than others.  svn took a long time to fix this bug, but =
they did.  I can wait, the only question is, will it be a week, a month=
, a year, or a decade.

> When merging Git uses only what is being merged and its common
> ancestor (3-point merge). It is simple, and simple works!!!

I gave a solution for git using branches and it works just fine.  It re=
tains the simple 3-point merge as well.

> Unfortunately, it does not see cherry-picked commits - it is invisibl=
e
> to merge as being on the chain from one of merged commits to the
> common ancestor.

Im the solution that I sketched in my previous email, that information =
is then exposed so that the right merge happens.

> The rebase command handles

I can=E2=80=99t use rebase as it is unfriendly to coworkers.

> cherry-picked commits by detecting that the
> change was already applied. I think that git-imerge does the same (bu=
t
> I have not used it myself).
>=20
> Have you tried git-imerge?

No, not yet.  I=E2=80=99m not as interested in using it, as I would lik=
e git itself to just work.