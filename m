X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: Suggestion: drop 'g' in git-describe suffix
Date: Thu, 02 Nov 2006 01:47:12 +0000
Message-ID: <45494E20.1000503@shadowen.org>
References: <eibh94$t7n$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 2 Nov 2006 01:52:18 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
In-Reply-To: <eibh94$t7n$1@sea.gmane.org>
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30682>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfRgO-0005RH-5t for gcvg-git@gmane.org; Thu, 02 Nov
 2006 02:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752458AbWKBBrt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 20:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752463AbWKBBrt
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 20:47:49 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:29449 "EHLO
 hellhawk.shadowen.org") by vger.kernel.org with ESMTP id S1752458AbWKBBrt
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 20:47:49 -0500
Received: from localhost ([127.0.0.1]) by hellhawk.shadowen.org with esmtp
 (Exim 4.50) id 1GfRfj-0002xo-Bo; Thu, 02 Nov 2006 01:47:11 +0000
To: hanwen@xs4all.nl
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys wrote:
> 
> hi,
> 
> the convention to use a 'g' in the output of git-describe, eg.
> 
>   [lilydev@haring lilypond]$ git describe --abbrev=39
>   lilypond_2_9_7-g47778d2297276484c861fc7536da13feb2d5fe8
> 
> 
> is confusing: the g is also a hex digit, and without reading the manual
> carefully, you'd think this is the commit g4777.
> 
> Proposal: why not use
> 
>   tag#sha1
> 
> or some other non-hex character.

g is not a hex digit, hex is 0-f ??

In current versions of git, this whole string is also a valid name for
the commit ie you can do the following:

	git show lilypond_2_9_7-g47778d2297276484c861fc7536da13feb2d5fe8

-apw
