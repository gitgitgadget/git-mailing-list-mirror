From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] git-reset: Let -q hush "locally modified" messages
Date: Fri, 25 Jul 2008 23:38:53 +0200
Message-ID: <20080725213853.GD13539@leksak.fem-net>
References: <1217018948-32475-1-git-send-email-s-beyer@gmx.net> <7vwsj9r722.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos Rica <jasampler@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 23:40:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMV1B-0006xW-RM
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 23:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbYGYVjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 17:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbYGYVjE
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 17:39:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:36392 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751830AbYGYVjD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 17:39:03 -0400
Received: (qmail invoked by alias); 25 Jul 2008 21:39:01 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp061) with SMTP; 25 Jul 2008 23:39:01 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19BmLsUGPRBILBTONwfQTwf1iGDZWcb/8S3evN8Vc
	YTbNVlqus+Q0Vj
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KMV01-0001l5-2v; Fri, 25 Jul 2008 23:38:53 +0200
Content-Disposition: inline
In-Reply-To: <7vwsj9r722.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90120>

Hi,

Junio C Hamano wrote:
> Stephan Beyer <s-beyer@gmx.net> writes:
> 
> > git reset -q makes reset more quiet, but "locally modified" messages are
> > still shown.  This patch makes them disappear, too.
> 
> Files being "locally modified" is not and error, so I think it is in line
> with the spirit of what -q is meant to do.
> 
> It is an interface change, though.

Yes, as "needs update" -> "locally modified" was.

However, scripts, that rely on filenames when doing -q (whyever),
will break.

So should I stick to "git reset -q foo >/dev/null" if I want it quiet,
or is there some chance of inclusion?

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
