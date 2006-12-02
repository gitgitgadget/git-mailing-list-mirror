X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: git-svn: File added multiple times?
Date: Sat, 02 Dec 2006 23:41:32 +0100
Message-ID: <87psb1or8j.fsf@mid.deneb.enyo.de>
References: <87psb2ou6f.fsf@mid.deneb.enyo.de>
	<20061202223419.GA7057@localdomain> <87u00dord9.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 2 Dec 2006 22:41:57 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <87u00dord9.fsf@mid.deneb.enyo.de> (Florian Weimer's message of
	"Sat, 02 Dec 2006 23:38:42 +0100")
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33066>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqdYN-0000x5-Kp for gcvg-git@gmane.org; Sat, 02 Dec
 2006 23:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936577AbWLBWls (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 17:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936579AbWLBWls
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 17:41:48 -0500
Received: from mail.enyo.de ([212.9.189.167]:18441 "EHLO mail.enyo.de") by
 vger.kernel.org with ESMTP id S936577AbWLBWlr (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 17:41:47 -0500
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de) by
 mail.enyo.de with esmtp id 1GqdYI-0005tq-AH; Sat, 02 Dec 2006 23:41:46 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.63) (envelope-from
 <fw@deneb.enyo.de>) id 1GqdY5-0004Jh-12; Sat, 02 Dec 2006 23:41:33 +0100
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

* Florian Weimer:

> * Eric Wong:
>
>>> Is this expected?
>>> It's somewhat counter-intuitive, at least.  This is with Debian's
>>> git-core 1.4.4.1-1 package, and the SVN:: Perl modules are installed.
>>
>> No it's not expected.  Is this on a public SVN repo I can look at?
>> Thanks.
>
> This is the svn://mlton.org/mlton/trunk repository.  The second commit
> shows this behavior, but it's a bit large.

It also occurs with r2048, which is smaller:

[...]
        A       mlton/trunk/doc/examples/finalizable/cons.c
        A       mlton/trunk/doc/examples/finalizable/cons.c
[...]
