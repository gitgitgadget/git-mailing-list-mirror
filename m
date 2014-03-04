From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: git compile with debug symbols
Date: Tue, 4 Mar 2014 17:53:25 +0000 (UTC)
Message-ID: <loom.20140304T184714-119@post.gmane.org>
References: <1393947964.16150.YahooMailNeo@web162902.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 18:53:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKtXQ-0006wO-Oi
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 18:53:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754957AbaCDRxv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Mar 2014 12:53:51 -0500
Received: from plane.gmane.org ([80.91.229.3]:41340 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753648AbaCDRxv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 12:53:51 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WKtXJ-0006sZ-EK
	for git@vger.kernel.org; Tue, 04 Mar 2014 18:53:50 +0100
Received: from triband-del-59.178.49.0.bol.net.in ([triband-del-59.178.49.0.bol.net.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 18:53:49 +0100
Received: from tanayabh by triband-del-59.178.49.0.bol.net.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 18:53:49 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 59.178.49.0 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Firefox/24.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243362>

Mahesh Pujari <pujarimahesh_kumar <at> yahoo.com> writes:

>=20
>=20
> Hello,
> =C2=A0I am trying to compile git with debug symbols and failed to do =
so
(basically I am a noob), can some one direct
> me to links or mailing list (have searched but couldn't find) or doc'=
s so
that I can debug git using gdb.
>=20
> thanks,
> mpujari
>=20
>=20


Hi,

I tried to put a break point at help.c:396 and it was successful . I th=
ink
that the problem is either your symbols are not loaded.
Nevertheless I will walk you through the steps.

$ git clone https://github.com/git/git
$ make
$ gdb ./git
$(gdb)> gdb break help.c:396
Breakpoint 1 at 0x80f8b40: file help.c, line 396.

Cheers,
Tanay Abhra.
