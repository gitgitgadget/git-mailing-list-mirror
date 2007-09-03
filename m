From: Andreas Ericsson <ae@op5.se>
Subject: Re: [ANNOUNCE] GIT 1.5.3
Date: Mon, 03 Sep 2007 15:02:48 +0200
Message-ID: <46DC05F8.7000709@op5.se>
References: <7vodglr32i.fsf@gitster.siamese.dyndns.org>	<46DA5F33.2020005@zytor.com> <85odgltrtj.fsf@lola.goethe.zz>	<46DA88EF.7080103@zytor.com>	<20070902133803.1b46f599.seanlkml@sympatico.ca>	<7v4picpvgq.fsf@gitster.siamese.dyndns.org> <46DBF0BB.3070605@op5.se> <868x7nj482.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Sep 03 15:02:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISBZv-000234-HF
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 15:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbXICNCv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 09:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752094AbXICNCu
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 09:02:50 -0400
Received: from mail.op5.se ([193.201.96.20]:49757 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751523AbXICNCu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 09:02:50 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 201B9194390;
	Mon,  3 Sep 2007 15:02:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HiTqke-9waq3; Mon,  3 Sep 2007 15:02:48 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id A512319400A;
	Mon,  3 Sep 2007 15:02:48 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <868x7nj482.fsf@lola.quinscape.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57482>

David Kastrup wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
>> Junio C Hamano wrote:
>>> Assuming that we do not give the old git-p4import script
>>> packaged in "git-p4 package", would the following patch be all
>>> that is needed, or do we need other things in the spec file?
>>>
>>> -- snipsnap clipcrap --
>>> +Obsoletes:	git-p4
>> That depends. If packages outside of git requires the git-p4 package
>> to function then this will not suffice and a line saying
>>
>> 	Provides: git-p4
>>
>> would have to be added instead.
> 
> Not instead, but in addition IIRC (it obsoletes the package and
> provides the feature).  But that would be nonsensical if the outside
> package indeed requires git-p4 and we don't have it in our current
> RPM: the purpose of dependencies is to not have things break silently,
> and lying about what we provide would be wrong.
> 

No, it really is instead. A package obsoleting one of the features it
provides itself would be insane.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
