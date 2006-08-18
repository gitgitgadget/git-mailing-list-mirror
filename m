From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Unresolved issues #3
Date: Fri, 18 Aug 2006 10:56:36 +0200
Organization: At home
Message-ID: <ec3va4$ru1$1@sea.gmane.org>
References: <7vpseyelcw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Aug 18 10:56:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE09D-0006RD-IW
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 10:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWHRI4H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 18 Aug 2006 04:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWHRI4H
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 04:56:07 -0400
Received: from main.gmane.org ([80.91.229.2]:56241 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751281AbWHRI4G (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Aug 2006 04:56:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GE08v-0006Ms-V4
	for git@vger.kernel.org; Fri, 18 Aug 2006 10:55:54 +0200
Received: from host-81-190-24-244.torun.mm.pl ([81.190.24.244])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Aug 2006 10:55:53 +0200
Received: from jnareb by host-81-190-24-244.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Aug 2006 10:55:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-244.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25637>

Junio C Hamano wrote:

> * Jeff Garzik reports that the summary page of gitweb does not
> =A0 look at anything other than "master" which is not appropriate
> =A0 for his tree.
>=20
> =A0 Message-ID: <44D874F0.6000907@garzik.org>
>=20
> =A0 I probably should bug gitweb gang (Jakub, Luben, Martin Waitz,
> =A0 Aneesh) about this.

=46or performance reasons this should probably wait for functioning
git-show-refs command. BTW. summary page doesn't show "Last Updated" ba=
sed
on "master", but based on "HEAD" (current branch)... which usually is
"master" I guess in typical usage.

Another thing that I think is/might be important to gitweb, is to rewri=
te
commitdiff and blobdiff to not use external diff, but builtin
git-diff-tree... this probably would lead to changes in the output.
I'm thinking about "-B" without "-C" nor "-M" for plain output (is this
no-op for this combination?), and "-C", "-M" for HTML output.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
