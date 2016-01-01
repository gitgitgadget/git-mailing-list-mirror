From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] commit: ensure correct permissions of the commit
 message
Date: Fri, 1 Jan 2016 16:04:25 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601011604070.14434@virtualbox>
References: <4aa11f02f4de113bf38152b8815658da42690f43.1450549280.git.johannes.schindelin@gmx.de> <20151220074559.GF30662@sigill.intra.peff.net> <xmqq7fk8io3f.fsf@gitster.mtv.corp.google.com> <20151221065944.GA3550@sigill.intra.peff.net>
 <xmqqio3rhg2f.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1512301535550.14434@virtualbox> <xmqqfuyjczpv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Yaroslav Halchenko <yoh@onerussian.com>,
	=?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 01 16:04:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aF1GE-0006fY-3H
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jan 2016 16:04:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbcAAPEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jan 2016 10:04:55 -0500
Received: from mout.gmx.net ([212.227.17.20]:63250 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751840AbcAAPEx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jan 2016 10:04:53 -0500
Received: from virtualbox ([37.24.143.189]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LyVcA-1a8uqo0PyA-015rjv; Fri, 01 Jan 2016 16:04:28
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqfuyjczpv.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:gqIWXUIbxPQ7BmADr5fY0slyuQsYYkLi5SN2rXe5jbwZHw9y5Du
 PC8L0a/+PqbNyda6urbT1x+DW509u1gv0D7hGD93A6dKZfrTdJ2Rvx2cyhaIbE7uj3kB2BS
 0/bg+2lzCL7EO3F2BlEbQNRi9DvyOd0x7b+h/qgCoSM00z6H0DFdJ187hIV+a3GqzlfFlpd
 Dxs3/1qs9YmPrgzawm47A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hq0CmvS6Y8g=:yl8Dibi8aFxrT8u2pnOZZq
 HJYEpCQf6P7YtJUp+TT24zFDsV4Yw6tK8rrjUXEKZiud29YhtyhypJzV+0fYAztV58M9vfp21
 RjuGAoWUVUNcalPSaDvQTB9vEdy790lsWAGr6gQ0MKsKlh9/KtFhUlLryEi3F0eG8zq293heW
 mE/wsFzHUmhINEY+P4tRNqZGW0LsNoWzXq1vLojyxQi8F2qtx8uTu1ZHi+Q5HPzIG/7VpNHRc
 uL2bdzCqLz7c+2cCISv1XsA7du/JO+pomJFT8qDTBDPKeMPqw/sz4SRdfkULh63JjGdOWXZ6n
 As6wYvB4//uqfu3gH5XjwpnKtuLvncDcECU6ocecBqaWCAONTz+lm0zFzscnhEDsG5bFsIk3h
 kiYs4m+DibUqvbTQgcX6NB8Q4ZvRremxZEtgiohcr1+Mt3g2rLE8imo3hr5eOywXCD2639Z0y
 Mb/n4HtgiEfNamahPx8QFHushKXtHpL3zqw41dwggOQhv3JRMW1d7yeXxz9tQmaDNGGGXoQ43
 /8AXjKKUVBTFdKS2nXZ1gheMdVf+fd8bZo4X4Lq1drjPF/pwlmtEOl+QI0ofAm4lFQSZr/ty+
 UHf/F1BxYppvDrzrime78O+7RRAixA9IhfyEgHmhmwNH7S7FsF9zwL4rXWe0H8i9X+Go13vwD
 8NjSz+PlIoxFkOV1vv+fsDBawfjT/FDjaSccFg0JI249nt+3Adfudk10jF4OwGhljz15VlnrD
 UKkpOUGz2vW+ViQQ4SeBRzit1NzykC+82doNj4sh9bmAf97ceKK1q882j8u5+0HqIzmzcxZo 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283254>

Hi Junio,

On Wed, 30 Dec 2015, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > So maybe
> >
> > 	fcreate_or_truncate(const char *path)
> > 	{
> > 		 FILE *ret = fopen(path, "w");
> >
> > 		 if (!ret && errno == EPERM) {
> > 			 if (!unlink(path))
> > 				 ret = fopen(path, "w");
> > 			 else
> > 				 errno = EPERM;
> > 		 }
> > 		 return ret;
> > 	 }
> >
> > ?
> 
> I do not know fcreate_or_truncate() is a good name, though.

So what would be a good name?

Ciao,
Dscho
