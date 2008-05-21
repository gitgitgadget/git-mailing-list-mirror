From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] pull --rebase: exit early when the working directory
 is dirty
Date: Wed, 21 May 2008 14:04:54 +0200
Message-ID: <48340FE6.90902@op5.se>
References: <alpine.DEB.1.00.0805211230290.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 21 14:06:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jyn4r-0000WU-63
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 14:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761146AbYEUME7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 08:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbYEUME7
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 08:04:59 -0400
Received: from mail.op5.se ([193.201.96.20]:57346 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754053AbYEUME6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 08:04:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id C7A6724B12C5;
	Wed, 21 May 2008 14:02:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8n2S1MjuxFE4; Wed, 21 May 2008 14:02:22 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.27])
	by mail.op5.se (Postfix) with ESMTP id A77EC1B8007E;
	Wed, 21 May 2008 14:02:21 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <alpine.DEB.1.00.0805211230290.30431@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82540>

Johannes Schindelin wrote:
> When rebasing fails during "pull --rebase", you cannot just clean up the
> working directory and call "pull --rebase" again, since the remote branch
> was already fetched.
> 
> Therefore, die early when the working directory is dirty.


Funny stuff. I helped a co-worker with just exactly this issue less than
ten minutes ago, so, fwiw:
Liked-by: Andreas Ericsson <ae@op5.se>

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
