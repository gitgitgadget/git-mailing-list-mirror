From: Jeff King <peff@peff.net>
Subject: Re: git commit-tree documentation incorrect parameter sequence
Date: Tue, 19 Jun 2012 20:37:26 -0400
Message-ID: <20120620003726.GA6741@sigill.intra.peff.net>
References: <CAHtLG6S3ZyBV+0KxKLUSCO7yOXLGD1NGhM62sJfKPUMSeQTSoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 02:37:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh8vN-0004PL-Ag
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 02:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752Ab2FTAh3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jun 2012 20:37:29 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:33201
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752626Ab2FTAh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 20:37:29 -0400
Received: (qmail 16862 invoked by uid 107); 20 Jun 2012 00:37:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Jun 2012 20:37:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jun 2012 20:37:26 -0400
Content-Disposition: inline
In-Reply-To: <CAHtLG6S3ZyBV+0KxKLUSCO7yOXLGD1NGhM62sJfKPUMSeQTSoQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200280>

On Sun, Jun 17, 2012 at 09:57:42AM +0800, =E4=B9=99=E9=85=B8=E9=8B=B0 w=
rote:

> In current git commit-tree documentation,
> the parameter sequence is incorrect.
>=20
> git commit-tree <tree> [(-p <parent>)=E2=80=A6] < changelog
> git commit-tree [(-p <parent>)=E2=80=A6] [(-m <message>)=E2=80=A6] [(=
-F <file>)=E2=80=A6] <tree>
>=20
> The second line in incorrect, and <tree> should come first
> git commit-tree <tree> [(-p <parent>)=E2=80=A6] [(-m <message>)=E2=80=
=A6] [(-F <file>)=E2=80=A6]

Yes, I believe you're right. Would you care to submit a patch?

-Peff
