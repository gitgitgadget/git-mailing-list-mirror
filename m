From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Makefile: update the default build options for AIX
Date: Fri, 16 May 2008 15:37:11 +0200
Message-ID: <482D8E07.3050300@viscovery.net>
References: <1210149355875-git-send-email-mike@abacus.co.uk>	 <4821992F.4060201@viscovery.net> <e2b179460805160319n420c309eg9b9bbb1e3adb299@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 15:38:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx08O-0003JQ-2H
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 15:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755467AbYEPNhQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 09:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755448AbYEPNhQ
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 09:37:16 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:30320 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755278AbYEPNhP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 09:37:15 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Jx07U-0004SR-5F; Fri, 16 May 2008 15:37:12 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D2BFC6C4; Fri, 16 May 2008 15:37:11 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <e2b179460805160319n420c309eg9b9bbb1e3adb299@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82285>

Mike Ralphson schrieb:
> 2008/5/7 Johannes Sixt <j.sixt@viscovery.net>:
>> Mike Ralphson schrieb:
>>> NO_MKDTEMP is required to build, FREAD_READS_DIRECTORIES and the definition
>>> of _LARGE_FILES fix test suite failures and INTERNAL_QSORT is required for
>>> adequate performance.
>> I'm trying this patch on AIX 4.3.3 (sigh!) with gcc3...
> 
> Now the interaction between FREAD_READS_DIRECTORIES and _LARGE_FILES
> has been sorted out, and the
> wt-status.h warning fix is also in, did you manage to finish testing
> this? The INTERNAL_QSORT gave me a 2 orders of magnitude speed up on
> git status / commit etc.
> 
> I should have mentioned that I build with SHELL_PATH = /bin/bash and
> ensure that /usr/linux/bin (or /opt/freeware/bin) from the AIX toolbox
> is prepended to the PATH to run the test-suite. I didn't want to fold
> these into the patch as the paths are somewhat environment specific.

I compiled git on AIX 4.3.3.  Even though the testsuite does not pass (due
to a too old perl, non-working libiconv, and a sed that does not print the
last line if there's no LF at the end), there's no failure that I would
attribute to your changes. Therefore, I'd say:

Tested-by: Johannes Sixt <johannes.sixt@telecom.at>

-- Hannes
