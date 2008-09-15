From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git User's Survey 2008 partial summary, part 5 - other SCM
Date: Mon, 15 Sep 2008 09:00:11 +0200
Message-ID: <48CE07FB.6010207@op5.se>
References: <200809031607.19722.jnareb@gmail.com>  <200809112214.18366.jnareb@gmail.com> <fcaeb9bf0809140345n11d41430ma9b4096c66776b0c@mail.gmail.com> <alpine.DEB.1.10.0809142038190.19489@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Sep 15 09:01:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kf85P-0005pQ-FM
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 09:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbYIOHAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 03:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbYIOHAQ
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 03:00:16 -0400
Received: from mail.op5.se ([193.201.96.20]:46505 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751253AbYIOHAP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 03:00:15 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id B1A671B800F2;
	Mon, 15 Sep 2008 08:49:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vMTMtEdYMQRM; Mon, 15 Sep 2008 08:49:48 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.171])
	by mail.op5.se (Postfix) with ESMTP id 832B61B80085;
	Mon, 15 Sep 2008 08:49:47 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <alpine.DEB.1.10.0809142038190.19489@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95883>

david@lang.hm wrote:
> On Sun, 14 Sep 2008, Nguyen Thai Ngoc Duy wrote:
> 
>> On 9/12/08, Jakub Narebski <jnareb@gmail.com> wrote:
>>>  15) Do you miss features in git that you know from other SCMs?
>>>     If yes, what features are these (and from which SCM)?
>>>     (Open ended text - Essay)
>>>
>>>  Total respondents       1046 (some/many of them wrote 'no')
>>>  skipped this question   1249
>>>
>>>  This is just a very quick summary, based on a first few pages of
>>>  responses, Full analysis is I think best left for after closing the
>>>  survey, because I think this would be a lot of work...
>>>
>>>  So here is preliminary list, or rather beginning of one:
>>>   * sparse/partial checkout and clone (e.g. Perforce)
>>
>> Have not read the survey result, but do you recall what is the most
>> used term for sparse/partial checkout? What SCMs do sparse/partial
>> checkout? I think it could be usable as it is now in my
>> will-be-sent-again series, but I don't really know how people want it
>> to from that.
> 
> the most common use-case is people who want to follow a project but (at 
> least think that they) don't need the history. so they want to save 
> time/bandwideth/disk space by not downloading things they don't need.
> 

I disagree, and this would be a thin or shallow checkout to me (although
I realize the nomenclature is unfortunately similar here). What I've
heard is normally documentation writers that don't want to be able to
even accidentally modify any code, so they just want Documentation/
subdirectory. Shallow clones are already supported (albeit with a lot
of limitations).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
