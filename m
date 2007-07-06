From: VMiklos <vmiklos@frugalware.org>
Subject: Re: Cherry-picking to remote branches
Date: Fri, 6 Jul 2007 17:01:55 +0200
Message-ID: <20070706150155.GV32766@genesis.frugalware.org>
References: <a2e879e50707060709oc9fe8b3k8e594f1cb6e10437@mail.gmail.com> <Pine.LNX.4.64.0707061524180.4093@racer.site> <a2e879e50707060739s4c8e751dj494618d3d545277b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sosn/fv6aiTyEgxl"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Sean Kelley <svk.sweng@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 17:02:13 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6pJx-0008I3-P9
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 17:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758365AbXGFPCG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 11:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756234AbXGFPCF
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 11:02:05 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:49009 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752795AbXGFPCE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 11:02:04 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1I6pJo-0001yE-Nc
	from <vmiklos@frugalware.org>; Fri, 06 Jul 2007 17:02:00 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id A796113A4105; Fri,  6 Jul 2007 17:01:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <a2e879e50707060739s4c8e751dj494618d3d545277b@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.0 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-1.0 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51758>


--Sosn/fv6aiTyEgxl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Na Fri, Jul 06, 2007 at 09:39:47AM -0500, Sean Kelley <svk.sweng@gmail.com>=
 pisal(a):
>> > git checkout -b stable linux-stable/master
>> >
>> > git cherry-pick  b3b1eea69a   (a commit from linux-devel)
>> >
>> > git push linux-stable
>> >
>> > error: remote 'refs/heads/master' is not a strict subset of local ref
>> > 'refs/heads/master'. maybe you are not up-to-date and need to pull
>> > first?
>> > error: failed to push to 'git://mysite.com/data/git/linux-stable.git'
>>
>> Since you are obviously only interested in pushing the stable branch, why
>> don't you
>>
>>         git push linux-stable stable
>>
>> Hm?
>>
>> If you do not specify which branches to push, "git push" will find all
>> refnames which are present both locally and remotely, and push those.
>> Evidently, however, your local "master" disagrees with the remote
>> "master".
>
> It is not entirely clear to me from the documentation.  So I was
> trying to cobble together something that seemed to make sense.  I want
> to work from the devel clone.  On occasion I want to cherry-pick
> changesets and push those to the stable branch.  I don't want
> everything that goes into devel to go into stable.

what about this?

        git push linux-stable stable:master

VMiklos

--=20
developer of Frugalware Linux - http://frugalware.org

--Sosn/fv6aiTyEgxl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGjllje81tAgORUJYRAoh6AJ42VD/IN2STgV+xXmG/EvkZfynymgCfYdaH
04pvjdQiH03MpJXSEsJDtnw=
=mcLO
-----END PGP SIGNATURE-----

--Sosn/fv6aiTyEgxl--
