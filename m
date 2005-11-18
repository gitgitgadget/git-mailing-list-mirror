From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 1/5] Library code for user-relative paths, take three.
Date: Fri, 18 Nov 2005 23:49:52 +0100
Message-ID: <437E5A90.3070405@op5.se>
References: <20051117193714.2B8995BF93@nox.op5.se> <7v8xvmsu9o.fsf@assigned-by-dhcp.cox.net> <437DA828.6020207@op5.se> <437E3A9B.1070801@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 01:16:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdF3N-0002M0-IQ
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 23:49:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbVKRWty (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 17:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbVKRWty
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 17:49:54 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:737 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S932128AbVKRWtx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 17:49:53 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 928186BCFE; Fri, 18 Nov 2005 23:49:52 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <437E3A9B.1070801@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12300>

H. Peter Anvin wrote:
> The whole point with --strict is that it shouldn't DWIM.  DWIMming is 
> *NOT* safe if the data has previously passed through a security screen.
> 

But it hasn't at this point. The security scan is done afterwards, when 
the canonical path is compared against the whitelist which, in strict 
mode, only matches if it matches exactly.

But anyways, how about doing

	enter_repo(path, 2)

from the daemon to make enter_repo() do the chdir(".git")?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
