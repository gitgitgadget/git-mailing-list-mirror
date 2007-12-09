From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 2/2] Add support for URLs to git-apply
Date: Sun, 09 Dec 2007 22:04:41 +0100
Message-ID: <475C5869.4080900@op5.se>
References: <1197194672-28568-1-git-send-email-mh@glandium.org> <1197194672-28568-2-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Dec 09 22:05:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1TKk-0007Fv-SU
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 22:05:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbXLIVEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 16:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbXLIVEq
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 16:04:46 -0500
Received: from mail.op5.se ([193.201.96.20]:42208 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751009AbXLIVEp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 16:04:45 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 20CBD1F08028;
	Sun,  9 Dec 2007 22:04:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o9hMrm8UtlKb; Sun,  9 Dec 2007 22:04:43 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 2F5611F08027;
	Sun,  9 Dec 2007 22:04:43 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <1197194672-28568-2-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67662>

Mike Hommey wrote:
> Instead of doing several "wget -O - url | git-apply -" in a raw, you now
> can just git-apply url1 url2 ...
> 

I seriously like this idea. Combined with gitweb (or cgit), it could be
used as a cherry-pick from someone else's repo :)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
