From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: --first-parent plus path limiting
Date: Tue, 29 Jan 2008 10:05:01 +0100
Message-ID: <479EEC3D.9030100@viscovery.net>
References: <479EE405.1010001@viscovery.net> <7vk5ltow61.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 10:05:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJmPc-00052j-At
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 10:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619AbYA2JFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 04:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753663AbYA2JFI
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 04:05:08 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:14208 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753619AbYA2JFG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 04:05:06 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JJmOd-0004Fv-Pf; Tue, 29 Jan 2008 10:04:48 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A95C56D9; Tue, 29 Jan 2008 10:05:01 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vk5ltow61.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71970>

Junio C Hamano schrieb:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> While trying to find out when builtin-fetch.c was merged into master, I
>> noticed that this:
>>
>> $ git log --first-parent --pretty=oneline -- builtin-fetch.c
>>
>> lists b888d61c (Make fetch a builtin), which I did not expect.
> 
> Why didn't you?

Because ... [see below]

>> This one
>> doesn't list it, as expected:
>>
>> $ git log --first-parent --pretty=oneline
> 
> Why did you expect that?  This tells "follow only the first
> parent chain, ignoring all merges".

With "as expected" I actually meant "as expected", not "contrary to
expectations" ;) So, I did expect *not* to see the commit when the path is
not limited.

> The former is about "First simplify the history with respect to
> builtin-fetch.c, and then follow the first-parent of the
> simplified history.

I was expecting that it works like "First follow the first-parent, and
then simplify the history with respect to builtin-fetch.c." But that's
certainly a matter of definition. In this case, I would have found my
interpretation more useful, but then I don't use --first-parent that often...

Thanks for your clarifications,
-- Hannes
