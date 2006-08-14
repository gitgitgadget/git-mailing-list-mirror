From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH and RFC] gitweb: Remove --full-history from git_history
Date: Mon, 14 Aug 2006 13:10:54 +0200
Organization: At home
Message-ID: <ebplmi$b77$1@sea.gmane.org>
References: <200608091257.19461.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon Aug 14 13:10:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCaLA-0003Zc-IS
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 13:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991AbWHNLKh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 14 Aug 2006 07:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751992AbWHNLKh
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 07:10:37 -0400
Received: from main.gmane.org ([80.91.229.2]:8916 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751991AbWHNLKg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Aug 2006 07:10:36 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GCaKv-0003W0-H3
	for git@vger.kernel.org; Mon, 14 Aug 2006 13:10:25 +0200
Received: from host-81-190-23-158.torun.mm.pl ([81.190.23.158])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:10:25 +0200
Received: from jnareb by host-81-190-23-158.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:10:25 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-158.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25349>

Jakub Narebski wrote:

> PROPOSAL:
> ---------
>=20
> Implement --follow/--follow-path/--follow-contents option to git-rev-=
list,
> which would output besides revision ids also current path limit; the
format
> could be for example:
>=20
> =A0 <commit> [ -- <paths>...]
>=20
> for example:
> $ git rev-list --follow db58b69ba -- gitweb/test/file+plus+sign
> 0a8f4f0020cb35095005852c0797f0b90e9ebb74 -- gitweb/test/file+plus+sig=
n
> 85852d44e48c1d1c6d815cc5fccf1b580f2f2cad -- test/file+plus+sign
> cc3245b6512a01d74c0fd460d762ba8a1e8b968a -- test/file+plus+sign

And of course git-diff-tree --stdin should accept not only list
of revisions or list of tree pairs, but also path limits.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
