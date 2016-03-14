From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: git-secret - store your private data inside a repository
Date: Mon, 14 Mar 2016 18:04:20 +0000
Message-ID: <robbat2-20160314T172243-113693201Z@orbis-terrarum.net>
References: <CAO_bL1xQ0C+HYdZQVvyHx3ByPaaJTgpQYhY7h9f76eQXHKZ_SQ@mail.gmail.com>
 <robbat2-20160313T211905-684299027Z@orbis-terrarum.net>
 <CAO_bL1y8tp5+NKdPqpwqJvX2xWY6Wg1oZbnRTKAVjKrg94b3BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?utf-8?B?0J3QuNC60LjRgtCwINCh0L7QsdC+0LvQtdCy?= 
	<n.a.sobolev@gmail.com>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 14 19:04:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afWr1-0003fO-3h
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 19:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755471AbcCNSEY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Mar 2016 14:04:24 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:43522 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755149AbcCNSEV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 14:04:21 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id C1691340CB4
	for <git@vger.kernel.org>; Mon, 14 Mar 2016 18:04:20 +0000 (UTC)
Received: (qmail 19657 invoked by uid 10000); 14 Mar 2016 18:04:20 -0000
Content-Disposition: inline
In-Reply-To: <CAO_bL1y8tp5+NKdPqpwqJvX2xWY6Wg1oZbnRTKAVjKrg94b3BA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288794>

On Mon, Mar 14, 2016 at 10:22:43AM +0300, =D0=9D=D0=B8=D0=BA=D0=B8=D1=82=
=D0=B0 =D0=A1=D0=BE=D0=B1=D0=BE=D0=BB=D0=B5=D0=B2 wrote:
> Robin, thank you for interest.
>=20
> I have not seen 'pwstore' before, but I don't like the idea to store
> headers inside the file. As it might break things. But I love the ide=
a
> of groups and access rights. It is a direction I would like to follow=
=2E
> Also I like your suggestion about the key's white-list. That's a
> feature I have already planed for the future releases.
Maybe using notes for the ACL metadata would work out, not sure.

> I guess 'pass' was made for a single user. But 'git-secret' was made
> for multiple people. So you can invite someone to share your encrypte=
d
> files and easily remove them. Also, I have noticed that 'pass' stores
> the encrypted files in the separate repository. Well, that's an
> arguable way to go. It has some benefits like: code-repository and
> pass-repository may have different access rights, different people
> involved. But there's a lack in consistency when you have two separat=
e
> repositories.
Yes, 'pass' did start for a single user; and added per-folder access
groups later. It's also that it aims to be a simple secret storage tool
(no random blobs), with an optional Git backing (simply making the
directory versioned), rather than secret-storage-for-any-git-repo.

I included pass also because it has some nice UX (IMO).

--=20
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead, Foundation Trustee
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
