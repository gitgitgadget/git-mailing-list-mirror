From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] Re: Probably a bug with "~" symbol in filenames on
 Windows 7 x64 in git 1.9.5
Date: Thu, 8 Jan 2015 16:58:24 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1501081652230.21312@s15462909.onlinehome-server.info>
References: <CADb7K9rELHWgy_NYJWrSr9gZn7pcMvETv93d0j+u2fXinj5iTg@mail.gmail.com> <CAPc5daVddkaMkx=43nCeQKbbkrV6nExOqvEBJNyugzDQB2n6kQ@mail.gmail.com> <alpine.DEB.1.00.1501081100570.21312@s15462909.onlinehome-server.info> <20150108102815.GA4806@peff.net>
 <54AE7F46.9060103@web.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1784107012-2076956452-1420732705=:21312"
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Dmitry Bykov <pvrt74@gmail.com>, msysgit@googlegroups.com
To: =?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jan 08 17:00:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9FU0-0006OX-C6
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 16:58:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754972AbbAHP6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 10:58:44 -0500
Received: from mout.gmx.net ([212.227.17.22]:50297 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754556AbbAHP6n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 10:58:43 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0Lm2lZ-1XaBhw3ivR-00Zg8u;
 Thu, 08 Jan 2015 16:58:25 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <54AE7F46.9060103@web.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:pFzWWET1DvdnuOr3NmSo6pEeKKS+qlsk7pJhvPgIM7I46ocgdk5
 dnV/iYsmkph1lzI5ZfUttfroIXriUxu/+Tih11xJrk2SyPBdnzxYFZbylwOJmb7G4R9Y2cc
 PMJiccsQc9zK2rG56RiH3cYA6HYcD8A48NhdOK7IHou49EJnSrUyfeDyaa02lXXtR+b766Q
 SVqPEOh8klObIWRngPk4w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262197>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1784107012-2076956452-1420732705=:21312
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Torsten,

On Thu, 8 Jan 2015, Torsten B=C3=B6gershausen wrote:

> There is something more then just the "tilde" protection going on, [...]

Indeed. What is going on is that you build Git yourself, from git.git,
while Dmitry obviously used Git for Windows -- which carries a couple of
patches on top of upstream git.git.

In this particular case, the tilde protection was introduced in
https://github.com/msysgit/git/commit/2e2a2d12.

Ciao,
Johannes
--1784107012-2076956452-1420732705=:21312--
