From: Jeff King <peff@peff.net>
Subject: Re: serious performance issues with images, audio files, and other
 "non-code" data
Date: Tue, 18 May 2010 15:07:06 -0400
Message-ID: <20100518190706.GA2383@coredump.intra.peff.net>
References: <4BEAF941.6040609@puckerupgames.com>
 <20100514051049.GF6075@coredump.intra.peff.net>
 <4BED47EA.9090905@puckerupgames.com>
 <20100517231642.GB12092@coredump.intra.peff.net>
 <AANLkTikAoZgvYXN-iGPGjMP-vdgrOuKp3_gJzGYaojec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John <john@puckerupgames.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 18 21:07:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OES8N-0006bG-Ew
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 21:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756723Ab0ERTHL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 May 2010 15:07:11 -0400
Received: from peff.net ([208.65.91.99]:42375 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754699Ab0ERTHK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 May 2010 15:07:10 -0400
Received: (qmail 19442 invoked by uid 107); 18 May 2010 19:07:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 18 May 2010 15:07:36 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 18 May 2010 15:07:06 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikAoZgvYXN-iGPGjMP-vdgrOuKp3_gJzGYaojec@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147297>

On Tue, May 18, 2010 at 01:33:35AM +0200, Sverre Rabbelier wrote:

> On Tue, May 18, 2010 at 01:16, Jeff King <peff@peff.net> wrote:
> > =C2=A01. Use "git commit -q" to avoid wasting time on the commit di=
ff
> > =C2=A0 =C2=A0 summary (we should perhaps have a commit.quiet config=
 option for
> > =C2=A0 =C2=A0 repos like this where you would almost always want to=
 suppress it).
>=20
> Do we respect the .gitattributef and not try to generate the diffstat
> for files that are uncompressable?

No, not to my knowledge. Even the "binary" attribute just says "this
file is binary, don't text diff it". I think we will always still do
rewrite-detection for operations like "git status" and the diff summary
of "git commit".

-Peff
