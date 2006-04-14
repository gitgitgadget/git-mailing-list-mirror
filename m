From: =?ISO-8859-1?Q?S=E9bastien?= Pierre <sebastien@xprima.com>
Subject: Re: git log is a bit antisocial
Date: Fri, 14 Apr 2006 18:15:05 -0400
Organization: XPrima
Message-ID: <1145052905.27704.8.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0604141647360.2215@localhost.localdomain>
	 <7vlku7q3k7.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0604141719290.2215@localhost.localdomain>
	 <7vhd4vq23h.fsf@assigned-by-dhcp.cox.net>
	 <1145051072.27704.1.camel@localhost.localdomain>
	 <7vu08volrp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Apr 15 00:15:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUWZH-00010u-Q6
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 00:15:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWDNWPD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 14 Apr 2006 18:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030211AbWDNWPD
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 18:15:03 -0400
Received: from ritalin.autolinq.com ([207.96.225.42]:24480 "HELO
	ritalin.autolinq.com") by vger.kernel.org with SMTP
	id S1030212AbWDNWPB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Apr 2006 18:15:01 -0400
Received: (qmail-ldap/ctrl 24585 invoked from network); 14 Apr 2006 22:15:00 -0000
Received: from unknown (HELO ?10.0.0.14?) ([207.96.159.2]) (envelope-sender <sebastien@xprima.com>)
          by ritalin.autolinq.com (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 14 Apr 2006 22:15:00 -0000
To: git@vger.kernel.org
In-Reply-To: <7vu08volrp.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18706>

Le vendredi 14 avril 2006 =C3=A0 15:06 -0700, Junio C Hamano a =C3=A9cr=
it :

> Have you read the patch, especially the comment in it?  With and
> without the patch, this command would behave quite differently:

I did not realize that at first (I thought this would be a fallback
method).=20

Anyway, on git 1.2.3, here is something interesting:

>> git log -h
fatal: Not a git repository

>> git log --help
Usage: /home/sebastien/Local/bin/git-log [--max-count=3D<n>]
[<since>..<limit>] [--pretty=3D<format>] [git-rev-list options]

Which is confusing, so having a consistent behaviour for "git help cmd"=
,
"git cmd help", "git cmd -h" and "git cmd --help" would be nice.

=46or instance, Darcs works just like that, which makes it easy for
newbies to find there ways through.

 -- S=C3=A9bastien
