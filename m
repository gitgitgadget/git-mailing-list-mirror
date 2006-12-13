X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: svn versus git
Date: Thu, 14 Dec 2006 00:14:37 +0100
Organization: At home
Message-ID: <elq1c8$37d$1@sea.gmane.org>
References: <200612132200.41420.andyparkins@gmail.com> <elpun9$qp1$1@sea.gmane.org> <200612132251.17202.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 13 Dec 2006 23:13:19 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34249>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GudHd-0007W7-Rh for gcvg-git@gmane.org; Thu, 14 Dec
 2006 00:13:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751717AbWLMXMr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 18:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751722AbWLMXMr
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 18:12:47 -0500
Received: from main.gmane.org ([80.91.229.2]:52388 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751709AbWLMXMb
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006 18:12:31 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GudGp-0003vY-1d for git@vger.kernel.org; Thu, 14 Dec 2006 00:12:15 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 00:12:15 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 14 Dec 2006
 00:12:15 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:

>> Hmmm... I thought that some progress indicator of download/upload was
>> added... guess I was wrong.
> 
> You're not wrong, there is a progress indicator, but it's measured 
> in "objects" not megabytes.  It's got a percentage as well.  Neither of these 
> things is a whole lot of use if I want to know how much data (in megabytes) 
> has been transferred, how much is there left to go and how long is it going 
> to take.

No, what you see is if I understand correctly progress indicator for
local and remote generating pack to send / exploding pack into loose
objects (or not). There was some patch to add download/upload progress
indicator, but I guess it was not applied.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

