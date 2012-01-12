From: =?ISO-8859-1?Q?R=FCdiger?= Sonderfeld <ruediger@c-plusplus.de>
Subject: Re: [PATCH] git-blame.el: Fix compilation warnings.
Date: Thu, 12 Jan 2012 18:08:21 +0100
Message-ID: <2304907.sEfEeC6Eon@descartes>
References: <2608010.fNV39qBMLu@descartes> <20120112162617.GA2479@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, davidk@lysator.liu.se,
	Sergei Organov <osv@javad.com>, Kevin Ryde <user42@zip.com.au>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 18:08:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlO8k-0003io-GQ
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 18:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754170Ab2ALRIb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jan 2012 12:08:31 -0500
Received: from ptmx.org ([178.63.28.110]:37793 "EHLO ptmx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752143Ab2ALRIa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2012 12:08:30 -0500
Received: from localhost (localhost [127.0.0.1])
	by ptmx.org (Postfix) with ESMTP id A3D18257AD;
	Thu, 12 Jan 2012 18:08:29 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at ptmx.org
Received: from ptmx.org ([127.0.0.1])
	by localhost (ptmx.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N86sOjj2nm-9; Thu, 12 Jan 2012 18:08:28 +0100 (CET)
Received: from descartes.localnet (93-82-12-214.adsl.highway.telekom.at [93.82.12.214])
	by ptmx.org (Postfix) with ESMTPSA id 9A407201B8;
	Thu, 12 Jan 2012 18:08:26 +0100 (CET)
User-Agent: KMail/4.7.3 (Linux/3.0.0-14-generic; KDE/4.7.4; x86_64; ; )
In-Reply-To: <20120112162617.GA2479@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188455>

Hi,

On Thursday 12 January 2012 10:26:41 Jonathan Nieder wrote:
> These lines should be left out [*].

Sorry, I wasn't sure whether to remove them or not. I followed the desc=
ription=20
in git-format-patch(1) on how to send patches with kmail. I'll remove t=
hem in=20
the future. Thanks for the advice.
=20
> I assume this was prompted by warning messages like this one:
>=20
> 	In git-blame-cleanup:
> 	git-blame.el:306:6:Warning: `mapcar' called for effect; use `mapc' o=
r
> `dolist' instead
>=20
> Looks reasonable to my very much untrained eyes, and it's consistent
> with the hints Kevin gave at [1].

Yes. I think the warnings are correct and should be addressed. E.g. Usi=
ng=20
mapcar compared to mapc is slower due to the required accumulation of t=
he=20
results and the additional garbage collection costs. It's not very dram=
atic=20
but there is no reason not to fix it imho.

Regards,
R=C3=BCdiger
