From: Andreas Ericsson <ae@op5.se>
Subject: Re: [TRYTHIS] cvsimport: fix initial import
Date: Tue, 27 Jun 2006 12:41:14 +0200
Message-ID: <44A10B4A.3080903@op5.se>
References: <44A102F0.9090604@op5.se> <Pine.LNX.4.63.0606271234350.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 27 12:41:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvB0R-0000Bx-Vz
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 12:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWF0KlR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 06:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWF0KlQ
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 06:41:16 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:41650 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751270AbWF0KlQ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jun 2006 06:41:16 -0400
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id D827C6BCBC; Tue, 27 Jun 2006 12:41:14 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606271234350.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22724>

Johannes Schindelin wrote:
> ---
> Hi,
> 
> On Tue, 27 Jun 2006, Andreas Ericsson wrote:
> 
> 
>>Sadly, the cvsimport command no longer works to create new repositories from
>>scratch. I'm not nearly perl literate enough to fix it, but the problem seems
>>to be firstly 061303f0b50a648db8e0af23791fc56181f6bf93.
> 
> 
> My bad. Could you try this patch on top of 'next'?
> 

Works wonderfully. Weird that it didn't when I removed the read-tree 
completely. There was probably some pilot error involved on my part 
there and then.

Thanks, and ack.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
