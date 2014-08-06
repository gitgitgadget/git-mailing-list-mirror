From: Mike Stump <mikestump@comcast.net>
Subject: Re: cherry picking and merge
Date: Wed, 6 Aug 2014 12:11:16 -0700
Message-ID: <96B703A6-58B0-458A-8A2D-699EA8F1941B@comcast.net>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net> <20140801024329.GA28914@vauxhall.crustytoothpaste.net> <53DBBFE8.8060607@gmail.com> <5AF18A76-DD3B-4B9A-BF70-EFE4BB852C3D@comcast.net> <53DBF4C9.2090905@vilain.net> <4E372CD5-33CA-4AF5-8647-F6BBC64BABA8@comcast.net> <CAK3OfOiG8kzKYRUGZJW90t-DyjWf775MfMDxzin0gw94ATS7nw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sam Vilain <sam@vilain.net>,
	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git discussion list <git@vger.kernel.org>
To: Nico Williams <nico@cryptonector.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 21:11:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF6cq-0004Cv-VL
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 21:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755920AbaHFTLt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Aug 2014 15:11:49 -0400
Received: from qmta02.emeryville.ca.mail.comcast.net ([76.96.30.24]:34343 "EHLO
	qmta02.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755823AbaHFTLs convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Aug 2014 15:11:48 -0400
Received: from omta19.emeryville.ca.mail.comcast.net ([76.96.30.76])
	by qmta02.emeryville.ca.mail.comcast.net with comcast
	id bWJC1o0011eYJf8A2XBoBV; Wed, 06 Aug 2014 19:11:48 +0000
Received: from [IPv6:2001:558:6045:a4:40c6:7199:cd03:b02d] ([IPv6:2001:558:6045:a4:40c6:7199:cd03:b02d])
	by omta19.emeryville.ca.mail.comcast.net with comcast
	id bXBm1o00e2ztT3H01XBndY; Wed, 06 Aug 2014 19:11:47 +0000
In-Reply-To: <CAK3OfOiG8kzKYRUGZJW90t-DyjWf775MfMDxzin0gw94ATS7nw@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1407352308;
	bh=m+qUBIdCsXMW6AaVgaAObM4tlBflSNrC/yP/XSED+hE=;
	h=Received:Received:Content-Type:Mime-Version:Subject:From:Date:
	 Message-Id:To;
	b=XEDQeqmLwkF5E1Huv7diBX+WnXfNthJdiqw976nEaOf8jh3P7GmDSKhWd9oaX6n5n
	 hDhA6u22e8fL5y55eLOToUZ8okhdTVu014Z9aEHSnDeP+bWPWNobm7uDBOuUJw+WW+
	 hNdapycu2Bw3qdabzT05jD27Jc3ljq41zABUNS47HE8Zm5bZqX98N+odpHINmcYsmu
	 1odGnC1SrYCbl7aeDOYM96uLmPLGKCKVZk55Oue3bmfCaLuJwvUe8MYj0CRaxKJF0O
	 //lZZJAlcXjfqxFVCKSTceVYAFtiSjTHQTl7EVWiYHxBXPEdAqPnP+QFthkHR5r+Xt
	 stgSrKMj0SXhA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254893>

On Aug 1, 2014, at 4:40 PM, Nico Williams <nico@cryptonector.com> wrote=
:
> As for rebase, I still don't understand why it doesn't work for you.

http://git-scm.com/docs/git-rebase says:

  Rebasing (or any other form of rewriting) a branch that others have b=
ased work on is a bad idea

If you read stack-overflow, you will discover a ton of people that like=
 doing this, and they get hammered because of it.  My use case fits exa=
ctly (as near as I can tell) the hammer case.

If you make a different command that isn=92t guaranteed to screw me and=
 my co-workers over, and tell us to use that, then I=92d be happy to us=
e it.  Bet the farm that it won=92t bite you, just to be bitten isn=92t=
 what I want to try and recover from.

> You didn't really explain.

If you say it will never bit you and then fix all the documentation to =
not say it will bite you=85  I=92d be happy to contemplate it again.  N=
ow, I found the stack-overflow commentary first, and all the horrors of=
 it, and all the nuances.  I carefully read what people were doing, how=
 what I wanted to related to what they were doing, and it sure felt lik=
e I was in the, don=92t go there camp.

> Suppose we're right and it's the right solution for you, then you mig=
ht be ecstatic, but you gotta try it
> first.

So, I like to know if I=92m driving off a cliff, before I do.  I=92m th=
e type of person that would rather know were the road goes, and merely =
avoid driving off the cliff.  When stack-overflow is littered with the =
bodies of people that thought it would be fun, I tend to just say, that=
=92s not for me.

> The only case where I can imagine not using a
> rebase-heavy workflow is where I have to track multiple forked
> upstreams and so I want to merge each into my branch.

So, sounds like I fit that use case and rebase could be my friend.  How=
 do I square what you said and:

  Rebasing (or any other form of rewriting) a branch that others have b=
ased work on is a bad idea

?

I want all old refs in old emails to work.  I want all refs in bugzilla=
 to work.  I want to see the original dates of all the work.  I want gi=
t blame to report those artifacts in email and bugzilla.  I have cowork=
ers that I push to, pull from (through a single sharing point, we call =
the master tree).  We work on gcc, we pull git gcc down to a local copy=
, then merge it into our tree.  I want to cherry pick changes from upst=
ream.  I do work and push to our master, I pull work of coworkers from =
the master, my coworkers do the same.  Isn=92t this the canonical open =
source use case?

> (I find that many users are allergic to rebasing.  Many people have
> told me that rebase is lying, that history must be immutable, and so
> on, all ignoring that: git users don't rebase published branches,

So, when I push, and someone else pulls, is that published?  I thought =
it was.