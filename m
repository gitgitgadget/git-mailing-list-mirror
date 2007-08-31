From: Johannes Sixt <j.sixt@eudaptics.com>
Subject: Re: [PATCH] Test for windows format absolute paths on cygwin too
Date: Fri, 31 Aug 2007 11:31:12 +0200
Message-ID: <46D7DFE0.6040606@eudaptics.com>
References: <xMhwifY1.1188551240.4001640.roro@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 11:32:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR2rc-0002KK-2g
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 11:32:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758655AbXHaJcE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 05:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbXHaJcB
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 05:32:01 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:62700 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756608AbXHaJcA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 05:32:00 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1IR2r8-0005iz-PF; Fri, 31 Aug 2007 11:31:59 +0200
Received: from [192.168.1.42] (j6t.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 47D114E4; Fri, 31 Aug 2007 11:31:58 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <xMhwifY1.1188551240.4001640.roro@localhost>
X-Spam-Score: 1.3 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, AWL=-0.368, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57142>

Robin Rosenberg schrieb:
> ---
> 
> Requires cherry-picking 6397c3119ecaa258b5185315c64062bec29bcd86

... which you find in mingw.git.

However, that commit is not signed-off for a reason: It is going to be 
rewritten mostly because it doesn't yet use the is_absolute_path() from 
git-compat-util.h.

-- Hannes
