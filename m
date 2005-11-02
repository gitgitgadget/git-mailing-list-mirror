From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 4/4] git-daemon support for user-relative paths.
Date: Wed, 02 Nov 2005 09:21:43 +0100
Message-ID: <43687717.6080404@op5.se>
References: <20051101225921.3E7455BF74@nox.op5.se> <7vvezb6h4c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 09:22:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXDsV-0001Tb-1B
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 09:21:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932639AbVKBIVo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 03:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932644AbVKBIVo
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 03:21:44 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:5102 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S932639AbVKBIVo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 03:21:44 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 31ACB6BD00; Wed,  2 Nov 2005 09:21:43 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvezb6h4c.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11007>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
> 
>>+             [--timeout=n] [--init-timeout=n] [--strict-paths] [directory...]
> 
> 
> Why not just --strict?
> 

It's a bit clearer what it is that's strict, and allows for future 
--strict-* options to be added without breaking anyones init-scripts.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
