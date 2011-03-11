From: Dietmar Winkler <dietmarw@gmx.de>
Subject: Re: Fwd: [PATCH 2/2] pretty.c: allow date formats in user format
 strings
Date: Fri, 11 Mar 2011 09:33:30 +0100
Message-ID: <4D79DE5A.9060700@gmx.de>
References: <20110305195020.GA3089@sigill.intra.peff.net> <20110305200010.GB32095@sigill.intra.peff.net> <AANLkTinH8zwX2sbd5bpk=x4R3zOAg3Dc92Fbspfdv03T@mail.gmail.com> <AANLkTikaN=wsg6RLFaFxh=L3RCYjKkVGFR4VTrQ=KRZk@mail.gmail.com> <20110307161758.GB11934@sigill.intra.peff.net> <7v39mw9f7a.fsf@alter.siamese.dyndns.org> <20110310223148.GD15828@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Will Palmer <wmpalmer@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 11 09:33:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pxxn2-0004JL-Hi
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 09:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740Ab1CKIde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 03:33:34 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:51718 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752655Ab1CKIde (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 03:33:34 -0500
Received: (qmail invoked by alias); 11 Mar 2011 08:33:32 -0000
Received: from pc88180.hit.no (EHLO [128.39.88.180]) [128.39.88.180]
  by mail.gmx.net (mp020) with SMTP; 11 Mar 2011 09:33:32 +0100
X-Authenticated: #223389
X-Provags-ID: V01U2FsdGVkX19lTLNc6+5lgD2jOIkXL4z4CbBy7QrueCDUIefYUv
	lyA1yoz0Iya4d8
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.23) Gecko/20090817 Thunderbird/2.0.0.23 Mnenhy/0.7.5.0
In-Reply-To: <20110310223148.GD15828@sigill.intra.peff.net>
X-Enigmail-Version: 1.1.1
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168890>

Den 10. mars 2011 23:31, skrev Jeff King:
> OK. Do you want me to throw away the %ad(format) patch for now, then, in
> favor of building it on top of a more sane syntax?
> 
> I had originally planned to do %ad(format) for now, and then worry about
> syntax later. Since we already have a variety of of other placeholders
> with similar syntax (e.g., %w(), %C()). But I don't care too much either
> way; it is not a feature I personally wanted, so delay doesn't bother
> me. Dietmar (the original requestor) may feel differently, of course. :)

As much as I would like to have such a feature (and a documentation that
is in synch with the implementation ;) I don't heavily rely on it. I'm
happy to wait a bit longer in favour of a more complete and clean
implementation which also opens up for other %(longname:options) support.
-- 
Dietmar.
