From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git svn rebase - could not detach HEAD
Date: Thu, 7 Aug 2008 09:41:17 +0200
Message-ID: <20080807074117.GA7648@atjola.homenet>
References: <f7d8f60b0808062349q92fffb9l33de5550250e4e13@mail.gmail.com> <7vd4kljnpn.fsf@gitster.siamese.dyndns.org> <f7d8f60b0808070033g7a322ee4w9147dd51e41850c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tony Stubbs <antony.stubbs@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 07 09:42:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KR08l-0007AV-1K
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 09:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753789AbYHGHlZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Aug 2008 03:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753338AbYHGHlW
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 03:41:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:57836 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752524AbYHGHlV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 03:41:21 -0400
Received: (qmail invoked by alias); 07 Aug 2008 07:41:19 -0000
Received: from i577BA13F.versanet.de (EHLO atjola.local) [87.123.161.63]
  by mail.gmx.net (mp017) with SMTP; 07 Aug 2008 09:41:19 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX186xe0byhQ6qZGRX/jGZIQyj0zENM0NGJ45VinxCI
	uCD1x0REkDNFN9
Content-Disposition: inline
In-Reply-To: <f7d8f60b0808070033g7a322ee4w9147dd51e41850c6@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91565>

On 2008.08.07 19:33:36 +1200, Tony Stubbs wrote:
> Ok, woah. that's really weird... note the strange behaviour of
> git-clean (i had my ide open, then clossed it. but it still acted
> strange)
>=20
> that seems to have got it. so are you going to apply that patch to gi=
t proper?

It already is.

> stubbsa@VFNZV95336 /cygdrive/c/dev
> $ git clean -df
> Removing Utilities/.apt_src/
> Removing Utilities/build/
>=20
> stubbsa@VFNZV95336 /cygdrive/c/dev
> $ git clean -df
>=20
> stubbsa@VFNZV95336 /cygdrive/c/dev
> $ git rebase git-svn
> First, rewinding head to replay your work on top of it...
> error: Untracked working tree file
> 'webnonline-db-access/target/hanson-db-access-1.0.jar' would be
> overwritten by merge.
> could not detach HEAD
>=20
> <manually deleted "untracked file" here>

Maybe you're ignoring that file? git clean deletes ignored files only i=
f
you use -x/-X.

Bj=F6rn
