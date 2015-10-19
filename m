From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git bug report: git doesn't change working directory
Date: Mon, 19 Oct 2015 18:33:40 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1510191831130.31610@s15462909.onlinehome-server.info>
References: <loom.20151017T034154-956@post.gmane.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1784107012-22421922-1445272421=:31610"
Cc: git@vger.kernel.org
To: =?VISCII?Q?Kh=E4i?= <hvksmr1996@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 18:33:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoDNc-0005bR-T7
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 18:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753593AbbJSQdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 12:33:43 -0400
Received: from mout.gmx.net ([212.227.15.19]:64825 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750995AbbJSQdm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 12:33:42 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0MYg42-1a22zv1R0E-00VTJm;
 Mon, 19 Oct 2015 18:33:41 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <loom.20151017T034154-956@post.gmane.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:Rn8iyruge+Ca65uyAgYmXnpGrPSRb7pLQvtGwde1vNQA0GHG72W
 jpWSRWZi1cj6MA8tpODh3CGYbrle0Y2TnJ78kxM+CuIg39p1VceR88Y/51KapzXtoxwz/G8
 ++BPHBFVgPtXMfvCx3ghSPmZ9CM1BmRlyqs/bxKwt8BDjaXIDljlu49OOuKmZo5YQS6kDGn
 G72dYZ/5d0h6i3KPXfLWg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BewviKyYnAI=:5qmuiDmOrm3bkq6Rw/6zd2
 w7FJ/2PVM89Sb3D2mSzlbVxOymcs3YOrH3GSehsI1BB1PiMRijgFdlyGt+u751FzCIQNTSbJL
 bdS4av7Il9S2LRA/l8w5amfC7EsabEJqvxN/n9VAJfwgwLhJ0Vn4KC3obG8YImha0470Sag1K
 fojBmj3e9x+YvrF3QXkpMqwPHNGCx8h6aswzlb5/wEJUDS/ppvC6Kr0D9zRylaRw7O3eoZmNs
 hU6w9PSCrntivGC+hCDaVp9LiG1obAh1McKvWsSk0SnD+ZoLkntLcGtLnyDw/ciMeIWgMNFY7
 xvGaGYQMZnLt6Sx4hG07iW9tTOhLBgh56bBZCX2m+gwtuDJn4sQrF2JZE+vTgyUMehHjgE4Pe
 O3Hm8XqvQEpDFlUr3WdSzerGw8wtSpv49BwqEvSdoBAm2KkR2/bnmSfBUykyO8LirSEfVkgtl
 FOd54Kgv/v4IF6zE130e18E35d1RFljTaqpe+es5csgClvSHeBoDjjASw+jHwX0kWAxTcBXFY
 mITmBG3zuyGRRQs2l7hCNF4isczKFxUaF3uaoGIRLSIRgkseYHxh0oljaz9iz/qaJeW09/Gh9
 ssW1YWuQgnw/pK6Xz08sjct+9SbiMo6ugRs4hVtjqedHIBUYAmdQZLvmC1+OrBa06Yvf1wxuA
 KOLw8G8XnvJMo+CQffYB26qsSVNuz0LPKbAEVbZjK7OzKm9Y7sMf31Mn67L8oiEZE71sDZijt
 7ZNoloZAIKZ9OsG0W1jH8Xo70EbAX9dZmjvyR9eGtAVvdu1zBvYII58oZnx5haVPJehcUb2Z 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279875>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1784107012-22421922-1445272421=:31610
Content-Type: TEXT/PLAIN; charset=VISCII
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kh=E4i,

On Sat, 17 Oct 2015, Kh=E4i wrote:

> I'm using Windows 10. Before I install git 2.6.1.windows.1, I have
> installed git 1.9.5.github.0 (by installing GitHub Desktop), it works
> just fine.

Good.

> But when I installed git 2.6.1.windows.1 (from git-scm.com), I'm not
> able to use git anymore:
>
>  - The powershell console displayed [(unknown)] instead of [master], even=
=20
> when I changed working directory to my project, it still display=20
> [(unknown)]
>
>  - When I "git add" (or "git commit", "git push"), It told me an error:=
=20
> "fatal: Not a git repository: 'C:\Program Files\Git'"

Unfortunately, this is not enough information. Which options did you
choose during installation? How do you modify the PATH to be able to run
Git from Powershell? What code do you use to display `[(unknown)]`
(Powershell has *no* Git integration by default)?

Ciao,
Johannes
--1784107012-22421922-1445272421=:31610--
