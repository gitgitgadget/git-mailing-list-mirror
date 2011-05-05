From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: t5541: Bad file descriptor
Date: Thu, 05 May 2011 22:42:23 +0200
Message-ID: <4DC30BAF.2060009@kdbg.org>
References: <3340686A-18D8-4279-87F0-580262DD4DFA@gernhardtsoftware.com> <7voc3hbtgu.fsf@alter.siamese.dyndns.org> <20110505054611.GA29033@sigill.intra.peff.net> <20110505061845.GC29033@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 05 22:42:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI5Nd-0003Zs-1Z
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 22:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753458Ab1EEUma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 16:42:30 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:22039 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753335Ab1EEUm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 16:42:29 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 0C4EBA7EB6;
	Thu,  5 May 2011 22:38:50 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 00DBA19F387;
	Thu,  5 May 2011 22:42:23 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.14) Gecko/20110221 SUSE/3.1.8 Thunderbird/3.1.8
In-Reply-To: <20110505061845.GC29033@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172910>

Am 05.05.2011 08:18, schrieb Jeff King:
> OK, embarrassing. 09c9957 completely breaks smart http pushing. My
> testing of Johannes' patch was completely focused on the error case, and
> I didn't have a single test for the non-error case. And on top of that,
> we _have_ nice tests in the test suite to catch this, but obviously
> neither I, nor Johannes, nor Junio were running them (because they need
> apache installed and GIT_TEST_HTTPD set).
> 
> Ugh.
> 
> This patch on top of 09c9957 should fix it.

Very embarassing! Thanks for fixing up my mess. The patch looks good.

-- Hannes
