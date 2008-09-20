From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@strlen.de>
Subject: Re: Encoding problems with format-patch [Was: [PATCH v2 00/14]
	Sparse checkout]
Date: Sat, 20 Sep 2008 20:40:18 +0200
Message-ID: <20080920184018.GC18932@strlen.de>
References: <1221904913-25887-1-git-send-email-pclouds@gmail.com> <m31vzen4v5.fsf@localhost.localdomain> <fcaeb9bf0809201033o1e9298a8ob135c68228b77218@mail.gmail.com> <200809202001.28383.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 20 20:41:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kh7Oh-0002pF-FJ
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 20:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbYITSkV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Sep 2008 14:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbYITSkV
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 14:40:21 -0400
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:55591 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751335AbYITSkU (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Sep 2008 14:40:20 -0400
Received: id: ukleinek by Chamillionaire.breakpoint.cc authenticated by ukleinek with local
	(easymta 1.00 BETA 1)
	id 1Kh7NS-00058T-Vo; Sat, 20 Sep 2008 20:40:19 +0200
Content-Disposition: inline
In-Reply-To: <200809202001.28383.jnareb@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96360>

Hello,

On Sat, Sep 20, 2008 at 08:01:27PM +0200, Jakub Narebski wrote:
> On Sat, 20 Sep 2008, Nguyen Thai Ngoc Duy wrote:
> >>> Nguy=C3=A1=C2=BB=E2=80=A6n Th=C3=83=C2=A1i Ng=C3=A1=C2=BB c Duy (=
14):
> >>
> >>  Errr... what happened here? For me it doesn't look like correct U=
TF-8
> >>  encoding, but perhaps that it is just my news client (Gnus)...
> >=20
> > The cover letter lacks MIME-Version and Content-Type, hmm..
>=20
> Bug in git-format-patch? IIRC --cover-letter was added quite late, an=
d
> is quite a new option; some bugs might have been not ironed out yet.
I hit this kind of problem already, too.

My problem was that format-patch only adds MIME-Version and
Content-Type headers if the commit has non-ascii characters.  If I add =
a
S-o-b only after the format-patch step I easily forget to add the neede=
d
headers.  IMHO the right fix is to let send-email stop if there is no
encoding related header in the mail but non-ascii characters.

Best regards
Uwe
