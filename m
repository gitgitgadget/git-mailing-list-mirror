From: Jan =?UTF-8?B?U3TEmXBpZcWE?= <jan@stepien.cc>
Subject: Re: [PATCH] fetch-pack: make the ssh connection quiet
Date: Wed, 27 Oct 2010 20:40:23 +0200
Message-ID: <20101027204023.729808c8.jan@stepien.cc>
References: <1288189628-4883-1-git-send-email-jstepien@users.sourceforge.net>
	<1288193069.15518.40.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Wed Oct 27 20:51:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBB5i-0003eq-9I
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 20:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299Ab0J0SvJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 14:51:09 -0400
Received: from r245-52.iq.pl ([86.111.245.52]:52086 "EHLO stepien.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751782Ab0J0SvI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 14:51:08 -0400
X-Greylist: delayed 642 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Oct 2010 14:51:07 EDT
Received: from jan-sl300-ubuntu (chello089074090017.chello.pl [89.74.90.17])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by stepien.cc (Postfix) with ESMTPSA id 5218A2A10378;
	Wed, 27 Oct 2010 20:40:24 +0200 (CEST)
In-Reply-To: <1288193069.15518.40.camel@drew-northup.unet.maine.edu>
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.20.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160113>

On Wed, 27 Oct 2010 11:24:29 -0400
Drew Northup <drew.northup@maine.edu> wrote:
> On Wed, 2010-10-27 at 16:27 +0200, Jan St=C4=99pie=C5=84 wrote:
> > The --quiet option passed to fetch-pack did not affect the ssh chil=
d
> > process. When an ssh server sent a motd it was displayed because th=
e ssh
> > client wasn't launched with the -q option. This patch makes ssh run=
 quietly
> > when fetch-pack is called with -q.
> >=20
> > An analogous change should be made to other commands which accept -=
-quiet
> > and connect to remotes using ssh.
>=20
> I'm not so sure that's a good idea. Quoting from the (Open)SSH man pa=
ge:
>=20
> -q      Quiet mode.  Causes all warning and diagnostic messages to be=
 suppressed.
>=20
> Somehow I doubt that's what you intended or a good idea.

That's right, but according to the same source all fatal error messages
still get displayed. It's a question of how quiet should fetch-pack be
when --quiet is enabled.

Thanks for the comment,
--=20
Jan St=C4=99pie=C5=84 <jan@stepien.cc>
