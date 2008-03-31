From: Jeff King <peff@peff.net>
Subject: Re: Auto detaching head options (update) (Re: Working copy
	revision and push pain)
Date: Sun, 30 Mar 2008 22:09:21 -0400
Message-ID: <20080331020920.GA412@coredump.intra.peff.net>
References: <alpine.LSU.1.00.0803231555380.4353@racer.site> <47E6765D.2020103@jwatt.org> <alpine.LSU.1.00.0803231658460.4353@racer.site> <20080325192552.GC4857@efreet.light.src> <20080325232424.GB5273@coredump.intra.peff.net> <7v3aqde2wn.fsf@gitster.siamese.dyndns.org> <20080329082757.GA4920@efreet.light.src> <20080329084743.GA19200@coredump.intra.peff.net> <7vy77zslor.fsf@gitster.siamese.dyndns.org> <20080331015937.GA32645@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Watt <jwatt@jwatt.org>,
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 04:10:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jg9TK-0001Zr-14
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 04:10:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753581AbYCaCJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 22:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753703AbYCaCJX
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 22:09:23 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2129 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753041AbYCaCJX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 22:09:23 -0400
Received: (qmail 10812 invoked by uid 111); 31 Mar 2008 02:09:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 30 Mar 2008 22:09:22 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Mar 2008 22:09:21 -0400
Content-Disposition: inline
In-Reply-To: <20080331015937.GA32645@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78544>

On Sun, Mar 30, 2008 at 09:59:37PM -0400, Jeff King wrote:

> Why is 605fac8 beneficial? What common workflow is updating the HEAD
> branch through its actual name? If it is manipulating the index and

Apparently my reading skills are not what they used to be. In the
comment from 605fac8, it specifically mentions pushing directly into a
branch that is the same as HEAD. But that is one of the cases that we
Jan is trying to improve, so I don't see a problem with reverting in
favor of his proposal.

-Peff
