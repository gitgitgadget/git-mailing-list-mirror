From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] completion: move private shopt shim for zsh to __git_
	namespace
Date: Sun, 8 May 2011 12:48:15 +0200
Message-ID: <20110508104815.GF1377@goldbirke>
References: <1303867612-15975-1-git-send-email-felipe.contreras@gmail.com>
	<20110427013534.GA14286@elie>
	<7v62q0b8e0.fsf@alter.siamese.dyndns.org>
	<20110427064033.GB4226@elie>
	<BANLkTinA5hfddqpGwOBjk+2oFDpwqORrSg@mail.gmail.com>
	<20110427091140.GB14849@elie>
	<BANLkTi=3T2B=Gtyk7V_3DB3V+GkbXAaqPw@mail.gmail.com>
	<BANLkTikN7iMa_z7wRN8pUS07SMatpyoDPQ@mail.gmail.com>
	<20110427212704.GB18596@elie> <20110506054604.GA13351@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 08 12:48:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ1XR-00034k-IV
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 12:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646Ab1EHKsc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 06:48:32 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:62200 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab1EHKsb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 06:48:31 -0400
Received: from localhost6.localdomain6 (p5B13106A.dip0.t-ipconnect.de [91.19.16.106])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0Lbevf-1PufGd0Ed1-00lFgG; Sun, 08 May 2011 12:48:16 +0200
Content-Disposition: inline
In-Reply-To: <20110506054604.GA13351@elie>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:T7UXXMPJapE6PjnwHozeKkoo8VnxqnsvqemOtpELbqp
 BHBqYvQpEgvH6wZyUdqc23Nx+m8B5aAdhwVC6YpaIeR5eRaUrl
 FGlKlVL1CVb0TTmGTE72ONNvR6WLdJ4tpOTxzXD9BHahKKksa0
 G1SuV/EU5HkhryfoIwaSubwizDi4Dg5IYPTKlpdoalh5WC1w2l
 qC9Ahzrimi485AmHoliag==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173090>

On Fri, May 06, 2011 at 12:46:04AM -0500, Jonathan Nieder wrote:
> (culling cc list of quiet people :))
> Jonathan Nieder wrote:
>=20
> > Most zsh users probably probably do not expect a custom shopt funct=
ion
> > to enter their environment just because they ran "source
> > ~/.git-completion.sh".
> >
> > Such namespace pollution makes development of other scripts confusi=
ng
> > (because it makes the bash-specific shopt utility seem to be availa=
ble
> > in zsh) and makes git's tab completion script brittle (since any ot=
her
> > shell snippet implementing some other subset of shopt will break it=
).
> > Rename the shopt shim to the more innocuous __git_shopt to be a goo=
d
> > citizen (with two underscores to avoid confusion with completion ru=
les
> > for a hypothetical "git shopt" command).
>=20
> By the way, I meant the above[1] as a genuine patch submission.
> Thoughts?  Bugs?  Improvements?
>=20
> [1] http://thread.gmane.org/gmane.comp.version-control.git/172142/foc=
us=3D172275

It surely won't be fun to debug such breakages, so:

Acked-by: SZEDER G=E1bor <szeder@ira.uka.de>
