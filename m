From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git_progname
Date: Tue, 25 Oct 2005 14:53:14 +0200
Message-ID: <435E2ABA.8030907@op5.se>
References: <435ABB99.5020908@op5.se> <7vll0l6pn7.fsf@assigned-by-dhcp.cox.net> <435B5AE0.1060400@op5.se> <7v1x2cyplw.fsf@assigned-by-dhcp.cox.net> <435DF6DA.6010205@op5.se> <20051025093150.GB30889@pasky.or.cz> <435E1307.3090209@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Oct 25 14:58:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUOJ5-0001OF-17
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 14:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbVJYMxQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 08:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbVJYMxQ
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 08:53:16 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:9703 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S1750988AbVJYMxP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2005 08:53:15 -0400
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id BCBD86BD00
	for <git@vger.kernel.org>; Tue, 25 Oct 2005 14:53:14 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <435E1307.3090209@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10584>

Andreas Ericsson wrote:
> Petr Baudis wrote:
> 
>>> grep -l "int main" *.c | xargs -- sed -i '/^#include/i#include "main.h"'
>>
>>
>> Urgh. Now this is ugly. What about making it a bit more intrusive while
>> quite more saner?
>>
> 
> I'm not sure what you're referring to. The one-liner is a one-liner. 
> It's sort of supposed to be ugly.
> 

Oh. I saw what you meant now. Lots of main.h included. :)

Silly me. Sorry about that.

I guess some manual editing could be done.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
