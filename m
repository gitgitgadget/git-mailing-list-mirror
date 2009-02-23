From: Gerrit Pape <pape@smarden.org>
Subject: Re: [PATCH] git-tag: don't use gpg's stdin, stdout when signing tags
Date: Mon, 23 Feb 2009 15:23:03 +0000
Message-ID: <20090223152303.9953.qmail@770db0999d0428.315fe32.mid.smarden.org>
References: <20090220113856.6612.qmail@0bbdb5719a4668.315fe32.mid.smarden.org> <20090220134634.GJ4505@inocybe.teonanacatl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 16:31:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbcm1-0004nt-Ui
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 16:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889AbZBWP3r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Feb 2009 10:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754698AbZBWP3q
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 10:29:46 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:2719 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754671AbZBWP3q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 10:29:46 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Feb 2009 10:29:45 EST
Received: (qmail 9954 invoked by uid 1000); 23 Feb 2009 15:23:03 -0000
Content-Disposition: inline
In-Reply-To: <20090220134634.GJ4505@inocybe.teonanacatl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111138>

On Fri, Feb 20, 2009 at 08:46:34AM -0500, Todd Zullinger wrote:
> Gerrit Pape wrote:
> > When using gpg with some console based gpg-agent, acquiring the
> > passphrase through the agent fails if stdin and stdout of gpg are
> > redirected.  With this commit, git-tag uses temporary files instead
> > of standard input/output when signing a tag to support such
> > gpg-agent usage.
> >
> > The problem was reported by Lo=EFc Minier through
> > http://bugs.debian.org/507642
>=20
> I sign tags using gpg-agent with the curse pinentry often and it work=
s
> here.  Perhaps Lo=EFc has not set GPG_TTY as the gpg-agent documentat=
ion
> suggests?  If I unset GPG_TTY, I get the sort of failure indicated in
> the bug report.  With it set tag signing works as expected.

Thanks a lot Todd and Johannes for teaching me.  From my POV this patch
can be dropped.

Regards, Gerrit.
