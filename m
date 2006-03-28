From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] xdiff: Show function names in hunk headers.
Date: Tue, 28 Mar 2006 13:07:00 +0200
Message-ID: <442918D4.6070105@op5.se>
References: <11435126113456-git-send-email-mdw@distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 28 13:07:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOC2f-0004hL-CN
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 13:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWC1LHE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 06:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWC1LHD
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 06:07:03 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:14016 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932184AbWC1LHB
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Mar 2006 06:07:01 -0500
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 41DD06BD0D; Tue, 28 Mar 2006 13:07:00 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Mark Wooding <mdw@distorted.org.uk>
In-Reply-To: <11435126113456-git-send-email-mdw@distorted.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18117>

Mark Wooding wrote:
> 
> The function names are parsed by a particularly stupid algorithm at the
> moment: it just tries to find a line in the `old' file, from before the
> start of the hunk, whose first character looks plausible.  Still, it's
> most definitely a start.
> 

Stupid is sometimes good. I've noticed that the gnu diff algorithm 
sometimes won't notice changes in small structs, though they are large 
enough for the surrounding context in the unified diff not to show it 
either.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
