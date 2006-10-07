From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Convert Content-Disposition filenames into qtext
Date: Sat, 07 Oct 2006 11:05:25 +0200
Organization: At home
Message-ID: <eg7qj5$d7d$1@sea.gmane.org>
References: <20061006191801.68649.qmail@web31815.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Oct 07 11:05:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GW87e-0005aN-W3
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 11:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWJGJFZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 7 Oct 2006 05:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWJGJFY
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 05:05:24 -0400
Received: from main.gmane.org ([80.91.229.2]:678 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750858AbWJGJFX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Oct 2006 05:05:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GW87E-0005V5-K5
	for git@vger.kernel.org; Sat, 07 Oct 2006 11:05:05 +0200
Received: from host-81-190-22-223.torun.mm.pl ([81.190.22.223])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Oct 2006 11:05:04 +0200
Received: from jnareb by host-81-190-22-223.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Oct 2006 11:05:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-22-223.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28460>

Luben Tuikov wrote:

> +# Convert a string (e.g. a filename) into qtext as defined
> +# in RFC 822, from RFC 2183. =A0To be used by Content-Disposition.
> +sub to_qtext {
> +=A0=A0=A0=A0=A0=A0=A0my $str =3D shift;
> +=A0=A0=A0=A0=A0=A0=A0$str =3D~ s/\\/\\\\/g;
> +=A0=A0=A0=A0=A0=A0=A0$str =3D~ s/\"/\\\"/g;
> +=A0=A0=A0=A0=A0=A0=A0$str =3D~ s/\r/\\r/g;
> +=A0=A0=A0=A0=A0=A0=A0return $str;
> +}

I'd rather add \n too.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
