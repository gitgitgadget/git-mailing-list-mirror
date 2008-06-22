From: Andreas Ericsson <ae@op5.se>
Subject: Re: [q] git-diff --reverse 7def2be1..7def2be1^
Date: Sun, 22 Jun 2008 20:52:02 +0200
Message-ID: <485E9F52.1060706@op5.se>
References: <20080620082034.GA24913@elte.hu> <m3d4mcmq20.fsf@localhost.localdomain> <20080620135236.GC8135@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Sun Jun 22 20:53:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAUgw-0001yw-TW
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 20:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753303AbYFVSwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 14:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753002AbYFVSwK
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 14:52:10 -0400
Received: from mail.op5.se ([193.201.96.20]:37214 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752335AbYFVSwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 14:52:09 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id D32BD1B8036C;
	Sun, 22 Jun 2008 20:49:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Nj9Dh4iUPP7; Sun, 22 Jun 2008 20:49:45 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 130571B800A6;
	Sun, 22 Jun 2008 20:49:44 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20080620135236.GC8135@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85791>

Ingo Molnar wrote:
> * Jakub Narebski <jnareb@gmail.com> wrote:
> 
>>>    But Git didnt recognize that as a valid commit range.
>> There is shortcut for rev^..rev, namely rev^! (I'm not sure if it is 
>> documented anywhere, though), so you could have used
>>
>>         git diff 7def2be1^!
> 
> nice! :-)
> 

And for just a single revision, you can do

	git show -R 7def2be1

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
