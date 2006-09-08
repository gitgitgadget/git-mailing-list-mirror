From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Very complex rebasing - Need help
Date: Fri, 08 Sep 2006 15:43:09 +0200
Organization: At home
Message-ID: <edrs0d$42k$1@sea.gmane.org>
References: <6208897.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Sep 08 15:43:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLgdk-0006pj-7q
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 15:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWIHNnZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 8 Sep 2006 09:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWIHNnZ
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 09:43:25 -0400
Received: from main.gmane.org ([80.91.229.2]:44772 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751113AbWIHNnY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Sep 2006 09:43:24 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GLgdV-0006mh-4p
	for git@vger.kernel.org; Fri, 08 Sep 2006 15:43:13 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Sep 2006 15:43:13 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Sep 2006 15:43:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26698>

Jehreg wrote:

> In the Buildroot repo:
> initial--o--o--ID3--o--o--ID4--o--master
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0--o--o--o--o--o--o--o--o--mypr=
oject
>=20
> My problem is that I need to kinda-rebase the ID4 into the myproject
branch
> to make it finally look like this:
>=20
> initial--o--o--ID3--o--o--ID4--o--master
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \ =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0--o--o--o--o--o--x--o--o--mypr=
oject
>=20
>=20
> Any ideas ?

Grafts? Grafting additional parent to commit x.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
