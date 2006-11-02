X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: Suggestion: drop 'g' in git-describe suffix
Date: Thu, 02 Nov 2006 11:53:30 +0100
Message-ID: <4549CE2A.3010808@xs4all.nl>
References: <eibh94$t7n$1@sea.gmane.org> <45494E20.1000503@shadowen.org> <4549C083.9060805@xs4all.nl> <4549CA6B.4090909@shadowen.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 2 Nov 2006 10:55:14 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 38
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
In-Reply-To: <4549CA6B.4090909@shadowen.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30713>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfaDF-0000Kt-EI for gcvg-git@gmane.org; Thu, 02 Nov
 2006 11:54:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752536AbWKBKyR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 05:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752541AbWKBKyR
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 05:54:17 -0500
Received: from main.gmane.org ([80.91.229.2]:22970 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1752536AbWKBKyQ (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 05:54:16 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GfaCz-0000Fu-5T for git@vger.kernel.org; Thu, 02 Nov 2006 11:54:05 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Thu, 02 Nov 2006 11:54:05 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 02 Nov 2006 11:54:05
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andy Whitcroft escreveu:
> Han-Wen Nienhuys wrote:
>> Andy Whitcroft escreveu:
>>>> or some other non-hex character.
>>> g is not a hex digit, hex is 0-f ??
>>>
>> Yes of course; silly me. Still I think it would be clearer if it used a
>> non-alphabet char, eg.
>>
>>   tag+sha1
>>
>> to separate the tag and the committish.
> 
> Well there is a non-alphabet character in there, a minus (-).  The g
> prefix on the sha1 _fragment_ it to indicate that it is in fact a
> truncated sha1, not a complete one.  

is this policy documented somewhere?  None of the tools understand it.

[lilydev@haring git]$ git describe
v1.4.3.3-g1e1f76e
[lilydev@haring git]$ git show g1e1f76e
fatal: ambiguous argument 'g1e1f76e': unknown revision or path not in 
the working tree.
Use '--' to separate paths from revisions

My suggestion is to use

   v1.4.3.3+1e1f76e

here.

> If you want the complete clean sha1
> this is not the way to get it?


-- 
  Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
