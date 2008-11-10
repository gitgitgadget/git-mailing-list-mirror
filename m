From: Jeff King <peff@peff.net>
Subject: Re: git commit -v does not removes the patch
Date: Mon, 10 Nov 2008 13:10:24 -0500
Message-ID: <20081110181023.GA22753@coredump.intra.peff.net>
References: <adf1fd3d0811100720n52ac1d47id9b7f402412aa0d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Mon Nov 10 19:12:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzbEn-0006cl-EB
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 19:11:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754535AbYKJSK1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Nov 2008 13:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754368AbYKJSK1
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 13:10:27 -0500
Received: from peff.net ([208.65.91.99]:2261 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754114AbYKJSK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 13:10:26 -0500
Received: (qmail 28122 invoked by uid 111); 10 Nov 2008 18:10:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 10 Nov 2008 13:10:25 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Nov 2008 13:10:24 -0500
Content-Disposition: inline
In-Reply-To: <adf1fd3d0811100720n52ac1d47id9b7f402412aa0d3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100539>

On Mon, Nov 10, 2008 at 04:20:51PM +0100, Santi B=C3=A9jar wrote:

> Hi *,
>=20
>   $subject since:
>=20
> 4f672ad (wt-status: load diff ui config, 2008-10-26)
>=20
> I tried to make a test case, but failed. I think because it is a bit
> tricky the fake_editor/stdin/stdout stuff, so at the end I bisected i=
t
> by hand

Sorry, I don't quite understand what the problem is. From reading your
subject line, I expected that "git commit -v" would show the diff in
your editor, but then accidentally also include it in the final commit
message. But I can't seem to reproduce that.

Can you describe the problem in more detail?

-Peff
