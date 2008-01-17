From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's in git.git (stable frozen)
Date: Thu, 17 Jan 2008 13:56:16 +0100
Message-ID: <478F5070.2020503@viscovery.net>
References: <7vk5m9kvf7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 13:56:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFUIe-0005jI-NT
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 13:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590AbYAQM4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 07:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752602AbYAQM4Y
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 07:56:24 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:40796 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbYAQM4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 07:56:24 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JFUI3-0004o7-Mc; Thu, 17 Jan 2008 13:56:16 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E07B154D; Thu, 17 Jan 2008 13:56:16 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vk5m9kvf7.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70854>

Junio C Hamano schrieb:
> There are a good deal of bugfixes in 'master', the largest of
> which is Brandon Casey's fix to builtin-commit and others'
> misuse of lockfile API.  A tentative fix for the issue was
> pushed out last night but the approach has known issues for our
> Windowsy friends, and this attempts to address them.
> 
> We've been taking pride that the tip of 'master' is always,
> without regression, more stable than any released version, but
> today's one might have uncovered glitches.  Please help testing
> it so that we do not have to leave it broken for a long time if
> it indeed is.

Except for the NO_MMAP issue introduced by c3b0dec509f that kills
git-fast-import in t9301* as discussed in a parallel thread, all tests
pass on Windows (MinGW port). This is a good sign since most, if not all,
issues around the lockfile API have been discovered by the test suite in
the past.

-- Hannes
