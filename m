From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v2 2/2] pickaxe: allow -i to search in patch case-insensitively
Date: Wed, 29 Feb 2012 12:40:32 +0100
Message-ID: <87wr75q34f.fsf@thomas.inf.ethz.ch>
References: <1330474831-9030-1-git-send-email-gitster@pobox.com>
	<1330474831-9030-3-git-send-email-gitster@pobox.com>
	<20120229083534.GC14181@sigill.intra.peff.net>
	<7vy5rmt3w8.fsf@alter.siamese.dyndns.org>
	<20120229091855.GE14181@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 29 12:41:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2hu8-0002WR-Qi
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 12:41:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757904Ab2B2Lk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 06:40:59 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:36870 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757850Ab2B2Lkh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 06:40:37 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 29 Feb
 2012 12:40:32 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 29 Feb
 2012 12:40:34 +0100
In-Reply-To: <20120229091855.GE14181@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 29 Feb 2012 04:18:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191832>

Jeff King <peff@peff.net> writes:

> I am a little dubious of the decision in jc/diff-ignore-case to have
> "-i" imply "--ignore-case". For "git diff", it makes perfect sense. But
> for "git log", it feels wrong. Ignoring case for the regexps is very
> common, and ignoring case for the diffs is uncommon (it is, after all, a
> feature we have gone many years without, and I don't remember anyone
> bringing it up until recently).

Doubly so because (to the best of my list-reading efforts) when it was
brought up recently, the interpretation as "case-insensitive diff
generation" was by mistake/misreading.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
