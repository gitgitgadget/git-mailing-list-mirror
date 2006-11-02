X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: Suggestion: drop 'g' in git-describe suffix
Date: Thu, 02 Nov 2006 10:55:15 +0100
Message-ID: <4549C083.9060805@xs4all.nl>
References: <eibh94$t7n$1@sea.gmane.org> <45494E20.1000503@shadowen.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 2 Nov 2006 09:55:59 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 15
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
In-Reply-To: <45494E20.1000503@shadowen.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30700>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfZIC-00051K-Hm for gcvg-git@gmane.org; Thu, 02 Nov
 2006 10:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752785AbWKBJzV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 04:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752780AbWKBJzV
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 04:55:21 -0500
Received: from main.gmane.org ([80.91.229.2]:3553 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1752786AbWKBJzS (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 04:55:18 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GfZHy-0004yF-I0 for git@vger.kernel.org; Thu, 02 Nov 2006 10:55:10 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Thu, 02 Nov 2006 10:55:10 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 02 Nov 2006 10:55:10
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andy Whitcroft escreveu:
>> or some other non-hex character.
> 
> g is not a hex digit, hex is 0-f ??
> 

Yes of course; silly me. Still I think it would be clearer if it used a 
non-alphabet char, eg.

   tag+sha1

to separate the tag and the committish.

-- 
  Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
