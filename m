X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] "master" should be treated no differently from any other branch
Date: Fri, 15 Dec 2006 11:29:01 +0100
Organization: At home
Message-ID: <eltt8n$h4s$1@sea.gmane.org>
References: <200612141519.44294.andyparkins@gmail.com> <Pine.LNX.4.63.0612141627090.3635@wbgn013.biozentrum.uni-wuerzburg.de> <4581721B.4050102@xs4all.nl> <458174C9.2050401@xs4all.nl> <Pine.LNX.4.63.0612141710400.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 15 Dec 2006 10:27:02 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 38
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34491>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvAHF-0003rJ-2e for gcvg-git@gmane.org; Fri, 15 Dec
 2006 11:26:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751764AbWLOK0u (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 05:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbWLOK0u
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 05:26:50 -0500
Received: from main.gmane.org ([80.91.229.2]:56975 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751764AbWLOK0t
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006 05:26:49 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GvAH5-0006JU-9A for git@vger.kernel.org; Fri, 15 Dec 2006 11:26:43 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 11:26:43 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 15 Dec 2006
 11:26:43 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:

> On Thu, 14 Dec 2006, Han-Wen Nienhuys wrote:
> 
>> Wouldn't it be better to mention the id of the local repository too? 
>> 
>>   Merge branch 'master' of ssh+git://git.sv.gnu.org/srv/git/lilypond into 
>>   'master' of 'hanwen@xs4all.nl'
>> 
>> this would give more information when these commit messages get pushed 
>> to someone else.
> 
> And why not put your address and birthday in there, too?
> 
> Frankly, it does not matter. In my private git repository I see that I 
> often merged from this machine to that machine, criss-crossing often. It 
> does not buy me anything to even know _where_ I got it from.
> 
> Besides, the information you are most likely looking for is the committer, 
> which is recorded anyway.
> 
> The single most useful information in the Merge message is the name of the 
> branch I merged, since it is more often than not a topic branch, which is 
> aptly named.

By the way, I run git with merge.summary=true, and it is very nice and
usually shows the correct thing... but because git doesn't mark branching
points in any way sometimes under feature branch header there are changes
not related to given topic, but which were on given branch; the
fast-forward case I think.

That said, I'm all for not having "master" branch special-cased, besides
having it default name for branch in git-init-db.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

