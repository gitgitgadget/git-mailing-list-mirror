X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 13:31:32 +0100
Organization: At home
Message-ID: <ejf18p$tbt$1@sea.gmane.org>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org> <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home> <87bqn9u43s.wl%cworth@cworth.org> <7vr6w5y7to.fsf@assigned-by-dhcp.cox.net> <7virhhy76h.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142048350.2591@xanadu.home> <455B04DE.1040107@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 15 Nov 2006 12:31:25 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 29
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31439>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkJv0-0000kh-3q for gcvg-git@gmane.org; Wed, 15 Nov
 2006 13:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752367AbWKOMau (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 07:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966804AbWKOMat
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 07:30:49 -0500
Received: from main.gmane.org ([80.91.229.2]:19352 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1752367AbWKOMat (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 07:30:49 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GkJuO-0000bh-3H for git@vger.kernel.org; Wed, 15 Nov 2006 13:30:28 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 15 Nov 2006 13:30:28 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 15 Nov 2006
 13:30:28 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andreas Ericsson wrote:

> Nicolas Pitre wrote:
> 
> [ axed a lot of stuff that I didn't fully grok ]
> 
>> 
>> This becomes formalized as:
>> 
>>      git_pull [<URL>] [<local_name>]
>> 
>> If <URL> includes a branch name then <local_name> is a single branch 
>> name.  If <URL> doesn't include any branch name then <local_name> 
>> becomes a local branch group name containing all branches in the remote 
>> repository.
> 
> I would change that so "local_name" is always a branch group name, but 
> branch group names can be used as refs. That is,
> 
> git pull startrek.com/kirk.git:master kirk

I'd rather use Cogito (not gitweb) notation startrek.com/kirk.git#master
This way we can change the name of local branch
   startrek.com/kirk.git#master:kirk
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

