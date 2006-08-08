From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-show-refs (was: [PATCH/RFC] gitweb: Great subroutines renaming)
Date: Tue, 08 Aug 2006 20:12:18 +0200
Organization: At home
Message-ID: <ebak5n$etr$1@sea.gmane.org>
References: <200608071626.52655.jnareb@gmail.com> <7v3bc82v7l.fsf@assigned-by-dhcp.cox.net> <eb8cdh$s6n$1@sea.gmane.org> <7v4pwo1a0r.fsf@assigned-by-dhcp.cox.net> <eb8e12$2aa$1@sea.gmane.org> <7vejvsyum8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Aug 08 20:14:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAW4V-0005xq-Bm
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 20:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbWHHSMw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 8 Aug 2006 14:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbWHHSMw
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 14:12:52 -0400
Received: from main.gmane.org ([80.91.229.2]:24012 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030219AbWHHSMw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Aug 2006 14:12:52 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GAW4P-0005vM-Gn
	for git@vger.kernel.org; Tue, 08 Aug 2006 20:12:49 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Aug 2006 20:12:49 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Aug 2006 20:12:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25079>

Junio C Hamano wrote:

> +<format>::
> +=A0=A0=A0=A0=A0=A0=A0A string that interpolates `%(field name)` from=
 the
> +=A0=A0=A0=A0=A0=A0=A0object pointed at by a ref being shown. =A0When
> +=A0=A0=A0=A0=A0=A0=A0unspecified, `%(name)` is used.

Wouldn't it be better to (re)use notation of rpm's --query-format,=20
i.e. use %{name}, or %30{name}, or %-30{name} for single scalar values,
use :typetag output formats, like ':date' (Use strftime(3) "%c" format.=
) and
':day' (Use strftime(3) "%a %b %d %Y" format.) for epoch/timestamp fiel=
d,
use square brackets for iterating over multivalue output, e.g.
"[parent: %{parent}]" for writing out all parents, etc.

Perhaps we could even borrow some code...

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
