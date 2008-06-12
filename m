From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git-fast-export bug, commits emmitted in incorrect order causing
   parent data to be lost from commits turning essentially linear repo into
   "islands"
Date: Thu, 12 Jun 2008 13:53:18 +0200
Message-ID: <48510E2E.6090508@viscovery.net>
References: <1213266100.6940.207.camel@gemini>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Yves Orton <yves.orton@booking.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 13:54:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6lNf-0004AH-Jv
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 13:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288AbYFLLxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 07:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752214AbYFLLxV
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 07:53:21 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:44958 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbYFLLxU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 07:53:20 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1K6lMk-0003Vq-UT; Thu, 12 Jun 2008 13:53:19 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B540169F; Thu, 12 Jun 2008 13:53:18 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1213266100.6940.207.camel@gemini>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84746>

Yves Orton schrieb:
> Hi,
> 
> Ive been working with git-fast-export a bit recently and Ive hit a bug
> that is causing some trouble. 
> 
> Essentially it seems that one of our repos git-fast-export fails to emit
> the proper 'from' information for several commits in the repo. These
> commits are emitted first without parent data even though their parents
> ARE emitted later.

Does it make a difference if you pass --topo-order to git fast-export?
(But I don't know for certain that this is even legal.)

-- Hannes
