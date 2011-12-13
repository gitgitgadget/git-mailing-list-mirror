From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/2] Makefile: optionally exclude code that needs Unix
 sockets
Date: Tue, 13 Dec 2011 21:00:26 +0100
Message-ID: <4EE7AEDA.6090509@kdbg.org>
References: <20111210103943.GA16478@sigill.intra.peff.net> <20111210104130.GI16648@sigill.intra.peff.net> <4EE66DAB.5070407@kdbg.org> <4EE66E58.6040404@kdbg.org> <20111212213951.GB9754@sigill.intra.peff.net> <7vzkexwb7m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 21:00:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaYWh-0006LP-3Y
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 21:00:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755216Ab1LMUAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 15:00:30 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:1694 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751453Ab1LMUA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 15:00:29 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 08A12CDF87;
	Tue, 13 Dec 2011 21:01:04 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 203CC19F5F7;
	Tue, 13 Dec 2011 21:00:26 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <7vzkexwb7m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187050>

Am 13.12.2011 01:45, schrieb Junio C Hamano:
> I'll queue a single patch that is a squash between 2/2 and Peff's test
> updates between "credentials: add "cache" helper" and "strbuf: add
> strbuf_add*_urlencode" in the series.

Thanks. The resulting series builds fine on Windows and passes/skips the
new tests in the expected manner.

-- Hannes
