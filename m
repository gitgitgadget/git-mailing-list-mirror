From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] t5570: forward git-daemon messages in a different way
Date: Mon, 16 Apr 2012 23:22:15 +0200
Message-ID: <20120416212215.GA5351@ecki>
References: <1334393070-7123-1-git-send-email-zbyszek@in.waw.pl>
 <20120414121358.GA26372@ecki>
 <20120414122127.GA31220@ecki>
 <4F8C3E0F.2040300@in.waw.pl>
 <7vmx6bwqmj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 23:42:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJtgc-0004ZL-JG
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 23:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753075Ab2DPVmI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 17:42:08 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:6304 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869Ab2DPVmH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 17:42:07 -0400
Received: from [127.0.0.1] (p5B22C2B7.dip.t-dialin.net [91.34.194.183])
	by bsmtp.bon.at (Postfix) with ESMTP id E2B9D13004B;
	Mon, 16 Apr 2012 23:42:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vmx6bwqmj.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195701>

On Mon, Apr 16, 2012 at 10:09:08AM -0700, Junio C Hamano wrote:
> Zbigniew J=C4=99drzejewski-Szmek  <zbyszek@in.waw.pl> writes:
>=20
> > So my patch was totally bogus, it was just probably changing the ti=
ming.
> >
> > Now your patches (on top of next):
> > 'git-daemon wrapper to wait until daemon is ready' fixes the proble=
m, thanks!
> >
> > (I now see that they are both in pu: pu runs fine too.)
>=20
> Sorry, I think one of the "both" you mean is 7122c9e (git-daemon wrap=
per
> to wait until daemon is ready, 2012-04-15), but which one is "the oth=
er
> one" (which I should discard)?

I believe he is referring to 1bcb0ab4 (t5570: use explicit push
refspec), which is also necessary to run the tests on pu.
