X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] [checkout-index] Give names to stages
Date: Mon, 04 Dec 2006 12:36:24 +0100
Organization: At home
Message-ID: <el113s$25v$1@sea.gmane.org>
References: <505428.75434.qm@web31808.mail.mud.yahoo.com> <Pine.LNX.4.63.0612041149410.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Mon, 4 Dec 2006 11:34:44 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 31
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33190>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrC5l-0006P0-Cc for gcvg-git@gmane.org; Mon, 04 Dec
 2006 12:34:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936085AbWLDLef (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 06:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936086AbWLDLef
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 06:34:35 -0500
Received: from main.gmane.org ([80.91.229.2]:65003 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S936085AbWLDLee (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 06:34:34 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GrC5a-0007fV-9C for git@vger.kernel.org; Mon, 04 Dec 2006 12:34:26 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 04 Dec 2006 12:34:26 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 04 Dec 2006
 12:34:26 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:

> On Sun, 3 Dec 2006, Luben Tuikov wrote:
> 
>> This patch merely allows the user to say
>>    git-checkout-index --stage=ours their_broken_file.c
>> instead of
>>    git-checkout-index --stage=2 their_broken_file.c
>> and similarly for "theirs", etc.
> 
> Dunno. When this problem hits me, I usually do
> 
>       git diff --theirs their_broken_file.c
> 
> anyway, to see what it is doing (colour and all). When I am satisfied, 
> that "theirs" is really what I want, I just go back one in history, and 
> append a call to git-apply like this:
> 
>       git diff --theirs their_broken_file.c | git apply --index

Then

        git checkout --theirs their_broken_file.c

is obvious simplification.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

