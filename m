From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v3] Support ent:relative_path
Date: Sat, 05 May 2007 03:11:27 +0200
Organization: At home
Message-ID: <f1glk1$6qh$1@sea.gmane.org>
References: <463BD40C.6080909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 05 03:11:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk8oR-0003aV-Ft
	for gcvg-git@gmane.org; Sat, 05 May 2007 03:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422642AbXEEBLs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 4 May 2007 21:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423187AbXEEBLs
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 21:11:48 -0400
Received: from main.gmane.org ([80.91.229.2]:52144 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422642AbXEEBLs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 21:11:48 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hk8oH-0004GZ-Hu
	for git@vger.kernel.org; Sat, 05 May 2007 03:11:41 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 May 2007 03:11:41 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 May 2007 03:11:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46235>

Dana How wrote:

> Most commands accept relative paths, =A0but this is
> not true of arguments in ent:path format. =A0This
> patch makes all of the following git-show commands
> work in the git source tree (not just the first):
>
> =A0% cd xdiff
> =A0% git-show v1.5.2-rc0:xdiff/xemit.h
> =A0% git-show v1.5.2-rc0:./xemit.h
> =A0% git-show v1.5.2-rc0:../sha1_name.c
>=20
> It also adds ent:?string as a synonym for ent:/string .
> This makes the following changes possible later:
> ent:/path is an absolute path and ent:path is relative.

=46irst, we now usually use 'tree-ish' or 'treeish', not 'ent'.
Second, it is ':/<text>', not '<tree-ish>:/<text>'

git-rev-parse(1):

 * A colon, followed by a slash, followed by a text: this names
   a commit whose commit message starts with the specified text.
   This name returns the youngest matching commit which is
   reachable from any ref.  If the commit message starts with a
   '!', you have to repeat that;  the special sequence ':/!',
   followed by something else than '!' is reserved for now.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
