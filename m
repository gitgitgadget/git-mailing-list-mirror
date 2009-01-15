From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit state
Date: Thu, 15 Jan 2009 20:27:49 +0100
Message-ID: <8035E52E-D202-4C42-BDFD-DC7A925580A3@wincent.com>
References: <87ab9th0rh.fsf@cup.kalibalik.dk> <7vmydsv72u.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901151921040.3586@pacific.mpi-cbg.de> <200901151946.04991.johan@herland.net>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Jan 15 20:29:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNXuC-0005Ah-5F
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 20:29:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763547AbZAOT2F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jan 2009 14:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763111AbZAOT2E
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 14:28:04 -0500
Received: from wincent1.inetu.net ([209.235.192.161]:37436 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762670AbZAOT2B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jan 2009 14:28:01 -0500
Received: from cuzco.lan (249.pool85-53-13.dynamic.orange.es [85.53.13.249])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n0FJRoau012176
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 15 Jan 2009 14:27:51 -0500
In-Reply-To: <200901151946.04991.johan@herland.net>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105870>

El 15/1/2009, a las 19:46, Johan Herland escribi=F3:

> On Thursday 15 January 2009, Johannes Schindelin wrote:
>> On Thu, 15 Jan 2009, Junio C Hamano wrote:
>>> 'stop' would be closest to what it currently does.  It stops and it
>>> is up to you how to screw up the result ;-).
>>
>> But it shares the first letter with 'squash'.
>
> Personally, I'd rather use "pause", but that is taken as well.
>
> Other suggestions:
>
> wait
> yield
> rest
> timeout

Perhaps stating the obvious, but:

wait - best suggestion so far, seeing as we can't use "stop"

yield - might sound intuitive to a Ruby programmer; but for others =20
it's probably not so obvious as "yield" has a number of meanings in =20
normal English similar to "give up", "give over" etc

rest - not quite as good as "wait"; machines wait for humans, but the =20
never need to rest

timeout - sounds like an error condition, so not really appropriate

Sorry for participating in the painting. Just thought that "wait" was =20
good enough to merit some positive feedback.

Cheers,
Wincent
