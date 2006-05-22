From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] tutorial: add discussion of index file, object database
Date: Mon, 22 May 2006 17:27:31 +0200
Organization: At home
Message-ID: <e4sl90$l3b$1@sea.gmane.org>
References: <1148255528.61d5d241.1@fieldses.org> <1148255528.61d5d241.2@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon May 22 17:29:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiCKi-0006Ez-4b
	for gcvg-git@gmane.org; Mon, 22 May 2006 17:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWEVP2d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 22 May 2006 11:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbWEVP2d
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 11:28:33 -0400
Received: from main.gmane.org ([80.91.229.2]:63452 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750932AbWEVP2c (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 11:28:32 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FiCKJ-000694-4q
	for git@vger.kernel.org; Mon, 22 May 2006 17:28:11 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 May 2006 17:28:11 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 May 2006 17:28:11 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20511>

J. Bruce Fields wrote:

> +With the right arguments, git diff can also show us the difference
> +between the working directory and the last commit, or between the
> +index and the last commit:
> +
> +------------------------------------------------
> +$ git diff HEAD
[...]
> +$ git diff --cached


Junio C Hamano wrote:

> Also,=C2=A0":<path>"=C2=A0to=C2=A0mean=C2=A0the
> entry in the index is often equivalent to "git diff --cached".
>=20
> IOW, these are obscure special purpose notation, and I do not
> think tutorial is a good place to cover them.

Hmm, wouldn't it be nice to have here :<path> mentioned as=20
alternative/extension to --cached, and <ref>:<path> including=20
HEAD:<path> as an extension of HEAD, and <path> as an extension
to not having arguments? By extension I mean adding path limiting
and some more advanced selection of things to diff.

--=20
Jakub Narebski
Warsaw, Poland
