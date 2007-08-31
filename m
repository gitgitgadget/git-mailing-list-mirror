From: Johannes Sixt <j.sixt@telecom.at>
Subject: Re: [PATCH 1/2] Introduces xmkstemp()
Date: Fri, 31 Aug 2007 10:49:16 +0200
Message-ID: <46D7D60C.8090608@telecom.at>
References: <20070814164453.400b9c55@localhost> <46D7D0F7.1050302@trolltech.com> <46D7D284.30004@telecom.at> <46D7D48D.6000503@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 10:50:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR2Ch-0008SA-MF
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 10:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755521AbXHaIuH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 04:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755455AbXHaIuH
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 04:50:07 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:58944 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755148AbXHaIuF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 04:50:05 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@telecom.at>)
	id 1IR2CZ-000474-CG; Fri, 31 Aug 2007 10:50:03 +0200
Received: from [192.168.1.42] (j6t.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 01FE94E4; Fri, 31 Aug 2007 10:50:02 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <46D7D48D.6000503@trolltech.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57137>

Marius Storm-Olsen schrieb:
> Just wanted to let the original author know, so he would be aware of it, 
> and we wouldn't have to go the extra round-trips with patches to fix 
> patches. (And for MinGW awareness when adding code to git-compat-util.h)

You can't expect a lot of MinGW awareness from non-MinGW users when they 
make changes to git-compat-util.h since upstream does not have _any_ 
references to MinGW there, yet.

-- Hannes
