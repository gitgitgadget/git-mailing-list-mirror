From: David Lang <david.lang@digitalinsight.com>
Subject: Re: merge strategy request
Date: Sat, 24 Mar 2007 17:18:19 -0800 (PST)
Message-ID: <Pine.LNX.4.63.0703241716410.12986@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.63.0703241430420.12864@qynat.qvtvafvgr.pbz>
 <Pine.LNX.4.63.0703250315461.4045@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 25 03:44:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVHmE-0004pO-Jc
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 03:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753324AbXCYBoH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 21:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753341AbXCYBoH
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 21:44:07 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:59852 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1753324AbXCYBoG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 21:44:06 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Sat, 24 Mar 2007 17:44:04 -0800
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Sat, 24 Mar 2007 18:44:00 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <Pine.LNX.4.63.0703250315461.4045@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43029>

On Sun, 25 Mar 2007, Johannes Schindelin wrote:

> On Sat, 24 Mar 2007, David Lang wrote:
>
>> there's been talk about custom merge strategies for different types of
>> files (uncompressing office documents to merge them for example), so I
>> think this is along the same lines and wanted to let other people start
>> thinking about the problem and possible solutions.
>
> There is a nice example script, named git-merge-stupid, which you can
> use as template.
>
> Basically, just write a program named "git-merge-david-lang", which takes
> arguments of the form
>
> 	merge-base [merge-base2...] -- head remote [remote...]
>
> IOW, all arguments up to "--" are merge bases, and after the "--" comes
> the HEAD and all branches to be merged. All of these argument (except
> "--") are given as commit hashes.
>
> IIRC, if no merge bases are passed, the program is expected to find out
> (basically, take the output of "git-merge-base --all <head> <remote>...").
>
> And I really prefer _you_ working on it.

I'll add it to my backlog of projects that I'd like to do someday ;-)

unfortunantly it's not likely to be anytime soon (too many things on the list 
ahead of it)

David Lang
