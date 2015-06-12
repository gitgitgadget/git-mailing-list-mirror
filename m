From: Scott Schmit <i.grok@comcast.net>
Subject: Re: [PATCH] git-checkout.txt: Document "git checkout <pathspec>"
 better
Date: Fri, 12 Jun 2015 00:49:06 -0400
Message-ID: <20150612044906.GA17424@odin.ulthar.us>
References: <5575F948.4060400@web.de>
 <xmqqioavob7n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, eda@waniasset.com,
	Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 06:57:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3H28-0002Dv-Ed
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 06:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbbFLE5X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jun 2015 00:57:23 -0400
Received: from resqmta-po-01v.sys.comcast.net ([96.114.154.160]:59270 "EHLO
	resqmta-po-01v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750722AbbFLE5W (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Jun 2015 00:57:22 -0400
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jun 2015 00:57:22 EDT
Received: from resomta-po-02v.sys.comcast.net ([96.114.154.226])
	by resqmta-po-01v.sys.comcast.net with comcast
	id fGp51q0014tLnxL01GpBUE; Fri, 12 Jun 2015 04:49:11 +0000
Received: from odin.ulthar.us ([IPv6:2001:470:8c86:0:225:64ff:fe8b:c2f2])
	by resomta-po-02v.sys.comcast.net with comcast
	id fGp81q0052Ekl4801Gp9Ck; Fri, 12 Jun 2015 04:49:10 +0000
Received: from odin.ulthar.us (localhost [127.0.0.1])
	by odin.ulthar.us (8.14.8/8.14.5) with ESMTP id t5C4n7fA017813;
	Fri, 12 Jun 2015 00:49:07 -0400
Received: (from draco@localhost)
	by odin.ulthar.us (8.14.8/8.14.8/Submit) id t5C4n68A017812;
	Fri, 12 Jun 2015 00:49:06 -0400
Content-Disposition: inline
In-Reply-To: <xmqqioavob7n.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1434084551;
	bh=ozIviwQi7wuHwdIjNXpNTdm2+PUVo8Ta4wEHmxEaD54=;
	h=Received:Received:Received:Received:Date:From:To:Subject:
	 Message-ID:MIME-Version:Content-Type;
	b=PHAgkJcKaECwwpb+mkZ9eG169Cvi+HLzHYYbj0C0kAzIxhVjnUmbBSltRanfRR/du
	 Mh4i3j9M4W9tMxqicXsWkWjr0Pz3iq3akeexX6cDgUPvQiuuBdpIm4FikSA+gDN/0q
	 Jjh5UNlMvHISHyTHn4MGLRIArJdVPN3g9HVde0xOfNGjWpDEaK5a7OlswP/fh5d+of
	 lNdlR9CDpMS//HTuXY2NjF5O08IZlaNCeT6TKWN5ySB0nIC/OxI/4Q2COWWn9DyPIp
	 Y/AghsmGdqHk7aA7sscCrUIEsSYrAIsI/MtKR98M4Y3ptLhObGOTqC/cBvlUNJOzS+
	 yxq701RasgXZA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271469>

On Wed, Jun 10, 2015 at 08:05:32AM -0700, Junio C Hamano wrote:
> Torsten B=F6gershausen <tboegi@web.de> writes:
>=20
> > git checkout <pathspec> can be used to revert changes in the workin=
g tree.
>=20
> I somehow thought that concensus in the recent thread was that
> "restore", not "revert", is the more appropriate wording?
>=20
> And I think that is indeed sensible because "revert" (or "reset")
> already means something else in Git (and in other systems), while
> "restore" does not have a confusing connotation.  It can only mean
> "overwrite with a pristine copy", which is what the command is
> about.
>=20
> > -git-checkout - Checkout a branch or paths to the working tree
> > +git-checkout - Switch branches or reverts changes in the working t=
ree
>=20
> Two verbs in different moods; either "switch branches or restore
> changes" or "switches branches or restores changes" would fix that,
> and judging from "git help" output, I think we want to go with the
> former, i.e. "switch branches or restore changes".
>=20
> > =20
> >  SYNOPSIS
> >  --------
> > @@ -83,7 +83,8 @@ Omitting <branch> detaches HEAD at the tip of the=
 current branch.
> >  	When <paths> or `--patch` are given, 'git checkout' does *not*
> >  	switch branches.  It updates the named paths in the working tree
> >  	from the index file or from a named <tree-ish> (most often a
> > -	commit).  In this case, the `-b` and `--track` options are
> > +	commit).  Changes in files are discarded and deleted files are
> > +	restored.
>=20
> I see we are suffering from the common disease of giving one
> explanation and then realizing that first explanation can be
> misread, clarifying it by more explanation, after reading the
> updated text three times.  Let's instead try to clarify the first
> explanation to make it harder to misread.
>=20
> In this case, "updates X from Y" is what causes misunderstanding, as
> "updates" does not necessarily mean "restores with the original".
>=20
> How about this?
>=20
>   	'git checkout' with <paths> or `--patch` is used to restore
>         modified or deleted paths to their original contents from
>         the index file or from a named <tree-ish> (most often a
>         commit) without switching branches.

I think these changes would improve the above:

s/index file/index/
- index file is implementation; the glossary only defines "index"

s/or from/or replace paths with the contents from/
- the latter case isn't always restoration, if <tree-ish> doesn't come
  from an ancestor of HEAD (so I don't like "restore" in the summary
  either)

s/without switching/instead of switching/
- 'without' implies it makes sense to restore/replace with switching
  branches, but we've chosen not to.  (I then waste time trying to
  understand that)

s/commit/commit-ish/
- tags are also tree-ishes, though you could argue this case is less
  "often"

leaving:

'git checkout' with <paths> or `--patch` is used to restore modified or
deleted paths to their original contents from the index or replace path=
s
with the contents from a named <tree-ish> (most often a commit-ish)
instead of switching branches.

does a sha1 count as "named"? Maybe s/named //.

--=20
Scott Schmit
