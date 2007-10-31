From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 1/1] Add --first-parent support to interactive rebase.
Date: Wed, 31 Oct 2007 17:36:41 +0300
Message-ID: <20071031143641.GF15182@dpotapov.dyndns.org>
References: <1193797309-1161-1-git-send-email-B.Steinbrink@gmx.de> <7vodefj2lk.fsf@gitster.siamese.dyndns.org> <20071031055303.GB3326@atjola.homenet> <20071031134358.GD15182@dpotapov.dyndns.org> <20071031140028.GA30207@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 15:37:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InEgn-0007DG-58
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 15:37:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755564AbXJaOgq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Oct 2007 10:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756188AbXJaOgq
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 10:36:46 -0400
Received: from smtp03.mtu.ru ([62.5.255.50]:55272 "EHLO smtp03.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752357AbXJaOgp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 10:36:45 -0400
Received: from potapov.private (ppp85-141-239-252.pppoe.mtu-net.ru [85.141.239.252])
	by smtp03.mtu.ru (Postfix) with ESMTP id EA412467165;
	Wed, 31 Oct 2007 17:36:41 +0300 (MSK)
Received: from dpotapov by potapov.private with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1InEgT-0006Wt-LP; Wed, 31 Oct 2007 17:36:41 +0300
Content-Disposition: inline
In-Reply-To: <20071031140028.GA30207@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62839>

On Wed, Oct 31, 2007 at 03:00:28PM +0100, Karl Hasselstr=F6m wrote:
> On 2007-10-31 16:43:58 +0300, Dmitry Potapov wrote:
>=20
> > I believe that the issue is with Junio's mail client. Indeed, the
> > context encoding for the mail *body* was specified as 8859-1, but
> > that should have none effect on fields in the mail header, because
> > any field is the header should be either printable ASCII or encoded
> > to contain only ASCII characters as specified in RFC 1522:
>=20
> Yes. But it's the body that's been mangled -- specifically, the
> Sign-off line.

Hmm... I looked at the mail again and I cannot see where 8859-1 is
specified. It seems that context encoding is not specified at all.
Of course, it is incorrect to use non ASCII characters in a mail
without specifying encoding. Apparently, because I use utf-8 in the
terminal, the Sign-off line displays correctly for me, so I did not
notice the problem. Sorry for the noise...

Dmitry
