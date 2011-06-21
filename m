From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] stash: Add --clean option to stash and remove all untracked
 files
Date: Tue, 21 Jun 2011 08:28:31 +0200
Message-ID: <4E003A0F.5080601@viscovery.net>
References: <1308612986-26593-1-git-send-email-david@porkrind.org> <20110621003852.GB2050@sigill.intra.peff.net> <4DFFF5AA.4030401@porkrind.org> <4E002762.3050803@sohovfx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: David Caldwell <david@porkrind.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Andrew Wong <andrew.w@sohovfx.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 08:28:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYuS5-0004mR-P7
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 08:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588Ab1FUG2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 02:28:40 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:17387 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974Ab1FUG2j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 02:28:39 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QYuRs-000836-7J; Tue, 21 Jun 2011 08:28:32 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id E6E8D1660F;
	Tue, 21 Jun 2011 08:28:31 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <4E002762.3050803@sohovfx.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176126>

Am 6/21/2011 7:08, schrieb Andrew Wong:
> Ah, this patch will be very useful. I actually ran into several scenarios
> before where I wished stash could do exactly this.
> 
> On 11-06-20 9:36 PM, David Caldwell wrote:
>> On 6/20/11 5:38 PM, Jeff King wrote:
>>> Hmm. I think I would call this something like "--untracked", as to me
>>> the main function is saving those files, not cleaning them afterwards
>>> (the fact that they are cleaned is really just making the untracked-file
>>> handling in line with what we do for tracked files; we put the changes
>>> in the stash and remove them from the working tree).
>>
>> I see your point but I thought "--clean" was pretty descriptive of how
>> the working dir ended up afterward. Maybe "git stash --everything" (or
>> "--all")?
> I personally think "--untracked" (and -u) is more intuitive too, since it
> tells you what "git stash" is about to do. i.e. "git stash" is about to do
> the usual stash operation *and* also stash the "untracked" files.

Really?

   $ git stash --untracked

sound like it stashes *only* untracked files. (That by itself may be a
feature that some people want; so far, I'm not among them.)

-- Hannes
