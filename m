From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Fri, 07 Jun 2013 19:57:21 +0200
Message-ID: <vpqhah9248u.fsf@anie.imag.fr>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<7va9n52zjc.fsf@alter.siamese.dyndns.org>
	<rmivc5rp9w2.fsf@fnord.ir.bbn.com>
	<alpine.DEB.1.00.1306061818191.28957@s15462909.onlinehome-server.info>
	<CALkWK0n2VsEP31jMB2kZ4x=wa90o8QPkR=ZWETfm=H5RC1kKcg@mail.gmail.com>
	<alpine.DEB.1.00.1306070518510.28957@s15462909.onlinehome-server.info>
	<CALkWK0nUoF2VX6Ns09vQHYo11520_4r9ikYmkZW108aQm1RpoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Greg Troxel <gdt@ir.bbn.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?iso-8859-1?Q?R?= =?iso-8859-1?Q?en=E9?= Scharfe 
	<rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?iso-8859-1?Q?Nguy=ADn_Th=E1i_Ng=F7c?= Duy <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 19:58:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul0vY-0001DT-8b
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 19:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756072Ab3FGR6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 13:58:12 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35974 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755983Ab3FGR6L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 13:58:11 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r57HvJPE030328
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 7 Jun 2013 19:57:19 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Ul0uf-0002P2-C2; Fri, 07 Jun 2013 19:57:21 +0200
In-Reply-To: <CALkWK0nUoF2VX6Ns09vQHYo11520_4r9ikYmkZW108aQm1RpoQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 7 Jun 2013 20:50:36 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 07 Jun 2013 19:57:23 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r57HvJPE030328
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1371232646.18556@ttdA+bY5/ggovzZnPfMOwQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226657>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Johannes Schindelin wrote:
>> On Fri, 7 Jun 2013, Ramkumar Ramachandra wrote:
>>> Johannes Schindelin wrote:
>>> > My initial reaction, too. It was hard enough to get Perl included with Git
>>> > for Windows (because of that pesky Subversion dependency).
>>>
>>> Nevertheless, we had to do it, and we did it.
>>
>> That is not quite correct. *I* did it. Not *we*. And I will not do it
>> again.
>
> When I say "we", I mean the git community.

I think it should be "the Git for Windows community", and my feeling is
that the community developing Git for POSIX systems is far more active
than the one making it work for Windows (although we may now have more
windows users than unix users).

Reading Git for Windows's FAQ
( https://github.com/msysgit/msysgit/wiki/Frequently-Asked-Questions ),
it seems rather clear that the TODO-list is already long to have a
correct Perl support (I'm quite admirative of the work done already).
The POSIX guys shouldn't move faster than the Windows guys can follow.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
