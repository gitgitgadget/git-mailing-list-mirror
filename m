From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-pull.sh: overhaul error handling when no
 candidates are found
Date: Thu, 12 Nov 2009 10:28:49 -0500
Message-ID: <20091112152849.GA25352@coredump.intra.peff.net>
References: <1257945756.26362.79.camel@heerbeest>
 <48B54636-1825-48B3-BECD-4150A55B013F@dbservice.com>
 <1257965806.26362.132.camel@heerbeest>
 <D6B0AE61-6CA3-4F79-BB50-B8795415BAB7@dbservice.com>
 <1257968052.26362.155.camel@heerbeest>
 <AC99BA30-A36D-4798-8E7D-9D69EFE99D55@dbservice.com>
 <1258035449.26362.273.camel@heerbeest>
 <20091112155310.7836c388@perceptron>
 <20091112150626.GA24848@coredump.intra.peff.net>
 <20091112162558.6b1c4a43@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jan Nieuwenhuizen <janneke-list@xs4all.nl>,
	Tomas Carnecky <tom@dbservice.com>,
	git list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Thu Nov 12 16:29:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8bbi-0004jT-3s
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 16:29:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752986AbZKLP27 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Nov 2009 10:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752981AbZKLP27
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 10:28:59 -0500
Received: from peff.net ([208.65.91.99]:52514 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752979AbZKLP26 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 10:28:58 -0500
Received: (qmail 22357 invoked by uid 107); 12 Nov 2009 15:32:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 12 Nov 2009 10:32:50 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Nov 2009 10:28:49 -0500
Content-Disposition: inline
In-Reply-To: <20091112162558.6b1c4a43@perceptron>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132776>

On Thu, Nov 12, 2009 at 04:25:58PM +0100, Jan Kr=C3=BCger wrote:

> > Personally, I would go the other way: give them something they can =
cut
> > and paste on the command line, like:
>=20
> A matter of taste, I suppose. The user has to edit the lines anyway
> since they contain placeholders.

Oh, true. I was thinking we filled them in with the right values, but o=
f
course we don't know what those values are (if we did, we wouldn't be
bugging the user...). So ignore what I said.

> > Isn't branch.*.rebase a boolean value?
>=20
> Argh! Of course it is. Note to self: don't write patches in a hurry.
> Disregard everything I said. I thought I was seeing incorrect behavio=
r
> in what Jan (N.) reported...

If it makes you feel better, the reason I noticed your error so quickly
is that I made the _exact_ same one while doing a patch in that area a
month or two ago.

-Peff
