From: Tobias Getzner <tobias.getzner@gmx.de>
Subject: Re: [BUG] Mojibake in git gui and gitk for certain unicode chars
Date: Thu, 22 Jan 2015 13:18:22 +0100
Message-ID: <1421929102.22955.3.camel@gmx.de>
References: <1421927001.11296.27.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 22 13:18:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEGik-0001l4-Nc
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 13:18:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbbAVMSm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Jan 2015 07:18:42 -0500
Received: from mout.gmx.net ([212.227.15.18]:63436 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751744AbbAVMSZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jan 2015 07:18:25 -0500
Received: from glenalbyn.linguistics.ruhr-uni-bochum.de ([134.147.14.84]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0MEFlg-1YTdrj1w9g-00FThi
 for <git@vger.kernel.org>; Thu, 22 Jan 2015 13:18:23 +0100
In-Reply-To: <1421927001.11296.27.camel@gmx.de>
X-Mailer: Evolution 3.12.10 
X-Provags-ID: V03:K0:r8TRwbC0yi0fIhUHdPfVevZ1coH3uUL1AgCjZ4tkGoLFpjzLEi6
 NAT4p6ajmzpjl0N4oski9x3jZ2n0w/bKeFsAMv1tj5l/jwhgrXkXg7EstC0B1vL53809ds7
 6NJ02fby15zNseGp+yG/+j00RM4UIgU2OaC4FXFMNUweed2U7TdR1tF5Y7vlQ2cFbiLmfLc
 u7LyXG+7BUEU/4dQv3Y4Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262822>

On Do, 2015-01-22 at 12:43 +0100, Tobias Getzner wrote:
> Hello,
>=20
> I=E2=80=99ve noticed git gui and gitk seem to have problems decoding =
certain
> unicode characters. E.g., when a commit contains the character =C2=AB=
=F0=9F=91=8D=C2=BB
> (thumbs up sign; U+1F44D) in UTF-8 encoding, this character will show
> as =C2=AB=C3=B0=C2=9F=C2=91=C2=8D=C2=BB in gitk.=20

> I=E2=80=99ve noticed a perhaps related glitch when the options in git=
 gui is
> shown. My committer name contains the character =C2=AB=C3=9F=C2=BB (l=
atin small letter
> sharp s; U+00DF). The text field in the options dialog displays this =
as
> =C2=AB=C3=83=C2=9F=C2=BB,

I suppose that some of the mojibake characters in the message might
have been stripped out of the message because they are control chars.
So, =C2=AB=F0=9F=91=8D=C2=BB was rendered as =C2=AB=C3=B0\x9f\x91\x8d=C2=
=BB. =C2=AB=C3=9F=C2=BB was rendered as =C2=AB=C3=83\x9f=C2=BB.
