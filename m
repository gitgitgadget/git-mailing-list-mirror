From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: [PATCH] Add a commit.signoff configuration variable to always
	use --signoff.
Date: Sat, 27 Dec 2008 09:26:20 +0100
Message-ID: <20081227082620.GA5230@chistera.yi.org>
References: <1230296219-16408-1-git-send-email-dato@net.com.org.es> <20081227070228.6117@nanako3.lavabit.com> <20081226221033.GA841@chistera.yi.org> <7vabaijvxl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 27 09:27:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGUWO-0007pW-PQ
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 09:27:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbYL0I0Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Dec 2008 03:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbYL0I0Y
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 03:26:24 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:4242
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518AbYL0I0X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2008 03:26:23 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id C6647801BF66;
	Sat, 27 Dec 2008 09:26:21 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LGUV2-0001Mm-Ak; Sat, 27 Dec 2008 09:26:20 +0100
Mail-Followup-To: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <7vabaijvxl.fsf@gitster.siamese.dyndns.org>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103989>

* Junio C Hamano [Fri, 26 Dec 2008 16:36:38 -0800]:

> Adeodato Sim=C3=B3 <dato@net.com.org.es> writes:

> > ... I'd
> > still like to hear if my patch would be suitable for inclusion, bec=
ause
> > it's much more straightforward to use (and to discover).

> But "straightforward to discover" is not an advantage in this case.

> As long as it comes with documentation that clearly explains why this
> feature should not be used blindly in order to avoid diluting the val=
ue of
> S-o-b, I think the feature itself is not a harmful thing to have.  Ds=
cho's
> argument in the quoted thread that says it should be a conscious act =
to
> add S-o-b (except for the part he misunderstands what S-o-b attests),=
 is a
> good one and still is valid.

Does this sound good? If so, I'll send an amended patch (or should I se=
nd an
incremental/extra one instead?):

+commit.signoff::
+       If set, 'git-commit' will always add a Signed-off-by line.
+       Please use this option with care: by enabling it, you're statin=
g
+       that all your commits will invariably meet the S-o-b
+       requirements for any project you send patches to. It's probably
+       best to only use it from your private repositories' .git/config
+       file, and only for projects who require a S-o-b as proof of
+       provenance of the patch, and not of its correctness or quality.

> By the way, please do not deflect away responses meant to you by usin=
g a
> Mail-Followup-To header that points at the git mailing list.  It is r=
ude.

I set a M-F-T header because I prefer not to be CC'ed. I have other
mechanisms in place that prevent me from missing replies to my messages
(based on In-Reply-To/References headers).

Nevertheless, if the list normally operates CC-based, I can see how pre=
ssing
Reply-to-all and not seing the original autor in the recipient list can=
 be
offputting, so I'll stop setting M-F-T in my messages to git@. (Hopeful=
ly
starting with this message already.)

I didn't mean for it to be rude in any way.

Thanks,

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
A conference is a gathering of important people who singly can do nothi=
ng
but together can decide that nothing can be done.
                -- Fred Allen
