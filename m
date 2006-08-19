From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Support for snapshot
Date: Sat, 19 Aug 2006 13:09:34 +0200
Organization: At home
Message-ID: <ec6rha$aal$3@sea.gmane.org>
References: <44E54AC6.9010600@gmail.com> <20060818195148.66411.qmail@web31807.mail.mud.yahoo.com> <7v64gp7prk.fsf@assigned-by-dhcp.cox.net> <cc723f590608190110t68e6de8etbf6b5b002fd83ca1@mail.gmail.com> <7virkp3snv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Aug 19 13:09:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEOi7-0001zu-2D
	for gcvg-git@gmane.org; Sat, 19 Aug 2006 13:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbWHSLJs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 19 Aug 2006 07:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751715AbWHSLJr
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Aug 2006 07:09:47 -0400
Received: from main.gmane.org ([80.91.229.2]:10894 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751701AbWHSLJr (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Aug 2006 07:09:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GEOht-0001yz-Lz
	for git@vger.kernel.org; Sat, 19 Aug 2006 13:09:37 +0200
Received: from host-81-190-24-244.torun.mm.pl ([81.190.24.244])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 19 Aug 2006 13:09:37 +0200
Received: from jnareb by host-81-190-24-244.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 19 Aug 2006 13:09:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-244.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25715>

Junio C Hamano wrote:

> +sub feature_snapshot {
> +=A0=A0=A0=A0=A0=A0=A0my ($ctype, $suffix, $command) =3D @_;
> +=A0=A0=A0=A0=A0=A0=A0my ($val) =3D git_get_project_config('snapshot'=
);
> +=A0=A0=A0=A0=A0=A0=A0if ($val eq 'gzip') { return ('gzip', 'gz'); }
> +=A0=A0=A0=A0=A0=A0=A0elsif ($val eq 'bzip2') { return ('bzip2', 'bz2=
'); }
> +=A0=A0=A0=A0=A0=A0=A0elsif ($val eq 'none') { return (); }
> +
> +=A0=A0=A0=A0=A0=A0=A0return ($ctype, $suffix, $command);
> +}

Should it be ('x-gzip', 'gzip', 'gz') and ('x-bzip2', 'bzip2', 'bz2'),
i.e. with $ctype first?

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
