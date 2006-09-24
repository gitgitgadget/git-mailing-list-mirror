From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Add committags support
Date: Sun, 24 Sep 2006 11:37:45 +0200
Organization: At home
Message-ID: <ef5jkv$gep$1@sea.gmane.org>
References: <200609212356.31806.jnareb@gmail.com> <20060923032948.GE8259@pasky.or.cz> <200609231034.49545.jnareb@gmail.com> <20060923121134.GM13132@pasky.or.cz> <7veju2s6bi.fsf@assigned-by-dhcp.cox.net> <ef44r4$km0$1@sea.gmane.org> <7v4puys3ye.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Sep 24 11:38:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRQR7-0002SV-FB
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 11:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbWIXJhz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 24 Sep 2006 05:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751831AbWIXJhz
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 05:37:55 -0400
Received: from main.gmane.org ([80.91.229.2]:2286 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751854AbWIXJhy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 05:37:54 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GRQQj-0002NG-9B
	for git@vger.kernel.org; Sun, 24 Sep 2006 11:37:45 +0200
Received: from host-81-190-26-109.torun.mm.pl ([81.190.26.109])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 24 Sep 2006 11:37:45 +0200
Received: from jnareb by host-81-190-26-109.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 24 Sep 2006 11:37:45 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-109.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27649>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
>=20
>> The idea of doing committag parsing, and preserving replacements
>> from matching committag and being subject to HTML escaping by using
>> reference to string has it's merits.
>>
>> I'd have to think about it.
>=20
> Good. =A0My obviously buggy illustration would be easier to read
> with this patch ;-).

Don't forget about final s,\n,<br/>\n,gm if we parse it as a whole,
and not line by line.=20

By the way, I think that only the driver (i.e. format_log_line_html) ha=
s to
be changed...
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
