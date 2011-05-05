From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: t5541: Bad file descriptor
Date: Thu, 5 May 2011 02:57:20 -0400
Message-ID: <6F83A7A8-F4D7-4E1B-B6F4-03AE004C5726@gernhardtsoftware.com>
References: <3340686A-18D8-4279-87F0-580262DD4DFA@gernhardtsoftware.com> <7voc3hbtgu.fsf@alter.siamese.dyndns.org> <20110505054611.GA29033@sigill.intra.peff.net> <20110505061845.GC29033@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 05 08:57:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHsVZ-00087E-CN
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 08:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964Ab1EEG5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 02:57:52 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:38875 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384Ab1EEG5v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 02:57:51 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id E09821FFC134; Thu,  5 May 2011 06:57:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-65-60-43.rochester.res.rr.com [74.65.60.43])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 51B9B1FFC0F6;
	Thu,  5 May 2011 06:57:08 +0000 (UTC)
In-Reply-To: <20110505061845.GC29033@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172809>


On May 5, 2011, at 2:18 AM, Jeff King wrote:

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
> 
> -- >8 --
> Subject: [PATCH] send-pack: unbreak push over stateless rpc

While I could not get the patch to apply as-is (git apply complained of trailing whitespace), I performed the changes by hand and t5541 passed once more.

~~ Brian
