From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Automating svn<->git gateway
Date: Wed, 13 Oct 2010 19:17:34 +0200
Message-ID: <20101013171734.GA3693@efreet.light.src>
References: <20101011193007.GA30870@efreet.light.src>
 <m3eibv6vah.fsf@localhost.localdomain>
 <20101012203159.GC30870@efreet.light.src>
 <201010130125.49725.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 19:17:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P64xT-0002IC-J9
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 19:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780Ab0JMRRi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Oct 2010 13:17:38 -0400
Received: from cuda1.bluetone.cz ([212.158.128.5]:38140 "EHLO
	cuda1.bluetone.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab0JMRRh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 13:17:37 -0400
X-ASG-Debug-ID: 1286990254-5efd811b0001-QuoKaX
Received: from efreet.light.src (152-31-80-78.praha.adsl.tmcz.cz [78.80.31.152]) by cuda1.bluetone.cz with ESMTP id ODZkOfhVsCkpDi4f; Wed, 13 Oct 2010 19:17:34 +0200 (CEST)
X-Barracuda-Envelope-From: bulb@ucw.cz
X-Barracuda-Apparent-Source-IP: 78.80.31.152
Received: from bulb by efreet.light.src with local (Exim 4.72)
	(envelope-from <bulb@ucw.cz>)
	id 1P64xK-0003uH-LD; Wed, 13 Oct 2010 19:17:34 +0200
X-ASG-Orig-Subj: Re: Automating svn<->git gateway
Content-Disposition: inline
In-Reply-To: <201010130125.49725.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Barracuda-Connect: 152-31-80-78.praha.adsl.tmcz.cz[78.80.31.152]
X-Barracuda-Start-Time: 1286990254
X-Barracuda-URL: http://212.158.128.5:8000/cgi-mod/mark.cgi
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5000 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=4.5 KILL_LEVEL=4.8 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.43580
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158945>

On Wed, Oct 13, 2010 at 01:25:48 +0200, Jakub Narebski wrote:
> On wtorek 12. pa=C5=BAdziernika 2010 22:31, Jan Hudec napisa=C5=82:
> > So while I'm sure the native SVN support will solve the quirks and =
bugs of
> > git-svn, it will not do away with need for the gateway repository t=
hat will
> > somehow synchronize itself with subversion.
>=20
> Well, I think that native SVN support would allow to treat subversion
> repository as one of repositories in the network of repositories.  Th=
ose
> repositories could be set in that pushing to central git repository p=
ushes
> also to subversion repository, and like central git repository fetche=
s
> from leaf repositories, it would fetch from subversion repository.

Yes. Except I don't know how to do the "pushing to central git reposito=
ry
pushes also to..." part. Subversion or not.

Though, I guess if it worked well enough to preserve the merge commit (=
i.e.
when I push and pull, I see the commit I pushed, not any kind of rewrit=
e),
pushing in update-hook would be quite many bits simpler.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
