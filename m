From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: combined diff, but not condensed, howto?
Date: Thu, 18 Sep 2008 08:24:38 +0200
Message-ID: <48D1F426.4040208@viscovery.net>
References: <48D0B907.7040903@viscovery.net> <7vwsha6761.fsf@gitster.siamese.dyndns.org> <48D1EDB7.5070107@viscovery.net> <7vy71qyo9d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 08:25:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgCxa-0004FS-Ea
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 08:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106AbYIRGYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 02:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752081AbYIRGYm
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 02:24:42 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:8554 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854AbYIRGYl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 02:24:41 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KgCwQ-0002mO-QA; Thu, 18 Sep 2008 08:24:39 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 9006A4FB; Thu, 18 Sep 2008 08:24:38 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vy71qyo9d.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96166>

Junio C Hamano schrieb:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> Junio C Hamano schrieb:
>>> Johannes Sixt <j.sixt@viscovery.net> writes:
>>>
>>>> After a merge conflict, 'git diff' shows a combined diff, which presents
>>>> only the parts that conflicted or where there are near-by changes from
>>>> different parents (potential conflicts). Is there a command line switch so
>>>> that *all* changes are shown, even non-conflicting ones?
>>> Like "git diff HEAD"?
>> No. Something that produces
> ...
> 
> Ah, I see what you mean.
> 
> It all happens inside combine-diff.c::make_hunks().  If you pass dense==0,
> you should be able to get all the uninteresting hunks, I think.
> 
> Perhaps
> 
> 	$ git diff --base -c

Yes, that does it!

Thanks,
-- Hannes
