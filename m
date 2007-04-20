From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Fri, 20 Apr 2007 02:30:41 +0200
Organization: At home
Message-ID: <f091c7$grp$1@sea.gmane.org>
References: <200704171041.46176.andyparkins@gmail.com> <7v7isbpb0p.fsf@assigned-by-dhcp.cox.net> <200704171235.34793.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 20 02:27:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hegy1-0003nB-Pd
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 02:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbXDTA1F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 19 Apr 2007 20:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752262AbXDTA1F
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 20:27:05 -0400
Received: from main.gmane.org ([80.91.229.2]:40313 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691AbXDTA1B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 20:27:01 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hegxn-0007VT-5M
	for git@vger.kernel.org; Fri, 20 Apr 2007 02:26:59 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Apr 2007 02:26:59 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Apr 2007 02:26:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45050>

Andy Parkins wrote:

>> =A0* We do not do the borrowing from working tree when doing
>> =A0 =A0grep_sha1(), but when we grep inside a file from working tree
>> =A0 =A0with grep_file(), we do not currently make it go through
>> =A0 =A0convert_to_git() to fix line endings. =A0Maybe we should, if
>> =A0 =A0only for consistency.
>=20
> I'd actually argue not - git-grep searches the working tree. =A0The e=
xpanded=20
> keywords are in the working tree. =A0Take the CRLF case - I'm a cluel=
ess user,=20
> who only understands the system I'm working on. =A0I want to search f=
or all the=20
> line endings, so I do git-grep "\r\n" - that should work, because I'm=
=20
> searching my working tree.

Actually, "git grep" can search both the working tree (default), but al=
so
an index (--cached), or specified tree (or tree-ish). The same with
"git diff": it can work on tree (repository), index, working tree versi=
on,
now I think in [almost] any combination.=20

Think what keyword expansion means to all this... Well, you can have -k=
k
to expand/not expand keywords, but this is avoiding issue, not solving =
it
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
