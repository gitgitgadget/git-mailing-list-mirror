X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: git-svn: File added multiple times?
Date: Sat, 02 Dec 2006 23:38:42 +0100
Message-ID: <87u00dord9.fsf@mid.deneb.enyo.de>
References: <87psb2ou6f.fsf@mid.deneb.enyo.de>
	<20061202223419.GA7057@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 2 Dec 2006 22:39:09 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061202223419.GA7057@localdomain> (Eric Wong's message of "Sat,
	2 Dec 2006 14:34:19 -0800")
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33064>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqdVc-0000go-Mi for gcvg-git@gmane.org; Sat, 02 Dec
 2006 23:39:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936571AbWLBWi6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 17:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936572AbWLBWi6
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 17:38:58 -0500
Received: from mail.enyo.de ([212.9.189.167]:14091 "EHLO mail.enyo.de") by
 vger.kernel.org with ESMTP id S936571AbWLBWi5 (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 17:38:57 -0500
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de) by
 mail.enyo.de with esmtp id 1GqdVX-0003f6-Fc; Sat, 02 Dec 2006 23:38:55 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.63) (envelope-from
 <fw@deneb.enyo.de>) id 1GqdVK-0004C2-HP; Sat, 02 Dec 2006 23:38:42 +0100
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

* Eric Wong:

>> Is this expected?
>> It's somewhat counter-intuitive, at least.  This is with Debian's
>> git-core 1.4.4.1-1 package, and the SVN:: Perl modules are installed.
>
> No it's not expected.  Is this on a public SVN repo I can look at?
> Thanks.

This is the svn://mlton.org/mlton/trunk repository.  The second commit
shows this behavior, but it's a bit large.

> This is (or only seems to be) a UI reporting error and the actual data
> imported should be correct.

I think it might download the data multiple times as well (at least
the timing suggests that).  The generated repository seems to be fine,
though.  The import is still running, so I haven't done any
