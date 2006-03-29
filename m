From: Andreas Ericsson <ae@op5.se>
Subject: Re: Is 'merge' in your path?
Date: Wed, 29 Mar 2006 10:47:55 +0200
Message-ID: <442A49BB.2060200@op5.se>
References: <200603290342.40970.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 29 10:48:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOWLX-0004lv-QU
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 10:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWC2Ir6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Mar 2006 03:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWC2Ir6
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Mar 2006 03:47:58 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:26829 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750730AbWC2Ir6
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Mar 2006 03:47:58 -0500
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id A5AC16BD01; Wed, 29 Mar 2006 10:47:56 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Len Brown <len.brown@intel.com>
In-Reply-To: <200603290342.40970.len.brown@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18161>

Len Brown wrote:
> trying to do a merge on my laptop using git as of today,
> but it bombs out.  anybody seen this?
> 
> lenb@toshiba:~/src> git --version
> git version 1.3-rc1.GIT
> 
> lenb@toshiba:~/src/linux-acpi-2.6> /lab/bin/git.update test
> Trying really trivial in-index merge...
> fatal: Merge requires file-level merging

....

> Failed to execute 'merge'. merge(1) is used as the file-level merge tool. Is 
> 'merge' in your path?
> No merge strategy handled the merge.
> lenb@toshiba:~/src/linux-acpi-2.6> which git-merge
> /home/lenb/bin/git-merge
> lenb@toshiba:~/src/linux-acpi-2.6> which git
> /home/lenb/bin/git
> lenb@toshiba:~/src/linux-acpi-2.6>


What does "which merge" tell you? If it turns up blank, you know the 
problem. The merge program is usually found in the rcs package.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
