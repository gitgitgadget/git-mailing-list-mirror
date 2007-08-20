From: Florian Weimer <fweimer@bfk.de>
Subject: Re: [PATCH] Document what the stage numbers in the :$n:path syntax mean.
Date: Mon, 20 Aug 2007 09:15:01 +0200
Message-ID: <828x86ad8q.fsf@mid.bfk.de>
References: <7v1we5bvbw.fsf@assigned-by-dhcp.cox.net>
	<20070814231422.GA10662@pe.Belkin>
	<7vps1paceh.fsf@assigned-by-dhcp.cox.net>
	<46C90C46.1030000@midwinter.com>
	<20070820055221.GA22993@coredump.intra.peff.net>
	<20070820060522.GA27913@spearce.org>
	<20070820061330.GB27913@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Steven Grimm <koreth@midwinter.com>,
	Junio C Hamano <gitster@pobox.com>,
	Chris Shoemaker <c.shoemaker@cox.net>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Aug 20 09:15:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN1UD-00045L-Kz
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 09:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbXHTHPi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 20 Aug 2007 03:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbXHTHPi
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 03:15:38 -0400
Received: from mx01.bfk.de ([193.227.124.2]:56902 "EHLO mx01.bfk.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314AbXHTHPh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Aug 2007 03:15:37 -0400
Received: from mx00.int.bfk.de ([10.119.110.2])
	by mx01.bfk.de with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	id 1IN1Tt-0000OD-CZ; Mon, 20 Aug 2007 09:15:21 +0200
Received: from fweimer by bfk.de with local id 1IN1TZ-00085j-Kg; Mon, 20 Aug 2007 09:15:01 +0200
In-Reply-To: <20070820061330.GB27913@spearce.org> (Shawn O. Pearce's message of "Mon, 20 Aug 2007 02:13:30 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56182>

* Shawn O. Pearce:

>> I've memorized it long long ago.  But my coworkers haven't and alway=
s
>> get it wrong, and look at me funny when I tell them "trust me, your
>> data is in stage 2 and theirs is in stage 3...  because that's the
>> convention all of the tools you are using follows".
>
> Actually, what's wrong with the following:
>
> 	git show HEAD:foo.c
> 	git show MERGE_HEAD:foo.c
>
> ?

I think that in the staged versions, the non-conflicting parts of the
merge are in fact merged.  For the HEAD/MERGE_HEAD versions, this
isn't the case, obviously.

--=20
=46lorian Weimer                <fweimer@bfk.de>
BFK edv-consulting GmbH       http://www.bfk.de/
Kriegsstra=DFe 100              tel: +49-721-96201-1
D-76133 Karlsruhe             fax: +49-721-96201-99
