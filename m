From: Jeff King <peff@peff.net>
Subject: Re: correct git merge behavior or corner case?
Date: Tue, 21 Apr 2009 14:05:30 -0400
Message-ID: <20090421180529.GA7583@coredump.intra.peff.net>
References: <4ac8254d0904191540j68246cd8qa36a034209d4c800@mail.gmail.com> <alpine.DEB.1.00.0904201148150.6955@intel-tinevez-2-302> <41354.bFoQE3daRhY=.1240222235.squirrel@webmail.hotelhot.dk> <20090421024433.GC14479@coredump.intra.peff.net> <7vskk2bt3x.fsf@gitster.siamese.dyndns.org> <fabb9a1e0904210148w4c6b869l396122baef1c0ee3@mail.gmail.com> <alpine.DEB.1.00.0904211055160.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0904211100350.10279@pacific.mpi-cbg.de> <20090421195434.3a01676d@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>,
	Tuncer Ayaz <tuncer.ayaz@gmail.com>, git@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 20:08:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwKNI-0005IQ-Io
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 20:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755075AbZDUSFe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Apr 2009 14:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753977AbZDUSFe
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 14:05:34 -0400
Received: from peff.net ([208.65.91.99]:34085 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754267AbZDUSFd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 14:05:33 -0400
Received: (qmail 10703 invoked by uid 107); 21 Apr 2009 18:05:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 21 Apr 2009 14:05:41 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Apr 2009 14:05:30 -0400
Content-Disposition: inline
In-Reply-To: <20090421195434.3a01676d@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117144>

On Tue, Apr 21, 2009 at 07:54:34PM +0200, Micha=C5=82 Kiedrowicz wrote:

> And here is a test case:
> [...]
> +	echo "hello" > date &&
> +	git add date &&
> +	git commit -m initial &&
> +
> +	git branch parallel &&
> +
> +	echo "hello" > LICENSE &&
> +	cp LICENSE LICENSE-copy &&
> +	git add LICENSE &&
> +	git commit -m LICENSE &&

I thought the point was about _empty_ renames. This is a small but
non-zero rename.

-Peff
