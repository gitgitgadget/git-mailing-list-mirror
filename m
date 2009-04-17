From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 3/8] archive: add a failure test wrt .gitattributes  
 misreading
Date: Fri, 17 Apr 2009 22:15:36 +0200
Message-ID: <49E8E368.2010703@lsrfire.ath.cx>
References: <1239185133-4181-1-git-send-email-pclouds@gmail.com> <1239185133-4181-2-git-send-email-pclouds@gmail.com> <1239185133-4181-3-git-send-email-pclouds@gmail.com> <1239185133-4181-4-git-send-email-pclouds@gmail.com> <7vab6rkl5f.fsf@gitster.siamese.dyndns.org> <49E3448B.8010602@lsrfire.ath.cx> <7v4owpm2il.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 22:17:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuuUw-0002Xk-Dn
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 22:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611AbZDQUPm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Apr 2009 16:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752043AbZDQUPl
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 16:15:41 -0400
Received: from india601.server4you.de ([85.25.151.105]:54845 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbZDQUPl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 16:15:41 -0400
Received: from [10.0.1.101] (p57B7F146.dip.t-dialin.net [87.183.241.70])
	by india601.server4you.de (Postfix) with ESMTPSA id DA2BC2F8044;
	Fri, 17 Apr 2009 22:15:39 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <7v4owpm2il.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116785>

Junio C Hamano schrieb:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> Hmm, "fix" implies that something is broken without this option, whi=
ch
>> is not necessarily the case.
>=20
> "What is recorded in the tree is unsuitable for the purpose of this
> particular export, so we are xxxing using yyy", is the intended use c=
ase,
> and I think the verb "fix" is a good fit there in "xxx" part.  "Tweak=
"
> would also work well.
>=20
> Your suggestion is to say "attributes from the work tree" in place of
> "yyy", which also is good.

> I got the impression that people tend to prefer the operation named a=
fter
> what it does than how it does it, but I can go either way.

That's a good rule to follow in general.  "Fix" sounds to me as if git'=
s
default behaviour is wrong and needs an option to make it work
correctly, though.  It's too broad a term.

I think the fixing, tweaking or even breaking will be done by the user,
when editing the attribute files in the work tree.  git then only
applies or evaluates these attributes, creating the archive using a
different source of meta data.  "--worktree-attributes" captures this
nicely.

Ren=C3=A9
