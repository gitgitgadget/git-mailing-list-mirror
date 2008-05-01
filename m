From: SZEDER =?iso-8859-2?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: Havoc Pennington on git and easygit
Date: Thu, 1 May 2008 12:44:15 +0200
Message-ID: <20080501104415.GA16473@elysium.homelinux.org>
References: <32541b130804301656s3989bab7xcfaa4efd331ca63c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 01 12:45:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrWHj-0006Sl-LE
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 12:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753581AbYEAKoU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 May 2008 06:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753024AbYEAKoU
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 06:44:20 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:62479 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbYEAKoT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 May 2008 06:44:19 -0400
Received: from elysium (p5B133181.dip0.t-ipconnect.de [91.19.49.129])
	by mrelayeu.kundenserver.de (node=mrelayeu8) with ESMTP (Nemesis)
	id 0ML31I-1JrWGu36wP-00013X; Thu, 01 May 2008 12:44:16 +0200
Received: by elysium (Postfix, from userid 1000)
	id A4D5F123A80; Thu,  1 May 2008 12:44:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <32541b130804301656s3989bab7xcfaa4efd331ca63c@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Provags-ID: V01U2FsdGVkX1/yVANfZU256Xbs6d2KKmUzIHGG7IWGDCgVrwq
 INf7DxGgXrY943FUWaaLcwLoabC3oisVe9uTAsn6x8u43Drh2T
 ElrB4F28xr9k5w8C/Az0g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80897>

On Wed, Apr 30, 2008 at 07:56:40PM -0400, Avery Pennarun wrote:
> For those that don't follow Havoc's postings, this one about git is
> quite well thought out:
>=20
> http://log.ometer.com/2008-04.html#29
>=20
> His comments very much parallel my own learning experience and others
> here, except that he's more stubborn about learning git's internals
> than I was.

Makes me wonder which git version is he using:

    "Use EMAIL and GECOS
   =20
    A minor thing, but if you just start using git, it puts garbage in
    the Author field. Every other program uses the EMAIL environment
    variable and your UNIX account information. That is a good
    default. If people want to override it via config option, then let
    them, but don't require configuration to get started."=20

Now this commit is more than a year old:

commit 28a94f885a735e7474357698ec384de24d526620
Author: Josh Triplett <josh@freedesktop.org>
Date:   Sat Apr 28 18:40:28 2007 -0700

    Fall back to $EMAIL for missing GIT_AUTHOR_EMAIL and
    GIT_COMMITTER_EMAIL


Regards,
G=E1bor
