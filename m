From: Andreas Ericsson <ae@op5.se>
Subject: Re: Is git-imap-send able to use SSL?
Date: Sun, 22 Jun 2008 21:11:01 +0200
Message-ID: <485EA3C5.1030502@op5.se>
References: <D3F1364D-68DC-457D-AC54-AE4B70B1B5AB@gmail.com> <20080621011622.39fd1625@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alam Arias <Alam.GBC@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 22 21:12:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAUz6-0007YS-GV
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 21:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758536AbYFVTLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 15:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758535AbYFVTLJ
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 15:11:09 -0400
Received: from mail.op5.se ([193.201.96.20]:45553 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758528AbYFVTLI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 15:11:08 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 0E1B61B80369;
	Sun, 22 Jun 2008 21:08:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YGWsAIZCt9jI; Sun, 22 Jun 2008 21:08:44 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 51FD21B800A6;
	Sun, 22 Jun 2008 21:08:44 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20080621011622.39fd1625@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85796>

Alam Arias wrote:
> On Fri, 20 Jun 2008 18:08:42 +0200
> Cristian Peraferrer <corellian.c@gmail.com> wrote:
> 
>> I am trying to use git-imap-send to send a Draft to my GMail account  
>> which uses SSL to connect, I have put the correct port (993 in that  
>> case) in the config file but it seems it doesn't work. I figure that  
>> git-imap-send is not able to connect using SSL.
>>
>  well, there a patch by for SSL support for git-imap-send by Rob
> Shearman "robertshearman@gmail.com" over two weeks ago but it did not
> apply cleanly on master at the time, well, maybe I can send
> my version of this patch? or do I need to ask Rob Shearman?
> 

Since the patch was made against the current git sources, which are GPL,
the patch itself and the produced sources are also GPL. As such, you're
free to continue the work he sent you and submit it back to git, but you
may not alter the license for your submitted code.

That is: "Yes, you may work on Rob Shearmans patch, but the result must
be GPL'd".

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
