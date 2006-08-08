From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Since when is a tag a commit?
Date: Tue, 08 Aug 2006 11:34:56 +0200
Organization: At home
Message-ID: <eb9lrm$3ef$1@sea.gmane.org>
References: <20060808021251.GA19548@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Aug 08 11:35:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GANzl-00019f-3f
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 11:35:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWHHJfO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 8 Aug 2006 05:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWHHJfN
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 05:35:13 -0400
Received: from main.gmane.org ([80.91.229.2]:43173 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932164AbWHHJfM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Aug 2006 05:35:12 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GANzH-00013j-4L
	for git@vger.kernel.org; Tue, 08 Aug 2006 11:35:00 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Aug 2006 11:34:59 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Aug 2006 11:34:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25062>

Shawn Pearce wrote:

> Current `next`:
>=20
>   [spearce@pb15 git]$ git cat-file commit v1.4.1
>   tree 34c8f9c263c1c20592d3f56c3d86bea322577155
>   parent 6631c73685bea3c6300938f4900db0d0c6bee457
>   author Linus Torvalds <torvalds@osdl.org> 1151691633 -0700
>   committer Junio C Hamano <junkio@cox.net> 1151803695 -0700
>   ...

This is commit referenced by tag, i.e. v1.4.1^{commit}

> Uhhh, that's a tag.  I know it is:
>=20
>   [spearce@pb15 git]$ git cat-file tag v1.4.1
>   object 0556a11a0df6b4119e01aa77dfb795561e62eb34
>   type commit
>   tag v1.4.1
>   tagger Junio C Hamano <junkio@cox.net> 1151818415 -0700
>   ...

This is tag itself.

> And I know its not a tree:
>=20
>   [spearce@pb15 git]$ git cat-file tree v1.4.1
>   100644 .gitignore{?MX~=C4=83????y?v?X?u100644 COPYINGo?...

This is tree referenced by commit, referenced by tag, i.e. v1.4.1^{tree=
}

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
