From: David Lang <david.lang@digitalinsight.com>
Subject: Re: merge strategy request
Date: Sat, 24 Mar 2007 22:25:17 -0800 (PST)
Message-ID: <Pine.LNX.4.63.0703242220510.13287@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.63.0703241430420.12864@qynat.qvtvafvgr.pbz><Pine.LNX
 .4.63.0703250315461.4045@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0703242130050.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Mar 25 08:54:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVMcC-0006zY-MB
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 08:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752779AbXCYGxu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 02:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752787AbXCYGxu
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 02:53:50 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:42522 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1752779AbXCYGxt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 02:53:49 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Sat, 24 Mar 2007 22:53:49 -0800
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Sat, 24 Mar 2007 23:53:33 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <Pine.LNX.4.64.0703242130050.6730@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43034>

On Sat, 24 Mar 2007, Linus Torvalds wrote:

> On Sun, 25 Mar 2007, Johannes Schindelin wrote:
>>
>> Basically, just write a program named "git-merge-david-lang", which takes
>> arguments of the form
>>
>> 	merge-base [merge-base2...] -- head remote [remote...]
>
> I think you are missing what David wants.
>
> David does *not* want a new global strategy. Adding those is fairly easy.
>
> David seem sto want a new per-file merge strategy, with the bog-standard
> recursive merge. We've talked about that possibility in the past, but we
> don't do it now. We always end up doing just the three-way merge.

right, I can see ways to further improve the merge for config files, but they 
wouldn't applty to most other types of files, so it would require support for 
per file merge options.

others have requested this in the past, this is just one more way that per-file 
merge options would be useful.

David Lang
