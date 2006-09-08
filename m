From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Fri, 08 Sep 2006 02:44:37 +0200
Organization: At home
Message-ID: <edqeco$ums$1@sea.gmane.org>
References: <200609021817.09296.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Sep 08 02:45:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLUUL-0005X5-9o
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 02:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbWIHAoo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 7 Sep 2006 20:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbWIHAoo
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 20:44:44 -0400
Received: from main.gmane.org ([80.91.229.2]:48618 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751954AbWIHAon (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Sep 2006 20:44:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GLUTx-0005Q4-HH
	for git@vger.kernel.org; Fri, 08 Sep 2006 02:44:33 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Sep 2006 02:44:33 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Sep 2006 02:44:33 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26669>

Jakub Narebski wrote:

> * Committags support, i.e. extend hyperlinking commit sha1 to commit
> =A0 view to hyperlinking bug #nn/BUG(nn) to the proper bugtracker, in=
 both
> =A0 commit message view and (harder to do properly) in commit
> =A0 title/subject line which is hyperlink itself. The problem is how =
to do
> =A0 this general enough...
>=20
> =A0 I have thought about structure somewhat similar to %feature hash,=
 i.e.
> =A0 something like %commitfilter hash, with 'enabled', 'override', 'n=
ame',
> =A0 'options' or something like that and of course 'sub' (as we proba=
bly
> =A0 would use $cgi->a(...) to construct hyperlink, and not simple reg=
exp
> =A0 replacement.

I have very preliminary work, where gitweb uses @enabled_committags as =
list
of committags to use, and %committags_info for actual committags info.
Examples of committags includes current linking of commit sha1,
gitweb-xmms2 linking of BUG(n) and FEATURE(n) to site-wide based URL
(Mantis), and RELEASE x.y.z to site-wide based URL (Wiki); perhaps "bug=
 n"
to site-wide/project-wide URL (Bugzilla)... any other ideas?
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
