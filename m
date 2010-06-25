From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: FR: Clone just the desired subdirectory
Date: Fri, 25 Jun 2010 22:27:38 +0200
Message-ID: <20100625202738.GA3696@atjola.homenet>
References: <AANLkTilyvCWyWzqPGxtg9tkRM5SjXxbt50P5zImlxCHD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Laszlo Papp <djszapi@archlinux.us>
X-From: git-owner@vger.kernel.org Fri Jun 25 22:27:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSFV8-00079v-3Z
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 22:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756528Ab0FYU1p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jun 2010 16:27:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:49918 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755996Ab0FYU1o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jun 2010 16:27:44 -0400
Received: (qmail invoked by alias); 25 Jun 2010 20:27:42 -0000
Received: from i59F57F34.versanet.de (EHLO atjola.homenet) [89.245.127.52]
  by mail.gmx.net (mp066) with SMTP; 25 Jun 2010 22:27:42 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18ordIvteAoIfqoVMlZ/Yqua1D4XwmoINMVlAtDRZ
	UsMs61kCdZPfuM
Content-Disposition: inline
In-Reply-To: <AANLkTilyvCWyWzqPGxtg9tkRM5SjXxbt50P5zImlxCHD@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149706>

On 2010.06.25 16:24:52 +0200, Laszlo Papp wrote:
> Is there a way to clone
> git://git.openembedded.org/openembedded/recipes/qt4, not the whole
> repository ?

Here you ask for a subdirectory clone.

> My friend asked it from me, but I couldn't advise anything to him, bu=
t
> this request does make sense by me. So he would like to download a
> part of a git repository and he is not interested in the index and th=
e
> history, so it would be nice to have something like git archive
> --remote or similar command which can do this operation.

Here you say that your friend doesn't bother about the history, but jus=
t
wants a snapshot.

So which functionality are you actually asking for? The latter can
already be handled by git archive:

git archive --remote=3D<repo> <tree-ish>

=46or example:

git archive --remote=3Dgit://localhost/some/repo.git HEAD:some/director=
y

git-daemon just doesn't allow it by default, you need to enable the
upload-archive service.

Bj=F6rn
