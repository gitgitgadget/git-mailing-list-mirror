X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: Suggestion: drop 'g' in git-describe suffix
Date: Thu, 02 Nov 2006 10:37:31 +0000
Message-ID: <4549CA6B.4090909@shadowen.org>
References: <eibh94$t7n$1@sea.gmane.org> <45494E20.1000503@shadowen.org> <4549C083.9060805@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 2 Nov 2006 10:38:19 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
In-Reply-To: <4549C083.9060805@xs4all.nl>
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30707>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfZxd-0004oD-3I for gcvg-git@gmane.org; Thu, 02 Nov
 2006 11:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161417AbWKBKiK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 05:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752814AbWKBKiJ
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 05:38:09 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:60170 "EHLO
 hellhawk.shadowen.org") by vger.kernel.org with ESMTP id S1752813AbWKBKiI
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 05:38:08 -0500
Received: from localhost ([127.0.0.1]) by hellhawk.shadowen.org with esmtp
 (Exim 4.50) id 1GfZwv-0003z6-TM; Thu, 02 Nov 2006 10:37:29 +0000
To: hanwen@xs4all.nl
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys wrote:
> Andy Whitcroft escreveu:
>>> or some other non-hex character.
>>
>> g is not a hex digit, hex is 0-f ??
>>
> 
> Yes of course; silly me. Still I think it would be clearer if it used a
> non-alphabet char, eg.
> 
>   tag+sha1
> 
> to separate the tag and the committish.

Well there is a non-alphabet character in there, a minus (-).  The g
prefix on the sha1 _fragment_ it to indicate that it is in fact a
truncated sha1, not a complete one.  If you want the complete clean sha1
this is not the way to get it?

