From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] git-gui: give more advice when detaching HEAD
Date: Sun, 13 Feb 2011 10:22:06 +0100
Message-ID: <201102131022.06863.j6t@kdbg.org>
References: <20110212070538.GA2459@sigill.intra.peff.net> <7voc6hy771.fsf@alter.siamese.dyndns.org> <AANLkTi=3m3pvciKXgUXGffsA9xDddTum5mhWBoaWA3o+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 13 10:22:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoY9t-00043a-Hy
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 10:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753837Ab1BMJWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 04:22:17 -0500
Received: from bsmtp5.bon.at ([195.3.86.187]:8531 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753669Ab1BMJWL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 04:22:11 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 548EA13004F;
	Sun, 13 Feb 2011 10:22:07 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 2C27819F6D3;
	Sun, 13 Feb 2011 10:22:07 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <AANLkTi=3m3pvciKXgUXGffsA9xDddTum5mhWBoaWA3o+@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166648>

On Sonntag, 13. Februar 2011, Sverre Rabbelier wrote:
> Heya,
>
> On Sat, Feb 12, 2011 at 09:42, Junio C Hamano <gitster@pobox.com> wrote:
> > That way, the traversal will terminate much sooner than computing the
> > true merge base.
>
> Since we want to use this in git-gui, do you intend to expose this as
> a command somehow (e.g. 'git rev-parse --reachable HEAD --all' or
> somesuch)?

What's wrong with checking the output of

  git rev-list -1 HEAD --not --branches --tags --

for zero length?

-- Hannes
