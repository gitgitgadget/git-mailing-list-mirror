From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: bisect / history preserving on rename + update
Date: Tue, 14 Aug 2007 13:06:59 +0200
Message-ID: <1187089619.12828.183.camel@chaos>
References: <1187080681.12828.174.camel@chaos>
	 <20070814093357.GA14010@diana.vm.bytemark.co.uk>
	 <1187086600.12828.177.camel@chaos>
	 <20070814105056.GA14536@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Karl =?ISO-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 13:07:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKuFM-0006o2-V8
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 13:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756633AbXHNLHF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 14 Aug 2007 07:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756547AbXHNLHF
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 07:07:05 -0400
Received: from www.osadl.org ([213.239.205.134]:50693 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755409AbXHNLHC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 07:07:02 -0400
Received: from [127.0.0.1] (debian [213.239.205.147])
	by mail.tglx.de (Postfix) with ESMTP id ABE0C65C3EA;
	Tue, 14 Aug 2007 13:07:01 +0200 (CEST)
In-Reply-To: <20070814105056.GA14536@diana.vm.bytemark.co.uk>
X-Mailer: Evolution 2.10.1 (2.10.1-4.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55825>

On Tue, 2007-08-14 at 12:50 +0200, Karl Hasselstr=C3=B6m wrote:
> > Err.
> >
> > git-mv A B
> > git commit
> > edit B
> > git commit
> > git blame B <- shows the full history of A & B
> >
> > IMHO that's why we have git-mv
>=20
> Try replacing
>=20
>   $ git-mv A B
>=20
> with
>=20
>   $ mv A B
>   $ git rm A
>   $ git add B
>=20
> The result is exactly the same. git-mv is just a convenience.

=46air enough, but it still does not solve my initial problem of keepin=
g
the history of B (former A) intact, while creating a new A which is
necessary to compile the tree, simply because I can not change #include
<A> to #include <B> for various reasons.

	tglx
