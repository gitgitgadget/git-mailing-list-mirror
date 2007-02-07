From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: describe fails on tagless branch
Date: Wed, 07 Feb 2007 13:37:32 +0100
Organization: At home
Message-ID: <eqch3d$5gc$1@sea.gmane.org>
References: <eqb660$ft7$1@sea.gmane.org> <200702070922.57163.andyparkins@gmail.com> <7vy7na8f2t.fsf@assigned-by-dhcp.cox.net> <200702071201.16931.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 07 13:37:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEm2k-0005FP-VJ
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 13:36:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbXBGMg4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 7 Feb 2007 07:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030621AbXBGMg4
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 07:36:56 -0500
Received: from main.gmane.org ([80.91.229.2]:38231 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030283AbXBGMgz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 07:36:55 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HEm2K-0003eK-9K
	for git@vger.kernel.org; Wed, 07 Feb 2007 13:36:32 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 13:36:32 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 13:36:32 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38919>

Andy Parkins wrote:

>> It might not be a bad idea to give '-q' option to make it silent
>> when it fails because the commit is indescribable.
>=20
> I don't think it's worth it. =A0The "-q" be used only in scripts, and=
 in a=20
> script you would do the whole "2> /dev/null || echo 'No tag found'" t=
hing=20
> anyway.

It would be worth for Perl (for gitweb) to be able to use list form of =
magic
open, without spawning shell (and assorted argument quoting troubles), =
but
silently.=20

I think it would be fairly easy to add -q option to git wrapper: it wou=
ld
simply set die, error and warn routines and no-op (no-write) versions.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
