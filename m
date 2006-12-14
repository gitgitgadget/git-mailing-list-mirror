X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: git-fetching from a big repository is slow
Date: Thu, 14 Dec 2006 16:45:59 +0100
Message-ID: <458171B7.1020702@xs4all.nl>
References: <200612141340.43925.andyparkins@gmail.com> <4581573E.40803@op5.se> <200612141518.05770.andyparkins@gmail.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 15:46:15 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 16
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <200612141518.05770.andyparkins@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34353>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gusmj-0008G9-Hf for gcvg-git@gmane.org; Thu, 14 Dec
 2006 16:46:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932815AbWLNPqH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 10:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932817AbWLNPqG
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 10:46:06 -0500
Received: from main.gmane.org ([80.91.229.2]:46583 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932815AbWLNPqF
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 10:46:05 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GusmY-0003rC-Nr for git@vger.kernel.org; Thu, 14 Dec 2006 16:46:02 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Thu, 14 Dec 2006 16:46:02 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 14 Dec 2006 16:46:02
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andy Parkins escreveu:
> On Thursday 2006 December 14 13:53, Andreas Ericsson wrote:
> 
>> This seems to happen if your repository consists of many large binary
>> files, especially many large binary files of several versions that do
>> not deltify well against each other. Perhaps it's worth adding gzip
> 
> It's actually just every released patch to the linux kernel ever issued.  
> Almost entirely ASCII and every revision (save the first) created by patching 
> the previous.

I just noticed that git-fetch now runs git-show-ref --verify on every
tag it encounters. This seems to slow down fetch over here.

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
