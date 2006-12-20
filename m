X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] Implement poor-man's submodule support in pre-commit hook
Date: Wed, 20 Dec 2006 13:01:04 +0100
Organization: At home
Message-ID: <emb8h2$io4$1@sea.gmane.org>
References: <200612200901.30584.andyparkins@gmail.com> <200612201008.49045.andyparkins@gmail.com> <A76C0FA3-1649-409B-B0D4-C22865622C1F@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 20 Dec 2006 12:00:18 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 28
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34921>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx07L-000056-JC for gcvg-git@gmane.org; Wed, 20 Dec
 2006 13:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964968AbWLTMAL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 07:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754453AbWLTMAL
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 07:00:11 -0500
Received: from main.gmane.org ([80.91.229.2]:42302 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1754614AbWLTMAK
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006 07:00:10 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1Gx078-0007t4-OM for git@vger.kernel.org; Wed, 20 Dec 2006 13:00:02 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 20 Dec 2006 13:00:02 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 20 Dec 2006
 13:00:02 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Brian Gernhardt wrote:

> 
> On Dec 20, 2006, at 5:08 AM, Andy Parkins wrote:
> 
>> Hello,
>>
>> Help...
>>
>>> +if [ -f .gitmodules ]; then
>>
>> This doesn't work because git-commit is not necessarily in the root  
>> of the
>> working tree.  How do I safely get that root?  While ${GIT_DIR}/..  
>> would work
>> it is not guaranteed.
> 
> The way to do that seems to be "git rev-parse --git-dir".  I'm not  
> sure why it's not just "git --git-dir" or similar (probably just  
> historical reasons), but there you go.

Because it is "git --git-dir=<PATH>" to set it (probably).
Although it is not insurmountable difficulity...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

