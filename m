From: David Lang <dlang@digitalinsight.com>
Subject: Re: Following renames
Date: Sun, 26 Mar 2006 23:40:34 -0800 (PST)
Message-ID: <Pine.LNX.4.62.0603262337580.26865@qynat.qvtvafvgr.pbz>
References: <20060326014946.GB18185@pasky.or.cz>  <7virq1sywj.fsf@assigned-by-dhcp.cox.net>
 <e06fl8$p9f$1@sea.gmane.org>  <Pine.LNX.4.64.0603260843250.15714@g5.osdl.org>
  <e06hts$1ne$1@sea.gmane.org>  <Pine.LNX.4.64.0603260947100.15714@g5.osdl.org>
 <e0827k$7tk$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 27 09:41:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNmLt-0001MH-C8
	for gcvg-git@gmane.org; Mon, 27 Mar 2006 09:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWC0Hkk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Mar 2006 02:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWC0Hkj
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 02:40:39 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:55246 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1750775AbWC0Hkj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Mar 2006 02:40:39 -0500
Received: from no.name.available by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Sun, 26 Mar 2006 23:40:39 -0800
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Sun, 26 Mar 2006 23:40:34 -0800
X-X-Sender: dlang@dlang.diginsite.com
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e0827k$7tk$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18076>

On Mon, 27 Mar 2006, Jakub Narebski wrote:

> 2.) Caching the results of similarity algorithm/rename detection tool (also
> Paul Jakma post), including remembering false positives and undetected
> renames, for efficiency. Calculated automatically parts might be
> throw-away.

this sounds like it could easily devolve into a O(n!) situation where you 
are cacheing how everything is related (or not related) to everything 
else. Paul was makeing the point that the purpose was to cache the data to 
eliminate the time needed to calculate it, but if you don't store all the 
results then you don't know if the result is not relavent, or unknown, so 
you need to calculate it again.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
