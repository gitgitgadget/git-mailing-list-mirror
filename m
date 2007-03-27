From: David Lang <david.lang@digitalinsight.com>
Subject: Re: .gitlink for Summer of Code
Date: Tue, 27 Mar 2007 15:20:54 -0800 (PST)
Message-ID: <Pine.LNX.4.63.0703271514140.15345@qynat.qvtvafvgr.pbz>
References: <1174825838.12540.5.camel@localhost> 
 <Pine.LNX.4.64.0703271409070.6730@woody.linux-foundation.org> 
 <Pine.LNX.4.63.0703271245580.15345@qynat.qvtvafvgr.pbz> <euc9av$2p9$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 01:47:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWLOA-0000RH-F8
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 01:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbXC0Xrk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 19:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbXC0Xrj
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 19:47:39 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:54124 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751878AbXC0Xrj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 19:47:39 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Tue, 27 Mar 2007 15:47:38 -0800
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Tue, 27 Mar 2007 16:47:20 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <euc9av$2p9$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43324>

On Wed, 28 Mar 2007, Jakub Narebski wrote:

>> if I'm working on the 'ubuntu superproject' it would be nice to be able to find
>> what is different between the 'Jan 2007' and 'April 2007' versions. one could
>> have the 2.6.19 kernel and the other would have 2.6.20. I don't care about all
>> the individual changes between these two states of the kernel, but I need to be
>> able to compile either one as part of my testing. If I bisect the in the
>> superproject to the commit that updated the kernel, then I would consider
>> getting the 'kernel subproject' history to be able to bisect the bug further (or
>> I may just report it to the kernel maintainers for them to check.
>
> I'd rather call this idea _sparse_ clone (not shallow), as you have only
> some points in the history, but they don't need to be top 'n' ones.

Ok I can see the difference in the definition of the two, the ideal would 
probably be to have sparse and shallow clones be different instances of the same 
mechanism.

  sparse being specific points in the history, shallow being a range.

  allow for multiple ranges, and the ability to 'fill in the blanks' later so 
that points can become ranges and ranges can merge.

also having the server say 'it would only be XMB more to pull everything you 
don't have, do you want to do this?' would cause more load on the server for 
each of the partial pulls, but would encourage people to fill out partial 
repositories instead of hitting the servers repeatedly.

David Lang
