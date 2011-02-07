From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: "git add -u" broken in git 1.7.4?
Date: Mon, 7 Feb 2011 12:15:06 +0100
Message-ID: <20110207111505.GA10281@neumann>
References: <4D4DEDC4.4080708@hartwork.org>
	<20110206051333.GA3458@sigill.intra.peff.net>
	<4D4EF7E4.7050303@hartwork.org> <vpq1v3kopn3.fsf@bauges.imag.fr>
	<7vwrlcv1ea.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sebastian Pipping <webmaster@hartwork.org>,
	Jeff King <peff@peff.net>, Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 12:15:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmP40-0005YO-Cg
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 12:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275Ab1BGLPS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Feb 2011 06:15:18 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:60609 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127Ab1BGLPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 06:15:16 -0500
Received: from localhost6.localdomain6 (p5B130FC1.dip0.t-ipconnect.de [91.19.15.193])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0LrZV7-1Q93pv2VdF-013NRV; Mon, 07 Feb 2011 12:15:07 +0100
Content-Disposition: inline
In-Reply-To: <7vwrlcv1ea.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:m2hPReU30KLd53NBi9A2u1KOPT9NpDvaA7dexu5L3rM
 tvHuB7bbOKUcjtKW5YzjkMvchS8CXwejAJVF/8D0EvlclnKrVw
 Wdb6AbNFiTUM4+/aiKclcBKGYDB9cHA6liUITb9uY2QXJZr1ws
 gFWfkoIR0yt8m3XnUD7nSf6xh5UFSEtB9Yu2kl19aodjJm2AL5
 yRsqoZq6wp4nPbKa4zqMA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166253>

Hi,


On Sun, Feb 06, 2011 at 09:50:37PM -0800, Junio C Hamano wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>=20
> > Sebastian Pipping <webmaster@hartwork.org> writes:
> >
> >> I was and I can confirm the different behaviour with 1.7.4 over he=
re: it
> >> does work on the root directory of the repo as you supposed.
> >
> > What do you mean by "it does not work"?
> >
> > "git add -u" adds files under the current directory, and it always
> > did.
>=20
> As it takes pathspecs (think "git add -u this-file"), it fundamentall=
y
> shouldn't be tree-wide.  I think the original implementation didn't t=
ake
> pathspecs and was mistakenly done as tree-wide operation, but I think=
 it
> was fixed rather quickly.

Interesting, when I brought up this issue about one and a half years
ago, you of all people proposed that this change might be worth
addressing in 1.8.0.

  Message-ID: <7veiql1etz.fsf@alter.siamese.dyndns.org>
  http://thread.gmane.org/gmane.comp.version-control.git/127593/focus=3D=
127594

There was a longish discussion back then with arguments both for and
against tree-wide operation.


Best,
G=E1bor
