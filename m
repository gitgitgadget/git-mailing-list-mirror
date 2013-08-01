From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: What's cooking in git.git (Jul 2013, #09; Mon, 29)
Date: Thu, 01 Aug 2013 21:51:51 +0100
Message-ID: <51FACA67.8090207@ramsay1.demon.co.uk>
References: <7vk3k9yol3.fsf@alter.siamese.dyndns.org> <51F94DFD.5020101@ramsay1.demon.co.uk> <7v4nbav9ys.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, tboegi@web.de, mhagger@alum.mit.edu,
	mlevedahl@gmail.com, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 01 22:53:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4zsV-0000BV-Ff
	for gcvg-git-2@plane.gmane.org; Thu, 01 Aug 2013 22:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996Ab3HAUxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Aug 2013 16:53:39 -0400
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:38315 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751877Ab3HAUxi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Aug 2013 16:53:38 -0400
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 1DF0CA64D24;
	Thu,  1 Aug 2013 21:53:37 +0100 (BST)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 75A57A64CB2;
	Thu,  1 Aug 2013 21:53:36 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;
	Thu,  1 Aug 2013 21:53:31 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <7v4nbav9ys.fsf@alter.siamese.dyndns.org>
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231505>

Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>>>  I am personally in favor of this simpler solution.  Comments?
>>
>> I had expected this to me marked for 'master'.
>>
>> Has this simply been overlooked, or do you have reservations about
>> applying this patch?
> 
> I am just being careful and do want to keep it cooking in 'next'
> during the feature freeze.  The more users work with 'next' (not
> "work *on* 'next'"), the more confidence we would be with, and
> hopefully this can be one of the topis that graduate early after
> the 1.8.4 release.

Hmm, this patch is a bug-fix for a bug that (currently) will be
_introduced_ by v1.8.4.

Do you want me to try and find a different bug-fix for v1.8.4?
(Although that would most likely be more risky than simply taking
this patch! ;-) ).

ATB,
Ramsay Jones
