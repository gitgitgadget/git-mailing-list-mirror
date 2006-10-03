From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] Move code resolving packed refs into its own function.
Date: Tue, 03 Oct 2006 14:10:15 +0200
Organization: At home
Message-ID: <eftjua$2ii$1@sea.gmane.org>
References: <20060930220158.d331bb7c.chriscool@tuxfamily.org> <7vmz8hccxl.fsf@assigned-by-dhcp.cox.net> <200610010606.32561.chriscool@tuxfamily.org> <7vodsw2w9g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Oct 03 14:13:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUj8Z-00035I-GV
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 14:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWJCMMR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 3 Oct 2006 08:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWJCMMR
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 08:12:17 -0400
Received: from main.gmane.org ([80.91.229.2]:9628 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750746AbWJCMMQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Oct 2006 08:12:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GUj6e-0002gp-6E
	for git@vger.kernel.org; Tue, 03 Oct 2006 14:10:40 +0200
Received: from host-81-190-17-45.torun.mm.pl ([81.190.17.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Oct 2006 14:10:40 +0200
Received: from jnareb by host-81-190-17-45.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Oct 2006 14:10:40 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-45.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28266>

Junio C Hamano wrote:

> =A0- I think gitweb should be Ok; it does peek-remote on the
> =A0 =A0repository. =A0Although we would probably want to update
> =A0 =A0git_get_references and git_get_refs_list sub to use
> =A0 =A0for-each-ref there, that can be done as a later optimization.

I'd rather have gitweb use git-for-each-ref after the command
is in the official release... if not, then keep it in the 'next'
branch.

By the way, I have an idea to join the git-show-ref and git-for-each-re=
f:
simply add --deref option to git-for-each-ref, which would output
dereferenced tag just after the reference itself (well, perhaps with th=
e
exception when sorting, perhaps not), with the deref name like in
git-show-ref and git-peek-remote, i.e. <ref>^{}
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
