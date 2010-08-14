From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: Re: [PATCH] git-svn: fix fetch with deleted tag
Date: Sat, 14 Aug 2010 11:49:01 -0700 (PDT)
Message-ID: <84607.29034.qm@web30003.mail.mud.yahoo.com>
References: <1281794831-33347-1-git-send-email-ddkilzer@kilzer.net> <AANLkTinpLUyQP=6XktduWAmSHg3CgcT3Y7cMJ9FQ4by_@mail.gmail.com>
Reply-To: "David D. Kilzer" <ddkilzer@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 14 20:49:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkLn6-00036s-Fv
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 20:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757804Ab0HNStG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Aug 2010 14:49:06 -0400
Received: from web30003.mail.mud.yahoo.com ([209.191.69.20]:39604 "HELO
	web30003.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753910Ab0HNStF convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Aug 2010 14:49:05 -0400
Received: (qmail 29037 invoked by uid 60001); 14 Aug 2010 18:49:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1281811742; bh=mAA0mt866XTCZw9DYeonO5xJgacwaZre4JSdrxkcXoc=; h=Message-ID:X-YMail-OSG:Received:X-RocketYMMF:X-Mailer:References:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=6bwkCPmXKkB5/zfryln3jdbJJVIL5o0q93IzbUJ7TD5Nx9+wZxOVbS/c6X4vKcfOXxYuN/IwcQNPbJ20R26aNuQGpxcFZup+T/220t8KWftLuGeaEnP8BP8Jlnjln7X6T80uzhxcyCczup81WRy3ClzSrFlu5xjYr1IT97wfTQw=
X-YMail-OSG: 8IVND8kVM1nRv5P1LvvJySMcNKjNI8QULDDZs94IWsHluHs
 63307kdsKeRtv0LKHjhdXNGrD6cMfpAQ8w7hZ5N.ueig1ErVYtKb8zKw6C4F
 yBNZKvoBjTTTmhtFl4.uaYi4GYeU5C0wgO5oY3J4iI6yhjCCF0TnidRDgxeS
 .ewT.FpApK.3uygcbNDMwmnOyW192fqzu.ab8FlZmpZgexxQ.53CxOogZPZx
 r74Kih3mR8n59aZ3Ueo3kZiFiawuciEOO.UE.ut2KTNC9mLIWuCJSgBW5QmS
 _jNHFwKl4TUzZSSCJmjp.emfuJxQTxgfRqfkui9drgsRI68KLeKMlcgDnQLi
 8BvfIdiq6iimrrq.Wip13FzOvsK9yuaKeTpUdohWoklctRdTj
Received: from [67.188.213.238] by web30003.mail.mud.yahoo.com via HTTP; Sat, 14 Aug 2010 11:49:01 PDT
X-RocketYMMF: ddkilzer
X-Mailer: YahooMailRC/470 YahooMailWebService/0.8.105.279950
In-Reply-To: <AANLkTinpLUyQP=6XktduWAmSHg3CgcT3Y7cMJ9FQ4by_@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153570>

On Sat, August 14, 2010 at 7:52:48 AM, =C6var Arnfj=F6r=F0 Bjarmason wr=
ote:


> On Sat, Aug 14, 2010 at 14:07, David D. Kilzer <ddkilzer@kilzer.net> =
wrote:
> >  +++ b/t/t9156-git-svn-fetch-deleted-tag-2.sh
> >  @@ -0,0 +1,45 @@
> > +#!/bin/sh
> > +
> > +test_description=3D'git  svn fetch deleted tag 2'
>=20
> Any reason not to include both of these in the  same file? Just to
> avoid having to manually reset the  repository?


It was easier to run the tests individually when working on them, and I=
 was=20
hesitant to combine the setup steps from each test since it wouldn't be=
 as clear=20
which steps were for which test in the future.  I realize this may be s=
lower=20
when running the tests, but it makes them easier to maintain, especiall=
y when=20
one hasn't looked at the tests in a while.

Is there a nice way to reset the repository between steps?

Thanks for the feedback!  I've already applied your other suggestions.

Dave
