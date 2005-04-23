From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Humble request of 'git' developers
Date: Sat, 23 Apr 2005 16:09:09 -0400
Message-ID: <426AAB65.2060401@pobox.com>
References: <426AA8E2.60403@pobox.com> <20050423200246.GA5448@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 22:05:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPQs0-0003Ql-6f
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 22:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVDWUJT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 16:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbVDWUJT
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 16:09:19 -0400
Received: from 216-237-124-58.infortech.net ([216.237.124.58]:40886 "EHLO
	mail.dvmed.net") by vger.kernel.org with ESMTP id S261760AbVDWUJO
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 16:09:14 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.50 #1 (Red Hat Linux))
	id 1DPQwC-0002bi-9Q; Sat, 23 Apr 2005 20:09:13 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
To: Chris Wedgwood <cw@f00f.org>
In-Reply-To: <20050423200246.GA5448@taniwha.stupidest.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Chris Wedgwood wrote:
> On Sat, Apr 23, 2005 at 03:58:26PM -0400, Jeff Garzik wrote:
> 
> 
>>Please stop filling up my /usr/local/bin :)
> 
> 
> why?
> 
> 
>>Just have one 'git' script, which looks in /usr/local/libexec/git
>>for further scripts and backends programs like write-tree and
>>diff-cache.
> 
> 
> how is that really any better?

Because

* flat namespaces grow cumbersome

* if everybody uses the 'git' command, which does all the internal 
execution, then it's just namespace pollution.

* using a multi-level namespace allows you to create commands like "rm" 
and "mv" by simply dropping that stuff into /usr/libexec/git, without 
having to worry about conflicting with rm(1) and mv(1).

	Jeff



