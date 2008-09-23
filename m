From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: rebasing merges
Date: Tue, 23 Sep 2008 10:00:09 +0200
Message-ID: <48D8A209.6090708@viscovery.net>
References: <20080922155749.c8070681.stephen@exigencecorp.com>	<20080922231927.ef18f420.stephen@exigencecorp.com>	<48D88813.9060400@viscovery.net> <20080923024653.a3bb8666.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 10:01:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki2q2-0004i1-3x
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 10:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916AbYIWIAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 04:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752906AbYIWIAN
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 04:00:13 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:44349 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848AbYIWIAL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 04:00:11 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ki2ob-0003t8-Im; Tue, 23 Sep 2008 10:00:10 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5423CAFCC; Tue, 23 Sep 2008 10:00:09 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080923024653.a3bb8666.stephen@exigencecorp.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96535>

Stephen Haberman schrieb:
>> This is the expected behavior and not up for debate.
> 
> Cool, thanks for the reply. However, I debate... :-)
> 
>>   ---o--o--o--o--o--o         <-- origin
>>                      \
>>                       A'--B'  <-- master
> 
> Nice. That makes sense in your scenario.
> 
> Here is mine:

I understand your problem very well. pull --rebase does not help your case
because it was not designed for your workflow (it was designed to help the
one that I sketched).

You are probably better served using fetch + rebase -i -p.

-- Hannes
