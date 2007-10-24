From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
	summary continued
Date: Wed, 24 Oct 2007 14:15:28 +0100
Message-ID: <1193231728.4671.13.camel@pc1117.cambridge.arm.com>
References: <1192827476.4522.93.camel@cacharro.xalalinux.org>
	 <DE4FB702-24E8-421F-8447-04A5C7F7B5D2@zib.de>
	 <8fe92b430710201606i47e85b24k17abd819bf0d353b@mail.gmail.com>
	 <Pine.LNX.4.64.0710210031130.25221@racer.site> <471AFD07.4040606@op5.se>
	 <Pine.LNX.4.64.0710212308540.25221@racer.site> <471C586A.9030900@op5.se>
	 <Pine.LNX.4.64.0710221156540.25221@racer.site>
	 <8fe92b430710231906l35606fe2j2b7c28ed6f4dd1a3@mail.gmail.com>
	 <20071024102950.GA3908@diana.vm.bytemark.co.uk>
	 <8fe92b430710240404u202521d4g2275bc4886956807@mail.gmail.com>
Reply-To: catalin.marinas@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karl =?ISO-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <ae@op5.se>,
	Steffen Prohaska <prohaska@zib.de>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 15:16:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ikg5k-0005if-7f
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 15:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756948AbXJXNQA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Oct 2007 09:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756728AbXJXNQA
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 09:16:00 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:35614 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753254AbXJXNP7 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 09:15:59 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id l9ODFXhX011653;
	Wed, 24 Oct 2007 14:15:34 +0100 (BST)
Received: from [10.1.79.3] ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 24 Oct 2007 14:15:33 +0100
In-Reply-To: <8fe92b430710240404u202521d4g2275bc4886956807@mail.gmail.com>
X-Mailer: Evolution 2.10.1 
X-OriginalArrivalTime: 24 Oct 2007 13:15:33.0472 (UTC) FILETIME=[F553CE00:01C8163F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62216>

On Wed, 2007-10-24 at 13:04 +0200, Jakub Narebski wrote:
> On 10/24/07, Karl Hasselstr=C3=B6m <kha@treskal.com> wrote:
> > On 2007-10-24 04:06:38 +0200, Jakub Narebski wrote:
> >
> >> 5. git format-patch to generate patch series; use git-shortlog or
> >> grepping for patches subjects and git-diff --stat to generate
> >> introductory email. Unfortunately StGIT template for introductory
> >> email does have neither shortlog nor diffstat fields to atomatical=
ly
> >> fill.
> >
> > It does now! (I don't think it's in any released version yet, thoug=
h.)
>=20
> That is nice to hear.
>=20
> By the way, there is SRPM for StGIT in
> http://homepage.ntlworld.com/cmarinas/stgit/
> (I need it because I have Python 2.4), but it is not listed on downlo=
ads page...

I never thought anyone would need it. I find the .tar.gz better.

BTW, what is the problem with Python 2.4? Was the RPM built for a
different version? The upcoming 0.14 release will be based on Python 2.=
5
but we keep the compatibility with 2.4 (we dropped 2.3).

--=20
Catalin
