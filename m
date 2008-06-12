From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git-fast-export bug, commits emmitted in incorrect order	causing
 parent data to be lost from commits turning essentially linear repo	into
 "islands"
Date: Thu, 12 Jun 2008 14:45:57 +0200
Message-ID: <48511A85.9020200@viscovery.net>
References: <1213266100.6940.207.camel@gemini>	 <48510E2E.6090508@viscovery.net>  <1213272285.6940.222.camel@gemini> <1213272962.6940.231.camel@gemini>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Yves Orton <yves.orton@booking.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 14:47:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6mCi-0007mO-B6
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 14:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758341AbYFLMqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 08:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757050AbYFLMqA
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 08:46:00 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:48829 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071AbYFLMp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 08:45:59 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1K6mBh-0005sn-Jt; Thu, 12 Jun 2008 14:45:57 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5825E69F; Thu, 12 Jun 2008 14:45:57 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1213272962.6940.231.camel@gemini>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84753>

Yves Orton schrieb:
> BTW, for the record this was needed because we are trying to merge
> multiple git repos into a single new git repo with each original repo
> mapped into a subdirectory of the new repo, and with commit trees merged
> in more or less the correct order (by date applied more or less). IOW we
> dont want to have multiple "root commits" that are later merged. 

Try --date-order instead. It might work better for your task, and it still
offers a topologically correct order.

-- Hannes
