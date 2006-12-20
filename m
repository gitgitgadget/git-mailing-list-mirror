X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] Implement poor-man's submodule support using commit  hooks
Date: Wed, 20 Dec 2006 15:07:56 +0100
Organization: At home
Message-ID: <embfus$d50$1@sea.gmane.org>
References: <200612201309.02119.andyparkins@gmail.com> <45893AC6.910D5748@eudaptics.com> <200612201347.13805.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 20 Dec 2006 14:05:52 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 20
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34930>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx24p-0006b8-HA for gcvg-git@gmane.org; Wed, 20 Dec
 2006 15:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965071AbWLTOFo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 09:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965074AbWLTOFo
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 09:05:44 -0500
Received: from main.gmane.org ([80.91.229.2]:56268 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S965071AbWLTOFn
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006 09:05:43 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gx24P-0001X9-T8 for git@vger.kernel.org; Wed, 20 Dec 2006 15:05:21 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 20 Dec 2006 15:05:21 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 20 Dec 2006
 15:05:21 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:

> On Wednesday 2006 December 20 13:29, Johannes Sixt wrote:

>>> +       while read subdir hash
>>
>> Wouldn't it be better to have the order of subdir and hash swapped? That
>> way subdir may contain blanks, and it gives nicer alignment in the file
>> because of the constant length of the hashes.
> 
> Unfortunately, it is the hash that is optional.  When you create the file, you 
> don't list the hashes, you list the subdirectories.  I suppose I could make 
> it so you have to give "000000" or something first?

That's the convention git uses in git-diff, reflog, etc.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

