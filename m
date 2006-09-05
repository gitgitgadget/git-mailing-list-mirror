From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb testing and benchmarking (was: [PATCH 0/4] gitweb: Some improvements)
Date: Tue, 05 Sep 2006 10:59:04 +0200
Organization: At home
Message-ID: <edje8a$sdo$1@sea.gmane.org>
References: <200609041810.09838.jnareb@gmail.com> <7v8xkzkyie.fsf@assigned-by-dhcp.cox.net> <ediea9$d3d$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Sep 05 10:59:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKWmK-0005ED-HM
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 10:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965057AbWIEI7N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 04:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965061AbWIEI7N
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 04:59:13 -0400
Received: from main.gmane.org ([80.91.229.2]:55206 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965057AbWIEI7L (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Sep 2006 04:59:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GKWlq-00057t-Rq
	for git@vger.kernel.org; Tue, 05 Sep 2006 10:59:02 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Sep 2006 10:59:02 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Sep 2006 10:59:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26469>

Jakub Narebski wrote:

> Junio C Hamano wrote:
>
>> It is a while since I tried gitweb on my machine the last time
>> but was it always this slow I wonder...  We probably would need
>> a good benchmark and automated test before going too much
>> further.
> 
> The problem is that before commit 5d043a3d856bd40d8b34b8836a561e438d23573b
>   gitweb: fill in gitweb configuration by Makefile
> by Martin Waitz one had to modify gitweb script to change
> the configuration from default.
> 
> But benchmarking is good. Simple time to run script from command line,
> with environment variables GATEWAY_INTERFACE="CGI/1.1", HTTP_ACCEPT="*/*",
> REQUEST_METHOD="GET" and of course QUERY_STRING set, and perhaps using
> ApacheBench.

I think that for testing gitweb we will be better with creating some twisted
test repository (c.f. t/t4114-apply-typechange.sh), but for benchmarking it
would be better to use some larger repository, for example git repository
cut-off from above at some version (including tags!). Is there a way to do
that?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
