From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 3/3] diff: make "too many files" rename warning optional
Date: Mon, 12 May 2008 21:15:48 +1000
Message-ID: <18472.9956.700793.959475@cargo.ozlabs.ibm.com>
References: <20080430172136.GA22601@sigill.intra.peff.net>
	<20080430172553.GC23747@sigill.intra.peff.net>
	<481CA227.1000801@ramsay1.demon.co.uk>
	<20080504192332.GB13029@sigill.intra.peff.net>
	<18462.18066.769759.585596@cargo.ozlabs.ibm.com>
	<20080505135954.GA17334@sigill.intra.peff.net>
	<7vd4o0o7dw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 12 13:28:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvWCJ-0008Tz-Vp
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 13:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345AbYELL1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 07:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753951AbYELL1O
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 07:27:14 -0400
Received: from ozlabs.org ([203.10.76.45]:38738 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753935AbYELL1N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 07:27:13 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 72930DDE11; Mon, 12 May 2008 21:27:12 +1000 (EST)
In-Reply-To: <7vd4o0o7dw.fsf@gitster.siamese.dyndns.org>
X-Mailer: VM 7.19 under Emacs 22.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81853>

Junio C Hamano writes:

> > In that case, Junio, perhaps we should restrict this particular warning
> > just to merge.
> 
> I am not sure if we really want to work around Tcl's braindamage like
> that.

If this is the warning about too many files to do inexact rename
detection, I find that one annoying because I don't care about that
(it's just for the diffstat when doing a pull AFAIK) and I don't know
how to turn it off.

> There is no stdwarn or stdinfo stream and I think it is a bug on the
> receiving end to assume that anything that comes to stderr is an error.

There are apparently some programs on some platforms for which this
behaviour is necessary...

Paul.
