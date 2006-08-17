From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb: Support for snapshots in gitweb
Date: Thu, 17 Aug 2006 11:49:03 +0200
Organization: At home
Message-ID: <ec1e0j$bqr$1@sea.gmane.org>
References: <44E263DD.6030305@cam.ac.uk> <ebupuk$dgl$1@sea.gmane.org>	<44E2F911.6060002@gmail.com> <7v4pwc4l0y.fsf@assigned-by-dhcp.cox.net> <44E40CB1.7040805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Aug 17 11:48:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDeUA-0005tu-2u
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 11:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWHQJsT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 17 Aug 2006 05:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWHQJsS
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 05:48:18 -0400
Received: from main.gmane.org ([80.91.229.2]:39391 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932405AbWHQJsS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Aug 2006 05:48:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GDeTy-0005sP-R1
	for git@vger.kernel.org; Thu, 17 Aug 2006 11:48:10 +0200
Received: from host-81-190-24-196.torun.mm.pl ([81.190.24.196])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Aug 2006 11:48:10 +0200
Received: from jnareb by host-81-190-24-196.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Aug 2006 11:48:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-196.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25577>

Aneesh Kumar K.V wrote:

> +=A0=A0=A0=A0=A0=A0=A0print $cgi->header(-type=3D>'application/x-tar'=
, -Content-Encoding=3D>'x-gzip',
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0'-content-disposition' =
=3D> "inline; filename=3D\"$project.tar.gz\"",
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0-status=3D> '200 OK');

Wouldn't it be better to put $hash somewhere in the name?

And please remember that $project can contain slashes, so it should be =
processed
(only basename of $project, perhaps).

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
