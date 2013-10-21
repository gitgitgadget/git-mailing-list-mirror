From: Jeremy Rosen <jeremy.rosen@openwide.fr>
Subject: Re: RFE: support change-id generation natively
Date: Mon, 21 Oct 2013 16:51:03 +0200 (CEST)
Message-ID: <2127507934.9293293.1382367063640.JavaMail.root@openwide.fr>
References: <1382366880.8925.36578285.27469B22@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: james moger <james.moger@gitblit.com>
X-From: git-owner@vger.kernel.org Mon Oct 21 17:05:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYH2p-0007Rr-Lh
	for gcvg-git-2@plane.gmane.org; Mon, 21 Oct 2013 17:05:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753859Ab3JUPFP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Oct 2013 11:05:15 -0400
Received: from zimbra3.corp.accelance.fr ([213.162.49.233]:40854 "EHLO
	zimbra3.corp.accelance.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753811Ab3JUPFM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Oct 2013 11:05:12 -0400
X-Greylist: delayed 848 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Oct 2013 11:05:12 EDT
Received: from localhost (localhost [127.0.0.1])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 4DF9E6B15E;
	Mon, 21 Oct 2013 16:51:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra3.corp.accelance.fr
Received: from zimbra3.corp.accelance.fr ([127.0.0.1])
	by localhost (zimbra3.corp.accelance.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cT3RdRfUx0qQ; Mon, 21 Oct 2013 16:51:03 +0200 (CEST)
Received: from zimbra2.corp.accelance.fr (zimbra2.corp.accelance.fr [213.162.49.232])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id B6BDD6B0D7;
	Mon, 21 Oct 2013 16:51:03 +0200 (CEST)
In-Reply-To: <1382366880.8925.36578285.27469B22@webmail.messagingengine.com>
X-Originating-IP: [213.162.49.238]
X-Mailer: Zimbra 7.2.2_GA_2852 (ZimbraWebClient - GC30 (Linux)/7.2.2_GA_2852)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236430>

for those of us that are not using gerrit...

what is a change-id (semantically, I got from your mail that it is some=
 sort
of unit id set at commit time) and in what way is it different from the=
=20
commit-id ?

Cordialement=20

J=C3=A9r=C3=A9my Rosen=20
+33 (0)1 42 68 28 04

fight key loggers : write some perl using vim=20


Open Wide Ingenierie

23, rue Daviel
75012 Paris - France
www.openwide.fr





----- Mail original -----
> Hello Git Community,
>=20
> TL;DR:
> It would be a really nice enhancement if the commit command natively
> supported _optionally_ injecting a "Change-Id: I000..." footer in the
> last paragraph of the commit message template and then substituting
> the
> "I000..." value, on commit, with a generated value _without_ having
> to
> rely on a per-repository, native hook or a global hook that affects
> every local repository.
>=20
> Full Request:
> Gerrit has established the change-id footer as a prominent and
> wide-spread collaboration identifier.  For those contributing new
> patches to a Gerrit server, it is required to either use EGit/JGit
> (Eclipse) to generate commits [1] OR to use a commit hook script with
> native git to insert a change-id footer during the commit process
> [2].
> This per-repository hook script requirement is an obstacle.  These
> communities would be better served and it would lower the
> contribution
> barrier for many open source projects if native git supported
> change-id
> generation & injection.
>=20
> I acknowledge that not everyone uses nor wants to use Gerrit and the
> change-id footer.  That is fine, but it would be a _tremendous_
> usability improvement for those contributing to open source projects
> (myself included) if something like a "--change-id" flag  was
> implemented and maybe even a config setting to always generate a
> change-id on commit (EGit currently supports this as
> "gerrit.createchangeid=3Dtrue").
>=20
> Sadly, my C skills are lacking as I live mostly in the world of
> managed
> code, but I'd be very happy to cheer for a change-id champion; I
> suspect
> there are some out there who might rally to this cause.
>=20
> Thanks for your consideration.
> James Moger
> gitblit.com
>=20
> [1]
> https://git.eclipse.org/c/jgit/jgit.git/tree/org.eclipse.jgit/src/org=
/eclipse/jgit/api/CommitCommand.java?h=3Dstable-3.1#n288
> [2]
> http://gerrit-documentation.googlecode.com/svn/Documentation/2.0/cmd-=
hook-commit-msg.html
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
