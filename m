From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Support ent:relative_path
Date: Sat, 05 May 2007 01:36:21 +0200
Organization: At home
Message-ID: <f1gg1o$p52$2@sea.gmane.org>
References: <463ADE51.2030108@gmail.com> <56b7f5510705040022x2e4903d3hbe4ac1ee1a2e096f@mail.gmail.com> <7v7irpuhhr.fsf@assigned-by-dhcp.cox.net> <81b0412b0705040147h1bab8f6ao3ce2c486637a0d4f@mail.gmail.com> <463AFAAE.853DEF7B@eudaptics.com> <7vabwktsng.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 05 01:40:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk7O0-0000F0-9H
	for gcvg-git@gmane.org; Sat, 05 May 2007 01:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422772AbXEDXkT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 4 May 2007 19:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755434AbXEDXkS
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 19:40:18 -0400
Received: from main.gmane.org ([80.91.229.2]:40589 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422782AbXEDXgg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 19:36:36 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hk7KB-00005p-FQ
	for git@vger.kernel.org; Sat, 05 May 2007 01:36:31 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 May 2007 01:36:31 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 May 2007 01:36:31 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46229>

Junio C Hamano wrote:

> (soon after 1.5.2)
>=20
> =A0- start accepting "<something>:./<path>" as "relative to where I a=
m".
> =A0- start accepting "<something>:?<string>" as "look back to find
> =A0 =A0the string".
> =A0- clearly explain the plan and prepare the users.
>=20
> (a big release in the future, perhaps 1.6.0)
>=20
> =A0- "<something>:<path>" becomes relative to where you are.
> =A0- stop "<something>:/<string>" and start "<something>:/<fullpath>"=
=2E

I'm not sure about "<tree-ish>:<path>" with <path> being relative by
default. For me it is <path> in <tree-ish> (like in=20
"git-ls-tree -r <tree-ish>" result).

The "<tree-ish>:./<path>" is a good syntax I think.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
