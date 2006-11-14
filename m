X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Rework cvsexportcommit to handle binary files for all cases.
Date: Tue, 14 Nov 2006 07:49:04 +0100
Message-ID: <200611140749.05023.robin.rosenberg@dewire.com>
References: <200611121629.43104.robin.rosenberg@dewire.com> <200611132139.25342.robin.rosenberg@dewire.com> <7vveli4zxc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 14 Nov 2006 06:47:46 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
In-Reply-To: <7vveli4zxc.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31334>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gjs56-0003uJ-7D for gcvg-git@gmane.org; Tue, 14 Nov
 2006 07:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755431AbWKNGr1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 01:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755443AbWKNGr1
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 01:47:27 -0500
Received: from [83.140.172.130] ([83.140.172.130]:48223 "EHLO
 torino.dewire.com") by vger.kernel.org with ESMTP id S1755431AbWKNGr0 (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 01:47:26 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id E4D9A80280D; Tue, 14 Nov 2006 07:43:55 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 28347-01; Tue, 14 Nov
 2006 07:43:55 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2]) by torino.dewire.com (Postfix)
 with ESMTP id 7246F8003E1; Tue, 14 Nov 2006 07:43:53 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

tisdag 14 november 2006 01:47 skrev Junio C Hamano:
>Robin Rosenberg wrote:
>> I sent a patch earlier, which was not applied, due to imperfections that I 
>> cannot solve fully. One issue was that patch 2.5.9 was required and hacking 
>> it to handle binary diffs with spaces would require and even worse kludge,
>
>I suspect that we should not be using patch, but instead be
>using git-apply perhaps with -C option if people want fuzz.

Does git-apply work without a git repo? We're applying patches onto a CVS 
repo.

>[...]
> I know this script originally came from southern hemisphere, but
> I was talking about _western_ hemisphere.  The comment refers to
> the part of the code the attached patch fixes, which I will
> apply along with your updated patch.
Western/nothern, both apply to where I live.

>[...]
>I think scripts that work with git
> plumbing should read from -z output when they need to and are
> capable of, as we have done for git-cvsserver recently, and
> things written in Perl certainly are capable of doing so.
I'll investgate that.

