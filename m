From: Andrew Wong <andrew.w@sohovfx.com>
Subject: Re: [BUG] rebase -p loses commits
Date: Mon, 16 May 2011 15:42:40 -0400
Message-ID: <4DD17E30.6030607@sohovfx.com>
References: <20110516103354.GA23564@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 16 21:42:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM3gp-0006l1-6g
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 21:42:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754919Ab1EPTmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 15:42:44 -0400
Received: from smtp03.beanfield.com ([76.9.193.172]:60434 "EHLO
	smtp03.beanfield.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754568Ab1EPTmn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 15:42:43 -0400
X-Spam-Status: No
X-beanfield-mta03-MailScanner-From: andrew.w@sohovfx.com
X-beanfield-mta03-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-2.9, required 6, autolearn=not spam, ALL_TRUSTED -1.00,
	BAYES_00 -1.90)
X-beanfield-mta03-MailScanner: Found to be clean
X-beanfield-mta03-MailScanner-ID: 1QM3gf-000Esl-2V
Received: from [66.207.196.114] (helo=[192.168.1.112])
	by mta01.beanfield.com with esmtpa (Exim 4.76)
	(envelope-from <andrew.w@sohovfx.com>)
	id 1QM3gf-000Esl-2V; Mon, 16 May 2011 15:42:41 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101026 SUSE/3.0.10 Thunderbird/3.0.10
In-Reply-To: <20110516103354.GA23564@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173750>

On 05/16/2011 06:33 AM, Jeff King wrote:
> I was trying to reproduce somebody's issue with a minimal test case, and
> I ran across this setup wherein "rebase -p" silently drops some commits:
>   

This particular patch seems to have something to do with the bug:
    d80d6bc146232d81f1bb4bc58e5d89263fd228d4
    http://thread.gmane.org/gmane.comp.version-control.git/98247/focus=98251

However, I can't figure out what the "odd boundary case" that this patch
was supposed to fix is. Anyone have any idea?

Andrew
