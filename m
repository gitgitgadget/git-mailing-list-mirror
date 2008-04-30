From: Andreas Ericsson <ae@op5.se>
Subject: Re: help with git usage
Date: Wed, 30 Apr 2008 15:09:43 +0200
Message-ID: <48186F97.6080509@op5.se>
References: <200804291738.m3THc2hC030601@rs40.luxsci.com>	 <alpine.LNX.1.00.0804291354070.19665@iabervon.org> <1c5969370804300502obbc5a63v4c2c1a1175084237@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Daniel Quinlan <danq@brtt.com>, git@vger.kernel.org
To: Matt Graham <mdg149@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 15:13:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrC5F-0004Hv-VD
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 15:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756973AbYD3NJs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 09:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758017AbYD3NJr
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 09:09:47 -0400
Received: from mail.op5.se ([193.201.96.20]:60274 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756973AbYD3NJq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 09:09:46 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id E7AC81F08046;
	Wed, 30 Apr 2008 15:09:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id emHyf6j+-ekC; Wed, 30 Apr 2008 15:09:56 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.27])
	by mail.op5.se (Postfix) with ESMTP id 017101F0803B;
	Wed, 30 Apr 2008 15:09:55 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
In-Reply-To: <1c5969370804300502obbc5a63v4c2c1a1175084237@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80837>

Matt Graham wrote:
> On Tue, Apr 29, 2008 at 2:07 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:
>> On Tue, 29 Apr 2008, Daniel Quinlan wrote:
>>
>>  > I've been trying to use git for awhile now, (and I've read a lot of
>>  > documentation, though maybe my
>>  > comprehension has not been high enough) but there are several operations which
>>  > I
>>  > can't figure out:
>>  >
>>  > 1) After cloning a repository from work at home, making some changes and
>>  > committing them,
>>  > I use "git push" to push them back to the work repository.  The changes seem
>>  > to make it to the
>>  > work repository (I see the commit message in git log), but I can't figure out
>>  > how to get the
>>  > changes into the working set at work.  (evidently not merge, checkout or reset
>>  > -- seems like it
>>  > should be merge, but)
>>
>>  You shouldn't push to a non-bare repository.
> 
> Is there any reason it wouldn't be appropriate to make git refuse to
> push to non-bare repositories?


It has several very valid uses. Newcomers who don't know what happens are
often better off not doing it, which is why it's not recommended. Making
git refuse would prevent the valid uses altogether though.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
