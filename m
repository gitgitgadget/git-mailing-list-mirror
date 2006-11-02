X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: Suggestion: drop 'g' in git-describe suffix
Date: Thu, 02 Nov 2006 11:12:39 +0000
Message-ID: <4549D2A7.7000209@shadowen.org>
References: <eibh94$t7n$1@sea.gmane.org> <45494E20.1000503@shadowen.org> <4549C083.9060805@xs4all.nl> <4549CA6B.4090909@shadowen.org> <4549CE2A.3010808@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 2 Nov 2006 11:13:34 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
In-Reply-To: <4549CE2A.3010808@xs4all.nl>
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30729>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfaVd-0004M3-2Y for gcvg-git@gmane.org; Thu, 02 Nov
 2006 12:13:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752850AbWKBLNS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 06:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752851AbWKBLNS
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 06:13:18 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:5643 "EHLO
 hellhawk.shadowen.org") by vger.kernel.org with ESMTP id S1752850AbWKBLNR
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 06:13:17 -0500
Received: from localhost ([127.0.0.1]) by hellhawk.shadowen.org with esmtp
 (Exim 4.50) id 1GfaUw-00044Y-OG; Thu, 02 Nov 2006 11:12:39 +0000
To: hanwen@xs4all.nl
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys wrote:
> Andy Whitcroft escreveu:
>> Han-Wen Nienhuys wrote:
>>> Andy Whitcroft escreveu:
>>>>> or some other non-hex character.
>>>> g is not a hex digit, hex is 0-f ??
>>>>
>>> Yes of course; silly me. Still I think it would be clearer if it used a
>>> non-alphabet char, eg.
>>>
>>>   tag+sha1
>>>
>>> to separate the tag and the committish.
>>
>> Well there is a non-alphabet character in there, a minus (-).  The g
>> prefix on the sha1 _fragment_ it to indicate that it is in fact a
>> truncated sha1, not a complete one.  
> 
> is this policy documented somewhere?  None of the tools understand it.
> 
> [lilydev@haring git]$ git describe
> v1.4.3.3-g1e1f76e
> [lilydev@haring git]$ git show g1e1f76e
> fatal: ambiguous argument 'g1e1f76e': unknown revision or path not in
> the working tree.
> Use '--' to separate paths from revisions
> 
> My suggestion is to use
> 
>   v1.4.3.3+1e1f76e
> 
> here.

The 'whole' thing is valid as an object reference:

apw@pinky$ git describe
v1.4.3.3-g8cf249b
apw@pinky$ git show v1.4.3.3-g8cf249b
commit 8cf249b755c257ea19100b888ac612e601cdf96b
Merge: 15c3ffb... fa438a2...
[...]

