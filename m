From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitosis-lite
Date: Mon, 24 Aug 2009 17:43:12 +0200
Message-ID: <200908241743.15841.jnareb@gmail.com>
References: <2e24e5b90908240528v56fdf30cq4c046fca321a3b17@mail.gmail.com> <m3ab1pmk1c.fsf@localhost.localdomain> <2e24e5b90908240735n5f754c87u960493c92769c0a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Tommi Virtanen <tv@eagain.net>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 17:43:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mfbhj-0000jk-LX
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 17:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671AbZHXPnS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Aug 2009 11:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752606AbZHXPnS
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 11:43:18 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:61872 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631AbZHXPnR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 11:43:17 -0400
Received: by fg-out-1718.google.com with SMTP id e12so518724fga.17
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 08:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=r+AOWJ9p0sHr4YxyfOZ7aRk98wfUV74ABXAtdIAR27Y=;
        b=QwnQ/chWN06dFs2D1fbCJW3PxjXY6yHNdTxMxnX0vmjreTTa/bdoFEN44awlVFGuSz
         EHSpy3ERzN6fo7H5Hrsb07WwvzG8rndYK10WEBz0NqRzl0d5xEPwqfRavhjseF1rwQ+5
         wJyiFVOeS7ZzNdqMOeVbsNTKtWeN9BA5O2q6k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=QYbLyWWnY07EYZTc0wodMa4Aj7LSI32cnrDhSERIfv7nm20+BixOoj8pSOdhEZ8cab
         iM0/tE105/7PKMlMZ3hYd/GPlW3mKIe6WxfKqioe6QMZSBEYcFwoe6ynvHvr/Twm9EJR
         IuanxliWLVoMV/nHOY67nwgReeC8xG3Q3AN+I=
Received: by 10.86.238.30 with SMTP id l30mr3326878fgh.75.1251128597770;
        Mon, 24 Aug 2009 08:43:17 -0700 (PDT)
Received: from ?192.168.1.13? (abwd173.neoplus.adsl.tpnet.pl [83.8.227.173])
        by mx.google.com with ESMTPS id 4sm3178451fge.2.2009.08.24.08.43.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 Aug 2009 08:43:16 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <2e24e5b90908240735n5f754c87u960493c92769c0a8@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126940>

On Mon, 24 August 2009, Sitaram Chamarty wrote:
> On Mon, Aug 24, 2009 at 6:43 PM, Jakub Narebski<jnareb@gmail.com> wro=
te:
>=20
> > Could you add information about this tool (perhaps after confirmati=
on
> > / deciding on project name[1]) to Git Wiki page
> > =A0http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
> > somewhere below Gitosis? =A0Please do not forget to include that it=
 is
> > written in Perl; see other entries for example.
>=20
> Will do; though I'll probably wait until at least one person
> other than me has used it :)

On the other hand having the link in IFAT wiki page could help you
gain more users of gitosis-lite (name pending ;-)

> > You wrote in project's README.markdown that you were inspired by
> > Gitosis (which requires Python and python-setuptools) and
> > Documentation/howto/update-hook-example.txt (which uses bash).
> > Why not contrib/hooks/update-paranoid (which is written in Perl)?
>=20
> Hmmm several reasons.  To start with, it appears to me that
> update-paranoid assumes each user has his own ACL file, and
> I'm going the other way -- you'll notice I have exactly one
> file as a single ACL source for many *projects*, leave alone
> users.

Well, gitosis uses single SSH user: 'git' (by default, at least).

Also from what I understand update-paranoid uses the same set of ACLs
for all projects (well, depending how $acl_git and $acl_branch are
defined).
=20
> Secondly, I want to stick to the gitosis philosophy -- it
> has served very well, and I'm not sure how "in use"
> update-paranoid is.

I wonder about this too.
=20
> Thirdly, I'm not comfortable having a hook be so complex.
> The whole thing is 10 lines shorter than all my code put
> together :)

The update-paranoid hook has inline POD documentation, which adds to
its size (I think that your gitosis-lite (name pending) should also
use this Perl literate programming convention).  On the other hand
this documentation is not, unfortunately, up to date; for example
it allows to control which directories you can change, which is not
documented in POD.

> And finally, it's far too complex for me, leave alone some
> of my users.  I count 6 pipe opens in there, and the ACLs
> are read by git cat-file or something :)

That's because update-paranoid, like gitosis, uses configuration in
$scl_repo repository.  git-cat-file is low level (plumbing) equivalent
of git-show (porcelain).

Those pipelines are required for strict (paranoid) access control that
update-paranoid uses: checking that committers are on allowed list,
that taggers are on allowed list, that branches points to commits, that
tags points to tag objects, etc.

> I'll be honest: I=20
> came away feeling very stupid after trying to read and
> understand that program.  It was... humbling :(

On the other hand it uses subroutine prototypes (unnecessary, and not
recommended), old-style bareword filehandles instead of lexically scope=
d
filehandles ("open I, ..." vs "open my $fh, ...")
=20
> > Using Perl code for configuration is simple and fast, but not very
> > secure. =A0Why not use git config format (via "git config -l -z" li=
ke in
>=20
> Not secure in what sense?  Only the "git admin" (whoever
> owns the account in which gitosis-lite is running) will be
> able to generate it, and only scripts that run with his
> authority (by way of hooks in repos he owns) can run it.
>=20
> It cannot do what he did not intend to do, and what he wants
> to do he can do anyway, whether it's JSON or perl.
>=20
> Except for umasking the file, I don't see anything I missed.
> Could you help me understand?

Ah, thats O.K. then.

>=20
> > gitweb), or YAML or JSON (or Storable)? =A0Well, YAML might be over=
kill.
>=20
> One of the objectives is to work *as is* on any Unix system
> that managed to install git (which implies Perl).  So, no
> JSON or YAML.  Storable would be fine (I think it's also
> part of core perl) so if I find a compelling reason I don't
> mind switching to that.

One reason to not use Storable is that it is binary.  Another that form=
at
is not exactly stable (but it contains version info, so it is backwards
compatibile I think).

As for dependencies: some people on #perl told me to not worry about
dependencies because there is PAR :-)

>=20
> All I really have is a nested hash to be saved and restored
> -- nothing more complex, no objects, no blessed refs, etc.

JSON would be good then ;-)

>=20
> > BTW. if you blog about gitosis-lite (http://sitaramc.blogspot.com/)
> > it could be picked up by Perl Iron Man Blogging challenge, and you
> > could get wider review.
>=20
> Will do; thanks.  I did not know my blog got picked up by
> anything; till date it has never come up on a google search
> or a blog search anywhere, and it's more of a rant-box +
> annotated bookmarking service for myself :)

I don't know if it would be picked; still, you can try to submit it to
(join) http://ironman.enlightenedperl.org; note that only posts which
contain one of magic words ('perl', 'ironman', ...) would get picked by
this planet.

>=20
> > [1]: gitosis-lite doesn't look like CPAN-y name. =A0Git::Admin perl=
haps?
>=20
> Too presumptuous for someone like me -- makes it sound like
> the "one true way to Admin git" :)

Git::Auth perhaps (authentication and authorization)? =20
Git::AccessControl?

You can always ask on #perl (also on freenode).
--=20
Jakub Narebski
Poland
