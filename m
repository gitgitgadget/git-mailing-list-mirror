From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Bisect visualize: use "for-each-ref" to list all good
 refs.
Date: Wed, 14 Nov 2007 11:05:50 +0100
Message-ID: <473AC87E.90107@viscovery.net>
References: <20071114055036.2c5ae793.chriscool@tuxfamily.org> <7voddxkzzw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 11:06:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsF8O-0006md-NX
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 11:06:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752377AbXKNKFy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 05:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752349AbXKNKFx
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 05:05:53 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:6037 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbXKNKFx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 05:05:53 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IsF7W-0002ly-QI; Wed, 14 Nov 2007 11:05:19 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E69C36B7; Wed, 14 Nov 2007 11:05:50 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7voddxkzzw.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64977>

Junio C Hamano schrieb:
> Even worse is that bisect_clean_state uses
> 
> 	rm -fr "$GIT_DIR/refs/bisect"
> 
> so if you ever pack your refs in the middle of bisection and
> then clean the state, you will still carry the old good set of
> commits that are somewhat hard to cull.

Heh. I think I'd done this once, and couldn't get rid of those refs with 
'git-bisect reset'. Now I know why.

-- Hannes
