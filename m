From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 0/4] Blame in reverse
Date: Thu, 03 Apr 2008 13:25:12 +0200
Message-ID: <47F4BE98.8060209@viscovery.net>
References: <7v4paj486a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 13:26:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhNZy-00075B-8x
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 13:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754172AbYDCLZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 07:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753563AbYDCLZS
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 07:25:18 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:45324 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069AbYDCLZR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 07:25:17 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JhNYD-0001Jf-AT; Thu, 03 Apr 2008 13:24:13 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id BB1BA546; Thu,  3 Apr 2008 13:25:12 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7v4paj486a.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78746>

Junio C Hamano schrieb:
> Usual "git blame" starts from the latest revision and finds where each
> line came from (i.e. who came up with that brilliant idea, or more often
> who introduced that bug).  This new mode starts from an old revision, and
> annotates in reverse --- up to which point each line survived, before it
> got replaced with something else. 

Nice!! Is the result somehow different from

	$ git rev-list --reverse HEAD > /tmp/blame.revs
	$ git blame -S /tmp/blame.revs foo.c

?

-- Hannes
