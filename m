From: Drew Northup <drew.northup@maine.edu>
Subject: Re: rm and add, but not rename, of identical files
Date: Thu, 11 Oct 2012 11:10:40 -0400
Message-ID: <1349968240.32696.22.camel@drew-northup.unet.maine.edu>
References: <1349894347.32696.10.camel@drew-northup.unet.maine.edu>
	 <7v1uh6atjl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 17:16:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMKVM-0006sz-Pr
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 17:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758747Ab2JKPQp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Oct 2012 11:16:45 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:45523 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819Ab2JKPQp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 11:16:45 -0400
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id q9BFAg6W032054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 11 Oct 2012 11:10:47 -0400
In-Reply-To: <7v1uh6atjl.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=2
	Fuz1=2 Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: q9BFAg6W032054
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1350573047.72375@9gJaJ7zoua1h7L26uplPtg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207479>

On Wed, 2012-10-10 at 14:47 -0700, Junio C Hamano wrote:
> Drew Northup <drew.northup@maine.edu> writes:
>=20
> > # Untracked files:
> > #   (use "git add <file>..." to include in what will be committed)
> > #
> > #       rc.d/rc2.d/S08iptables
> > #       rc.d/rc3.d/S08iptables
> > #       rc.d/rc4.d/S08iptables
> > ...
> > no changes added to commit (use "git add" and/or "git commit -a")
> >
> > It detects the changes as renames however=E2=80=95which in this cas=
e isn't
> > appropriate:
> >
> > [root@drew-northup ~]# etckeeper vcs status
> > # On branch master
> > # Changes to be committed:
> > #   (use "git reset HEAD <file>..." to unstage)
> > #
> > #       renamed:    rc.d/rc2.d/K92iptables -> rc.d/rc2.d/S08iptable=
s
> > #       renamed:    rc.d/rc3.d/K92iptables -> rc.d/rc3.d/S08iptable=
s
> > #       renamed:    rc.d/rc4.d/K92iptables -> rc.d/rc4.d/S08iptable=
s
> > #...
>=20
> Given that all of these six files have the same contents, I actually
> am slightly impressed how well Git matched them up ;-).
>=20
> But more seriously, why do you have rc.d/rc2.d/S08iptables untracked
> in the working tree but in the index to be committed?

Missing steps in the mail body: etckeeper vcs add <File> & etckeeper vc=
s
rm <File> commands. I pared it back to the absolute minimum.

Is that what you're asking about?

--=20
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
