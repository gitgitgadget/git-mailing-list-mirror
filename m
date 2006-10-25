X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-fetch not working?
Date: Wed, 25 Oct 2006 13:37:09 +0200
Organization: At home
Message-ID: <ehni83$l7g$1@sea.gmane.org>
References: <200610242100.52671.andyparkins@gmail.com> <20061024205428.GI20017@pasky.or.cz> <453E8133.8020707@zytor.com> <20061025111150.GK20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 25 Oct 2006 11:37:36 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 45
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30052>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gch4O-00022U-MJ for gcvg-git@gmane.org; Wed, 25 Oct
 2006 13:37:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423299AbWJYLhJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 07:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423303AbWJYLhJ
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 07:37:09 -0400
Received: from main.gmane.org ([80.91.229.2]:38289 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1423299AbWJYLhH (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 07:37:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gch3y-0001xi-Va for git@vger.kernel.org; Wed, 25 Oct 2006 13:36:52 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 25 Oct 2006 13:36:50 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 25 Oct 2006
 13:36:50 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Petr Baudis wrote:

> Dear diary, on Tue, Oct 24, 2006 at 11:10:11PM CEST, I got a letter
> where "H. Peter Anvin" <hpa@zytor.com> said that...
>> Petr Baudis wrote:
>> >  nope, I'm getting it as well (hey I know about broken git.kernel.org
>> >in an hour at most now because of the repo.or.cz cronjobs ;) -
>> >git-daemon at the kernel.org machines seems to be broken.
>> >
>> 
>> Nope, just tripping the load limit.  git1.kernel.org has had loads over 
>> 400 today.  Oddly enough, the load on git2.kernel.org is in the low
>> teens. 

Shouldn't git.kernel.org distribute load?
 
> Hmm, interesting. Just to make sure, is that because of git-daemon or
> something else? :-)

Today (with git version 1.4.2.1):

998:jnareb@roke:~/git> git pull origin
fatal: read error (Connection reset by peer)
Fetch failure: git://git.kernel.org/pub/scm/git/git.git

1000:jnareb@roke:~/git> time git pull origin-http
Fetching refs/heads/master from http://git.kernel.org/pub/scm/git/git.git using http
Fetching refs/heads/pu from http://git.kernel.org/pub/scm/git/git.git using http
Fetching refs/heads/man from http://git.kernel.org/pub/scm/git/git.git using http
Fetching refs/heads/html from http://git.kernel.org/pub/scm/git/git.git using http
Fetching refs/heads/next from http://git.kernel.org/pub/scm/git/git.git using http
Fetching refs/heads/todo from http://git.kernel.org/pub/scm/git/git.git using http
Fetching refs/heads/maint from http://git.kernel.org/pub/scm/git/git.git using http
Already up-to-date.

real    8m0.369s
user    0m0.984s
sys     0m0.800s


-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

