From: Andrew Wong <andrew.w@sohovfx.com>
Subject: Re: [BUG] rebase -p loses commits
Date: Mon, 16 May 2011 20:33:59 -0400
Message-ID: <4DD1C277.9070605@sohovfx.com>
References: <20110516103354.GA23564@sigill.intra.peff.net> <7vfwoel6vw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 02:39:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM8K4-0002g0-6n
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 02:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381Ab1EQAeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 20:34:10 -0400
Received: from smtp03.beanfield.com ([76.9.193.172]:59846 "EHLO
	smtp03.beanfield.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235Ab1EQAeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 20:34:09 -0400
X-Spam-Status: No
X-beanfield-mta03-MailScanner-From: andrew.w@sohovfx.com
X-beanfield-mta03-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-2.9, required 6, autolearn=not spam, ALL_TRUSTED -1.00,
	BAYES_00 -1.90)
X-beanfield-mta03-MailScanner: Found to be clean
X-beanfield-mta03-MailScanner-ID: 1QM8Ef-000CoI-Fs
Received: from [24.246.58.202] (helo=ZanarkandMac.local)
	by mta01.beanfield.com with esmtpsa (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.76)
	(envelope-from <andrew.w@sohovfx.com>)
	id 1QM8Ef-000CoI-Fs; Mon, 16 May 2011 20:34:05 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <7vfwoel6vw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173775>

On 05/16/2011 04:36 PM, Junio C Hamano wrote:
>     F---*  feature
>    /   /
>   B---M    master
>
> But what does it mean to rebase that on top of master, preserving merges
> in the first place? You are already on top of 'master' and '*' itself
> should be what you should get, no?  IOW, shouldn't you already be
> up-to-date?
>    
Since preserve-merge uses the interactive-rebase, I think 
interactive-rebase should still pick the merge commit, which will then 
be consistent with what's happening if we rebase onto "F". So, without 
knowing whether "F" or "M" is the first-parent, I think 
interactive-rebase onto "F" and onto "M" should have the same effect. 
i.e. interactive-rebase picks the merge commit
