From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git-format-patch: Number patches when there are more
 than one
Date: Sat, 03 Nov 2007 17:32:31 +0100
Message-ID: <472CA29F.3090701@op5.se>
References: <Pine.LNX.4.64.0710221044080.25221@racer.site> <1194104694-12530-1-git-send-email-mh@glandium.org> <472C9AFC.3000509@op5.se> <20071103160323.GA13284@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	spearce@spearce.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Nov 03 17:32:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoLvY-0007GY-Dh
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 17:32:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754680AbXKCQch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 12:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754613AbXKCQch
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 12:32:37 -0400
Received: from mail.op5.se ([193.201.96.20]:36678 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754611AbXKCQcg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 12:32:36 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 63BE41730695;
	Sat,  3 Nov 2007 17:31:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0p45DKsWmdSk; Sat,  3 Nov 2007 17:31:58 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.10])
	by mail.op5.se (Postfix) with ESMTP id 3290C1730690;
	Sat,  3 Nov 2007 17:31:58 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071103160323.GA13284@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63291>

Mike Hommey wrote:
> On Sat, Nov 03, 2007 at 04:59:56PM +0100, Andreas Ericsson wrote:
>> Mike Hommey wrote:
>>> Automagically enable numbering if we output more than one patch.
>>> Signed-off-by: Mike Hommey <mh@glandium.org>
>>> ---
>>> On Mon, Oct 22, 2007 at 10:44:12AM +0100, Johannes Schindelin wrote:
>>>> Hi,
>>>>
>>>> On Sun, 21 Oct 2007, Andreas Ericsson wrote:
>>>>
>>>>> [PATCH 1/1] looks a bit silly, and automagically handling this in 
>>>>> git-format-patch makes some scripting around it a lot more pleasant.
>>>> I think you should not use "-n" if you do not want to have the numbers.  
>>>> In circumstances as yours, where you can have patch series larger than 
>>>> one, I imagine that the "[PATCH 1/1]" bears an important information, 
>>>> which is not present in "[PATCH]": this patch series contains only one 
>>>> patch.
>>>>
>>>> IOW I do not like your patch: too much DWIDNS (Do What I Did NOT Say) for 
>>>> me.
>>> How about the contrary ?
>> Works for me. How does one turn it off?
> 
> Does it make sense to turn it off ?
> 

Sometimes, yes. I frequently gather several small fixes on a branch and then
send all of them at once. They rarely depend on each other, and apply order
is usually not important, so it doesn't make sense to order them.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
