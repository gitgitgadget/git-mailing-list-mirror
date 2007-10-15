From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 14:31:01 +0200
Message-ID: <47135D85.50701@viscovery.net>
References: <1192293466.17584.95.camel@homebase.localnet>	<uy7e6keyv.fsf@gnu.org>	<1192381040.4908.57.camel@homebase.localnet>	<1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>	<47125F74.9050600@op5.se>	<Pine.LNX.4.64.0710141934310.25221@racer.site> 	<47126957.1020204@op5.se>	<Pine.LNX.4.64.0710142112540.25221@racer.site> 	<20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>	<Pine.LNX.4.64.0710150039120.25221@racer.site>	<4712B616.165BBF8D@dessent.net>	<Pine.LNX.4.64.0710150217120.25221@racer.site>	<Pine.LNX.4.64.0710150223230.25221@racer.site>	<E1IhJ4K-00086x-5U@fencepost.gnu.org>	<AD60F584-7AAD-4083-9BA6-21F0D00D6D1D@zib.de>	<E1IhLBW-0006uw-19@fencepost.gnu.org>	<Pine.LNX.4.64.0710150946500.25221@racer.site> <E1IhNox-0004n2-N5@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, prohaska@zib.de,
	make-w32@gnu.org, raa.lkml@gmail.com, ae@op5.se,
	git@vger.kernel.org
To: Eli Zaretskii <eliz@gnu.org>
X-From: git-owner@vger.kernel.org Mon Oct 15 14:31:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhP6M-0006P3-DT
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 14:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759126AbXJOMbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 08:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759572AbXJOMbF
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 08:31:05 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:41879 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759126AbXJOMbE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 08:31:04 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IhP5u-0007bn-Pp; Mon, 15 Oct 2007 14:30:51 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 50FB269F; Mon, 15 Oct 2007 14:31:01 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <E1IhNox-0004n2-N5@fencepost.gnu.org>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60988>

Eli Zaretskii schrieb:
>> Date: Mon, 15 Oct 2007 09:47:25 +0100 (BST)
>> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>> cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org, 
>>     raa.lkml@gmail.com, ae@op5.se, tsuna@lrde.epita.fr, make-w32@gnu.org
>>
>> If you could make Git compile with Visual C++, that would be fabulous.
> 
> I prefer GCC (the MinGW port), but without the MSYS ports of
> additional tools.  I use the GnuWin32 ports augmented by some of my
> own (where GnuWin32 ports are buggy or terribly slow).

They should work, too. If a tool is missing, ought to notice it soon enough.

These are important to note, though:

- The tools must not do their own LF->CRLF conversion when they are used in 
a pipeline, "just because they know it better".

- GNU tar is needed (in the cpio emulator).

- ln must be able to create hard links on NTFS or do the equivalent of
cp -p

- GNU cp -al will be needed and should create hard links on NTFS. (I plan to 
use it for local clones in place of cpio -pl.)

Any feedback on how git works for you with these tools is appreciated.

-- Hannes
