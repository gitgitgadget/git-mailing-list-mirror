From: Jeff King <peff@peff.net>
Subject: Re: git error in tag ...: unterminated header
Date: Fri, 26 Jun 2015 11:52:48 -0400
Message-ID: <20150626155248.GB30273@peff.net>
References: <20150625155128.C3E9738005C@gemini.denx.de>
 <xmqqegkzzoaz.fsf@gitster.dls.corp.google.com>
 <20150625201309.5026A384E81@gemini.denx.de>
 <xmqqegkzy1ri.fsf@gitster.dls.corp.google.com>
 <2b124e09d9c89ff3892f246ea91aa3c4@www.dscho.org>
 <xmqqoak3wkkq.fsf@gitster.dls.corp.google.com>
 <xmqqbng3wheu.fsf@gitster.dls.corp.google.com>
 <d455a77d76b3558fb79d550d6ed4468d@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Wolfgang Denk <wd@denx.de>,
	git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 26 17:52:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8Vw0-0003Fu-C6
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 17:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287AbbFZPww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 11:52:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:52288 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751983AbbFZPwv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 11:52:51 -0400
Received: (qmail 12590 invoked by uid 102); 26 Jun 2015 15:52:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Jun 2015 10:52:51 -0500
Received: (qmail 17722 invoked by uid 107); 26 Jun 2015 15:52:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Jun 2015 11:52:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jun 2015 11:52:48 -0400
Content-Disposition: inline
In-Reply-To: <d455a77d76b3558fb79d550d6ed4468d@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272784>

On Fri, Jun 26, 2015 at 10:06:20AM +0200, Johannes Schindelin wrote:

> I understood what you were saying, but it still appears too fragile to
> me to mix functions that assume NUL-terminated strings with an ad-hoc
> counted string check.

Yeah, I agree. It is not that you cannot make it safe, but that it is
simply a fragile maintenance burden in the future. I thought we dealt
with this already with a1e920a (index-pack: terminate object buffers
with NUL, 2014-12-08), though.

-Peff
