From: Andrew Wong <andrew.w@sohovfx.com>
Subject: Re: [PATCH] rebase -i -p: doesn't pick certain merge commits that
 are children of "upstream"
Date: Sat, 18 Jun 2011 18:13:05 -0400
Message-ID: <4DFD22F1.3080007@sohovfx.com>
References: <4DEB495F.9080900@kdbg.org>	<1307419725-4470-1-git-send-email-andrew.kw.w@gmail.com>	<1307419725-4470-2-git-send-email-andrew.kw.w@gmail.com>	<7vmxhlpvob.fsf@alter.siamese.dyndns.org>	<4DF64932.1090607@sohovfx.com>	<20110616172454.13ff1a18@sh9>	<4DFC4863.2090803@sohovfx.com>	<20110618101718.6ff03688@sh9>	<4DFCD6A5.7000707@sohovfx.com> <20110618121222.03ee0b79@sh9>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Andrew Wong <andrew.kw.w@gmail.com>, git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Sun Jun 19 00:16:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QY3oN-000385-PN
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 00:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753166Ab1FRWNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jun 2011 18:13:12 -0400
Received: from smtp01.beanfield.com ([76.9.193.170]:64284 "EHLO
	smtp01.beanfield.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076Ab1FRWNL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2011 18:13:11 -0400
X-Spam-Status: No
X-beanfield-mta01-MailScanner-From: andrew.w@sohovfx.com
X-beanfield-mta01-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-2.9, required 6, autolearn=not spam, ALL_TRUSTED -1.00,
	BAYES_00 -1.90)
X-beanfield-mta01-MailScanner: Found to be clean
X-beanfield-mta01-MailScanner-ID: 1QY3lJ-0004w1-Lv
Received: from [24.246.58.202] (helo=ZanarkandMac.local)
	by mta01.beanfield.com with esmtpsa (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.76)
	(envelope-from <andrew.w@sohovfx.com>)
	id 1QY3lJ-0004w1-Lv; Sat, 18 Jun 2011 18:13:05 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <20110618121222.03ee0b79@sh9>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175992>

On 11-06-18 1:12 PM, Stephen Haberman wrote:
> ...I can think of cases where personally I'd want to only move
> around commits on the first-parent line, e.g. even in the case of
> "rebase-i-p A1", to have less noise (C1 and any others on its branch)
> in the todo, but at that point it sounds like I'm projecting behavior
> onto rebase-i-p that isn't actually there.
Yes, it would definitely be useful to be able to do that.  In fact, 
there's a somewhat relevant expect-failure-test t3404.18 that is testing 
for that.  Like you said, we need a way to express topology in the todo 
list, which I'm not sure what a good representation is.
