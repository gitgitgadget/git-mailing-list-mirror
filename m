From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn import failure : write .git/Git_svn_hash_BmjclS: Bad
 file descriptor
Date: Wed, 25 Feb 2015 20:08:33 +0000
Message-ID: <20150225200833.GA10031@dcvr.yhbt.net>
References: <20150130002247.GA22519@dcvr.yhbt.net>
 <CABNxngMVsaSLmzf0ZsaXZqXhD+hOaRmz-uuSzm0ALDFhKjnrXA@mail.gmail.com>
 <20150130013017.GA10713@dcvr.yhbt.net>
 <CAK6Z60cGnvPP0ctnyV4tHfMmBGYRidEJzkAG+J2h9BunmtOAsQ@mail.gmail.com>
 <CABNxngNH20O52QHSivQLvRFSW2hqnVTYuBv0CWn1L53cL+XoGw@mail.gmail.com>
 <20150212191807.GA30062@dcvr.yhbt.net>
 <CAK6Z60dZu_0kNJF2-eJMgnjYVhxfyps53mcfZT41V1DBZZ+zhw@mail.gmail.com>
 <20150217061707.GA4308@dcvr.yhbt.net>
 <801181a93d829d68b96c4b61d1ebdc3@74d39fa044aa309eaea14b9f57fe79c>
 <CAK6Z60fqEkM_tON6tcnwBqJzBCvLB=eVJdyXSnNb7N1iR_DSsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Kyle J. McKay" <mackyle@gmail.com>, Mike <ipso@snappymail.ca>,
	Minty <mintywalker@gmail.com>,
	Valery Yundin <yuvalery@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: Nico =?utf-8?B?U2NobMO2bWVy?= <nico.schloemer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 21:08:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQiGE-0001C7-97
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 21:08:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213AbbBYUIe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Feb 2015 15:08:34 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:45397 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752700AbbBYUId (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 15:08:33 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEC831F7A3;
	Wed, 25 Feb 2015 20:08:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAK6Z60fqEkM_tON6tcnwBqJzBCvLB=eVJdyXSnNb7N1iR_DSsw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264410>

Nico Schl=C3=B6mer <nico.schloemer@gmail.com> wrote:
> Thanks Kyle for the patch! I applied it and ran
> ```
> git svn clone https://geuz.org/svn/gmsh/trunk
> ```
> Unfortunately, I'm still getting
> ```
> [...]
> r100 =3D e2a9b5baa2cebb18591ecb04ff350410d52f36de (refs/remotes/git-s=
vn)
> error closing pipe: Bad file descriptor at
> /usr/share/perl5/Git/SVN/Fetcher.pm line 335.
> error closing pipe: Bad file descriptor at
> /usr/share/perl5/Git/SVN/Fetcher.pm line 335.
> out pipe went bad at /usr/share/perl5/Git.pm line 955.

Thanks for testing, is this with or without my other attempt at
fixing this problem applied?

http://mid.gmane.org/20150130002247.GA22519@dcvr.yhbt.net
("git-svn: destroy all tempfiles when reloading RA")

And can you try testing both with/without that patch if you
haven't already?  Thanks again.
