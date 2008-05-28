From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-svn commit id.
Date: Wed, 28 May 2008 16:41:20 +0200
Message-ID: <483D6F10.5000403@op5.se>
References: <1211983320.15736.11.camel@omicron.ep.petrobras.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Victor Bogado da Silva Lins <victor@bogado.net>
X-From: git-owner@vger.kernel.org Wed May 28 16:46:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1Mr1-0004y7-KR
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 16:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbYE1OlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 10:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbYE1OlX
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 10:41:23 -0400
Received: from mail.op5.se ([193.201.96.20]:51351 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751281AbYE1OlW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 10:41:22 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 4BE0C1B800A3;
	Wed, 28 May 2008 16:39:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AUUpo1T+tQgO; Wed, 28 May 2008 16:39:33 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.27])
	by mail.op5.se (Postfix) with ESMTP id 8156C1B8009C;
	Wed, 28 May 2008 16:39:33 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <1211983320.15736.11.camel@omicron.ep.petrobras.com.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83094>

Victor Bogado da Silva Lins wrote:
> I have two git-svn repositories here and I noticed that the same commit
> have different ids in them. How this came to be, both commits share the
> exact same git-svn-id and are the same (as far as I know). 
> 

If the have exactly the same history leading up to them, source trees
and commit object (including timestamps), the only way they can be any
different is if you've run into a bug in the SHA1 libraries.

If either of the above three are different though, you *will* end up
with different commits.

Try doing "git cat-file commit <sha1-of-one-commit>" and then
"git cat-file commit <sha1-of-other-commit>". If you take a diff
between the two, you'll see how they differ (my guess would be the
timestamps)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
