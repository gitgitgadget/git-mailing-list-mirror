From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 5/7] grep.c: mark private file-scope symbols as static
Date: Thu, 20 Sep 2012 21:43:16 +0100
Message-ID: <505B7FE4.1050706@ramsay1.demon.co.uk>
References: <5054AA62.2040603@ramsay1.demon.co.uk> <1347743452-2487-1-git-send-email-gitster@pobox.com> <1347743452-2487-5-git-send-email-gitster@pobox.com> <505A08A1.1080303@ramsay1.demon.co.uk> <7vfw6dg2q6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 22:46:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEndL-00036D-3E
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 22:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023Ab2ITUpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 16:45:52 -0400
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:41918 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753894Ab2ITUpw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 16:45:52 -0400
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 94D42A0C07F;
	Thu, 20 Sep 2012 21:45:49 +0100 (BST)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id BA68CA0C073;	Thu, 20 Sep 2012 21:45:48 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;	Thu, 20 Sep 2012 21:45:47 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7vfw6dg2q6.fsf@alter.siamese.dyndns.org>
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206089>

Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>> Heh, so I obviously didn't see this before sending the patch yesterday! :-D
>>
>> Yes, this solves the problem addressed by yesterday's patch, so please
>> ignore that. However, this tickles sparse to complain as well ... ;-)
>>
>> New patch on it's way.
> 
> Are you sure the patch you are responding to really "tickles
> sparse"?

Yes.

> You have another grep.c patch timestamped two minutes after the
> message I am responding to, and as far as I can see, it is a subset
> of the patch you are responding to with the message I am responding
> to.

Hmm, that sentence has too many twists for me! :-D

Let me see if I can clear up the misunderstanding:

    - the "patch from yesterday" (18-09-2021) fixed a complaint from
      sparse regarding symbol 'dump_grep_expression'. This was before
      I had seen this patch email, or the resulting commit 07a7d656.
      Since my "patch from yesterday" is a strict subset of your patch,
      then your patch also fixes the complaint from sparse regarding
      the 'dump_grep_expression' symbol.

    - this patch (commit 07a7d656) causes sparse to complain about the
      symbols 'grep_source_load' and 'grep_source_is_binary'. The new
      patch from me ("timestamped two minutes after ...") also titled
      "grep.c: Fix some sparse warnings" on 19-09-2012 at 7:04 PM, is
      *not* a subset of commit 07a7d656. This patch addresses the new
      sparse warnings regarding 'grep_source_load' and
      'grep_source_is_binary'.

Hopefully that addresses the confusion! ;-)

HTH

ATB,
Ramsay Jones
