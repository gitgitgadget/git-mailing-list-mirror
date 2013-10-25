From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Setting per-repository configuration for git
Date: Fri, 25 Oct 2013 12:37:16 +0000 (UTC)
Message-ID: <loom.20131025T143218-801@post.gmane.org>
References: <884520645.9668515.1382684531443.JavaMail.root@openwide.fr> <834511791.9670586.1382685155770.JavaMail.root@openwide.fr> <20131025082513.GE17029@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 25 14:37:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZge5-0002RK-Ir
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 14:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752595Ab3JYMhh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Oct 2013 08:37:37 -0400
Received: from plane.gmane.org ([80.91.229.3]:38048 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752117Ab3JYMhg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 08:37:36 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VZgdy-0002JH-H0
	for git@vger.kernel.org; Fri, 25 Oct 2013 14:37:34 +0200
Received: from eva93.neoplus.adsl.tpnet.pl ([83.20.198.93])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 Oct 2013 14:37:34 +0200
Received: from jnareb by eva93.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 Oct 2013 14:37:34 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 83.20.198.93 (Mozilla/5.0 (X11; Linux i686) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/28.0.1500.71 Chrome/28.0.1500.71 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236701>

Jeff King <peff <at> peff.net> writes:
> On Fri, Oct 25, 2013 at 09:12:35AM +0200, Jeremy Rosen wrote:
>=20
> > however I can't find a way to have the repository's configuration=20
> > saved and transmited with the repository in a way similar to how
> > .gitignore is transmitted...
> > [...]

> Two, the config is not really tied to a specific revision in the same
> way that a .gitignore is. If I move to another branch, or checkout an
> old revision, I would want to use the .gitignore from the currently
> checked-out commit. But git config does not typically work that way. =
If
> I am sight-seeing back to last year's history, I do not want to use a
> different remote URL, or different diff settings, etc. So managing a
> .gitconfig directly in the repository has some ugly edge cases.

Nb. *Mercurial* uses in repository .hgtags file for shared tags (instea=
d
of using separate transport mechanism, like Git does with refs, of
which tags are special case).  Said file has to be treated in a special
way, with some sharp corner-cases (e.g. committing a tag (sic!)).

--=20
Jakub Nar=C4=99bski
