From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3] Updated patch series for providing mechanism to list
	available repositories
Date: Wed, 28 Jul 2010 19:33:42 -0500
Message-ID: <20100729003342.GC29156@dert.cs.uchicago.edu>
References: <AANLkTikqA3kNif+7Bi+=xkJ2FgCFAsfCj0N5dft5pnFR@mail.gmail.com> <201007270916.59210.j.sixt@viscovery.net> <20100727174105.GA5578@burratino> <AANLkTikr5jjZJa2irLb2rNew8ngJcv3rhcFV+pNRpRrw@mail.gmail.com> <20100728003336.GA2248@dert.cs.uchicago.edu> <AANLkTik1D45_cHPapbmMMys-V544ssCyoxrs5Fxck7oP@mail.gmail.com> <20100728064251.GB743@dert.cs.uchicago.edu> <1280358894.31999.9.camel@balanced-tree> <20100728235249.GA29156@dert.cs.uchicago.edu> <AANLkTikaBoMOEGvLU8FL4Cvw4zBecXytvAnAYTS9GBa3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Anders Kaseorg <andersk@mit.edu>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	gitster@pobox.com, git@vger.kernel.org
To: Greg Brockman <gdb@MIT.EDU>
X-From: git-owner@vger.kernel.org Thu Jul 29 02:33:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeH4G-0003Xo-Lh
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 02:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417Ab0G2Ado convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 20:33:44 -0400
Received: from camembert.cs.uchicago.edu ([128.135.164.153]:34741 "EHLO
	smtp.cs.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889Ab0G2Adn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 20:33:43 -0400
Received: from dert.cs.uchicago.edu (dert.cs.uchicago.edu [128.135.11.157])
	by smtp.cs.uchicago.edu (Postfix) with ESMTP id AE848A1FC;
	Wed, 28 Jul 2010 19:33:42 -0500 (CDT)
Received: by dert.cs.uchicago.edu (Postfix, from userid 10442)
	id 79BA49A182; Wed, 28 Jul 2010 19:33:42 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikaBoMOEGvLU8FL4Cvw4zBecXytvAnAYTS9GBa3@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152134>

Greg Brockman wrote:

> (Incidentally, I just noticed a segfault with
>=20
> $ unset HOME
> $ su git -m -c "git-receive-pack '~'"
>=20
> that's probably worth fixing... if people don't think this is too
> pedantic of a case to fix, I'll submit a patch for it in a later
> series [I think the segfault comes from path.c:expand_user_path].)

Here=E2=80=99s a patch to save you time. :)

http://git.kernel.org/?p=3Dgit/git.git;a=3Dcommitdiff;h=3D79bf149

> Anyway, i'll revise my first patch to use HOME rather than getpw*.

=46rom the getpwnam(3) man page it looks like that is best practice,
anyway.

Cheers,
Jonathan
