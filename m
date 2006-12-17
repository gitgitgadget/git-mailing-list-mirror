X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-diff: don't add trailing blanks (i.e., do what GNU diff -u now does)
Date: Sun, 17 Dec 2006 21:54:41 +0100
Organization: At home
Message-ID: <em4all$b2c$1@sea.gmane.org>
References: <87y7p6nwsh.fsf@rho.meyering.net> <Pine.LNX.4.64.0612171200290.3479@woody.osdl.org> <7vtzzu5lp1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sun, 17 Dec 2006 20:52:21 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 23
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34708>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gw2zb-0004g3-Cs for gcvg-git@gmane.org; Sun, 17 Dec
 2006 21:52:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751822AbWLQUwQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 15:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbWLQUwQ
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 15:52:16 -0500
Received: from main.gmane.org ([80.91.229.2]:44187 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751822AbWLQUwQ
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec 2006 15:52:16 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gw2zV-0004Hs-7S for git@vger.kernel.org; Sun, 17 Dec 2006 21:52:13 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 17 Dec 2006 21:52:13 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 17 Dec 2006
 21:52:13 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
>> On Sun, 17 Dec 2006, Jim Meyering wrote:
>>>
>>> You may recall that GNU diff -u changed recently so that it no
>>> longer outputs any trailing space unless the input data has it.
>>
>> I still consider that to be a bug in GNU "diff -u".
>>
>> We work around that bug when applying patches, but I don't think we should 
>> replicate it.
> 
> Me neither.

Perhaps with --gnu-diff-compatibility then? 

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

