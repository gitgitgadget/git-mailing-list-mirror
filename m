From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: confusion over the new branch and merge config
Date: Fri, 22 Dec 2006 22:04:57 +0100
Organization: At home
Message-ID: <emhh4k$u4q$1@sea.gmane.org>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home> <7vd56cam66.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612221539100.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Dec 22 22:02:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxrXL-00041C-Cc
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 22:02:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbWLVVCg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 22 Dec 2006 16:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752703AbWLVVCg
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 16:02:36 -0500
Received: from main.gmane.org ([80.91.229.2]:40763 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751839AbWLVVCf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 16:02:35 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GxrX8-0002HC-2M
	for git@vger.kernel.org; Fri, 22 Dec 2006 22:02:26 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Dec 2006 22:02:26 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Dec 2006 22:02:26 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35217>

<opublikowany i wys=B3any>

Nicolas Pitre wrote:
> On Thu, 21 Dec 2006, Junio C Hamano wrote:

>> No, the message says "any REMOTE branch" -- refs/heads/next is
>> what it is called at the remote, and that is how the value is
>> expected to be spelled; I think somebody added an example to
>> config.txt recently to stress this. =A0The above error messasge
>> obviously was not clear enough. =A0Rewording appreciated.
>=20
> But wouldn't it be much less confusing if it used the local name for=20
> that remote branch instead? =A0After all it is what should be used wi=
th=20
> git-merge if performed manually, it is what diff, log, and al must us=
e=20
> as well. =A0Why would this need a remote name for something that is a=
=20
> local operation after all? =A0I think "refs/heads/master" is really=20
> ambigous since you might be confused between the local and remote=20
> meaning of it, whereas "origin/master" carries no confusion at all.

Perhaps less confusing, but also less powerfull. Current notation
allows for pulling _without need for tracking branches_.

Although I wonder if it is possible to have multiple branch.<name>.remo=
te,
and branch.<name>.merge always refering to latest remote (octopus if th=
ere
are more than one branch.<name>.merge for remote)...
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
