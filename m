From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fixing path quoting issues
Date: Thu, 11 Oct 2007 09:10:46 +0200
Message-ID: <470DCC76.7070809@viscovery.net>
References: <11920508172434-git-send-email-jon.delStrother@bestbefore.tv>	<470DC05A.8020209@viscovery.net> <854pgytafi.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan del Strother <jon.delStrother@bestbefore.tv>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Oct 11 09:11:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfsCB-0008Uc-V5
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 09:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180AbXJKHKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 03:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753055AbXJKHKu
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 03:10:50 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:24563 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbXJKHKt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 03:10:49 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IfsBq-0000DH-No; Thu, 11 Oct 2007 09:10:38 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 3F521A33B; Thu, 11 Oct 2007 09:10:46 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <854pgytafi.fsf@lola.goethe.zz>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60583>

David Kastrup schrieb:
> Johannes Sixt <j.sixt@viscovery.net> writes:
>> IMHO, it's not too much of a burden for developers to require "sane"
>> build directory paths.
> 
> For a normal user, the only writable directories might be of the
> "C:\Programs and Data\User settings\Karl"
> variety.

I whole-heartedly agree about the part of the patch that fixes 
git-rebase.sh. This should be a separate patch.

But the reset of the patch is about running the test suite, and it is much 
more difficult to fix because of the 'eval' that is going on. And, yes, I do 
think that we can expect that contributors, including this handful of people 
on Windows, have a "sane" build directory.

-- Hannes
