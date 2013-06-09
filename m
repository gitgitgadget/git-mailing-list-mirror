From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v4 10/45] sequencer: trivial fix
Date: Sun, 9 Jun 2013 19:33:42 +0200
Message-ID: <20130609173342.GB2091@goldbirke>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
 <1370796057-25312-11-git-send-email-felipe.contreras@gmail.com>
 <20130609171810.GA10858@goldbirke>
 <CAMP44s3yhVbgkhtrSfHpk=VwcwMkb66ELA-xR0i6FCVGyRwHJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:33:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UljV1-0006uk-96
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425Ab3FIRdr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 13:33:47 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:60530 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401Ab3FIRdr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:33:47 -0400
Received: from localhost6.localdomain6 (f051160074.adsl.alicedsl.de [78.51.160.74])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0Lnjkl-1U9tdZ1met-00hrrQ; Sun, 09 Jun 2013 19:33:42 +0200
Content-Disposition: inline
In-Reply-To: <CAMP44s3yhVbgkhtrSfHpk=VwcwMkb66ELA-xR0i6FCVGyRwHJw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:pL0wPPy80oaDjPf0GbsLth3F59ObhU161wVdMyXYOuh
 hYZ2Xef4S1XAfM1C2XDZJlmdYBaY1Iblm2KTvqr1lUktTYAOi8
 WxNUIKS4mlb74a2RtlVqb33ceYB8XKPVZ85Y4wQTDIHV236e4j
 y9XngmHk+bp9wd3A4dQDhsrNofq26ilTow9nVMObUMT6/Br+gN
 7VmO5AF2A3F+Ekue5pudRq237vqfv5eRp6Bix4GrkpGnXn82pb
 keA0xAQbI9Jf0pil7Arp81it4jK5uzK3nEMkUaPNA+WEtFmPxd
 D77f+J2Ivov3QCZLQJnGGDZuJKKOjj/CldaKO2YoX0c/E4vn0a
 nOirhR5tJkgBfVgiislY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227042>

On Sun, Jun 09, 2013 at 12:23:01PM -0500, Felipe Contreras wrote:
> On Sun, Jun 9, 2013 at 12:18 PM, SZEDER G=E1bor <szeder@ira.uka.de> w=
rote:
> > On Sun, Jun 09, 2013 at 11:40:22AM -0500, Felipe Contreras wrote:
> >> We should free objects before leaving.
> >>
> >> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> >
> > A shortlog-friendlier subject could be: "sequencer: free objects
> > before leaving".
>=20
> I already defended my rationale for this succinct commit message:
>=20
> http://thread.gmane.org/gmane.comp.version-control.git/225609/focus=3D=
225610

Your arguments were unconvincing.  The mere fact that I raised this
issue unbeknownst to the earlier posting clearly shows that there's
demand for descriptive subjects.
