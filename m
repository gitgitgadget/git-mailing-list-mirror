From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn import failure : write .git/Git_svn_hash_BmjclS: Bad
 file descriptor
Date: Tue, 17 Feb 2015 06:17:07 +0000
Message-ID: <20150217061707.GA4308@dcvr.yhbt.net>
References: <CABNxngNDwf_Cy77OzvMg__kCNoTz5y1a2KKG1vobYjE_m_aLkQ@mail.gmail.com>
 <20150129233429.GA7162@dcvr.yhbt.net>
 <CABNxngPErFiTzUNK6P90Ug5fVtJSYD9XrGrQzK8+mt2u4g=Xyg@mail.gmail.com>
 <20150130002247.GA22519@dcvr.yhbt.net>
 <CABNxngMVsaSLmzf0ZsaXZqXhD+hOaRmz-uuSzm0ALDFhKjnrXA@mail.gmail.com>
 <20150130013017.GA10713@dcvr.yhbt.net>
 <CAK6Z60cGnvPP0ctnyV4tHfMmBGYRidEJzkAG+J2h9BunmtOAsQ@mail.gmail.com>
 <CABNxngNH20O52QHSivQLvRFSW2hqnVTYuBv0CWn1L53cL+XoGw@mail.gmail.com>
 <20150212191807.GA30062@dcvr.yhbt.net>
 <CAK6Z60dZu_0kNJF2-eJMgnjYVhxfyps53mcfZT41V1DBZZ+zhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Valery Yundin <yuvalery@gmail.com>, git@vger.kernel.org,
	Minty <mintywalker@gmail.com>, Mike <ipso@snappymail.ca>,
	Junio C Hamano <gitster@pobox.com>
To: Nico =?utf-8?B?U2NobMO2bWVy?= <nico.schloemer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 07:17:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNbTG-0008G2-S4
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 07:17:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422AbbBQGRN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Feb 2015 01:17:13 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:50509 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751669AbbBQGRM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 01:17:12 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F2311F848;
	Tue, 17 Feb 2015 06:17:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAK6Z60dZu_0kNJF2-eJMgnjYVhxfyps53mcfZT41V1DBZZ+zhw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263935>

Nico Schl=C3=B6mer <nico.schloemer@gmail.com> wrote:
> I just double-checked and I can only produce this issue on one machin=
e
> (tested on 3). Apparently, this is has nothing to do with Git itself
> then.
>=20
> Any ideas of what could be wrong?

What's different about that one machine?
e.g. SVN version, 64 vs 32-bit, Perl version, etc. could all be
factors (assuming identical git versions).

Also, any chance git was misinstalled somehow or your PATH was not
pointing to the correct git installation?

Thanks
