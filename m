From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Tue, 27 Jul 2010 14:36:58 -0400
Message-ID: <20100727183658.GB25124@worldvisions.ca>
References: <4C472B48.8050101@gmail.com> <AANLkTi=LHYDhY=424YZpO3yGqGGsxpY2Sj8=ULNKvAQX@mail.gmail.com> <AANLkTinhd2DYh7WXzMvhMkqp98fYtTWWuQi0RSL9Rome@mail.gmail.com> <201007261056.58985.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: skillzero@gmail.com, Marc Branchaud <marcnarc@xiplink.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 20:37:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odp1O-0004aD-Tj
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 20:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518Ab0G0Sgy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 14:36:54 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38201 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753380Ab0G0Sgx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 14:36:53 -0400
Received: by gyg10 with SMTP id 10so1354323gyg.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 11:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=coyOmbFwvO6RsUmFWtXOCt29DirALJdlVm/N40C6FLU=;
        b=C2/zbAPH8pzFDietqX5majlogDK3wV47V/OsfRVelpSEb3n9/0dNkrq+Icj6yAmdQb
         RAgVbzQ9m94D0O73XX79+3nWxzOq/xxarkJKyhSCrUOblJS7hgfiHyuAM9Eb2ySztQ+f
         fcyAvJmbORvO7jplmQulwBEao0lROFi5CNRpk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ZHp6rhW3OECMMVoEJveX+tqxXZAZPpKF7EurLXQMsMJDNoj2r5Alt41YLe9e5tHJ32
         Br0sqex3Vl6G6I6q0wiPZgcfgud1HLW+uIs8PNGrqOAOmwqD2VEtBQwAoaMzMeY2f8Gk
         UYkY0MfJBmr8h4OJTB4jqeB3akmGjxah28Pu4=
Received: by 10.90.86.17 with SMTP id j17mr6994391agb.206.1280255801177;
        Tue, 27 Jul 2010 11:36:41 -0700 (PDT)
Received: from afterlife.apenwarr.local ([66.51.252.152])
        by mx.google.com with ESMTPS id h8sm5032690ibk.9.2010.07.27.11.36.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 11:36:39 -0700 (PDT)
Received: from apenwarr by afterlife.apenwarr.local with local (Exim 4.69)
	(envelope-from <apenwarr@afterlife.apenwarr.local>)
	id 1Odp1O-0006Xd-Ep; Tue, 27 Jul 2010 14:36:58 -0400
Content-Disposition: inline
In-Reply-To: <201007261056.58985.jnareb@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151970>

On Mon, Jul 26, 2010 at 10:56:58AM +0200, Jakub Narebski wrote:
> On Sat, Jul 24, 2010, skillzero@gmail.com napisa=C5=82:
> > git-submodule might be technically possible in this situation, but
> > having to commit and push each submodule and then commit and push t=
he
> > super module makes it slightly worse than just dealing with the
> > space/download/performance issues of one huge repository.
>=20
> But this is just a matter for improving UI for dealing with submodule=
s,
> isn't it.   For example having "git commit --recursive" would help
> with 'having to commit each submodule', though how you would write co=
mmit
> messages then: perhaps supermodule commit message could be by default
> composed out of submodules commits (if any).  "git push --recursive"
> (or some support for push in "git remote") would help with 'having to
> push each submodule'.

=46or "recursive" commit, for my own workflow, I would rather have it w=
ork
like this: from the toplevel, I can 'git commit' any set of files, as l=
ong
as they all fall inside a particular submodule.  That is, if I do

	git commit mod1/*.c mod2/*.c
=09
it should reject it (with a helpful message), because the commit would =
cross
submodule boundaries.  But if I do

	git commit mod1/*.c
=09
I think it should create a new commit in mod1, leave my superproject
pointing at that new commit, and stop (ie. without the superproject hav=
ing
committed the new commit pointer).

Why?  Because my normal workflow is:

  - make a bunch of superproject/submodule changes until they work.
  - commit the submodule changes with a submodule-relevant message
  - commit the superproject change with a supermodule-relevant message
 =20
I wouldn't want to share commit messages between the two, so actually h=
aving
a single commit process be "recursive" would not do me any good.

However, pushing is a separate issue entirely.  Having push be recursiv=
e
would be easy, but it doesn't solve the *real* problem with pushing: gi=
t
doesn't know what branch to push to in the submodule, and the submodule=
 most
likely isn't pointing at a pushable repo at all, even if the supermodul=
e is.=20
This is why I keep coming back to the idea that I really want to push a=
ll
the submodule objects into the superproject's repo.

Have fun,

Avery
