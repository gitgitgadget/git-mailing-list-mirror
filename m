From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2] Do not unquote + into ' ' in URLs
Date: Sat, 31 Jul 2010 23:33:38 +0200
Message-ID: <201007312333.38471.trast@student.ethz.ch>
References: <201007240104.25341.trast@student.ethz.ch> <ed2d311355fca478f97b82f8d955494509d6b9de.1279982471.git.trast@student.ethz.ch> <AANLkTikY_ayRzdbQ2Qsf6wus+=yg99aTLDTahVXUw0eK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	<avarab@gmail.com>, "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Jasper St. Pierre" <jstpierre@mecheye.net>
X-From: git-owner@vger.kernel.org Sat Jul 31 23:34:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfJh4-00020t-Cm
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 23:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756930Ab0GaVeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jul 2010 17:34:04 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:11258 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756853Ab0GaVeD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 17:34:03 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sat, 31 Jul
 2010 23:34:01 +0200
Received: from thomas.site (217.162.250.31) by CAS11.d.ethz.ch (172.31.38.211)
 with Microsoft SMTP Server (TLS) id 14.0.702.0; Sat, 31 Jul 2010 23:33:39
 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <AANLkTikY_ayRzdbQ2Qsf6wus+=yg99aTLDTahVXUw0eK@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152340>

Jasper St. Pierre wrote:
> Hmm.. could we get a follow-up on this patch? It's annoying because it's both
> backwards and forwards incompatible: the %2b workaround doesn't work in
> older versions.

I was hoping for an Ack from someone who knows the whole HTTP
business, because I don't feel confident enough to say it won't break
anything there.

To be precise, if the client ever attempts to decode URLs with query
strings (for whatever reasons) then it would break.  Probably there
are no such URLs, but I don't know for sure.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
