X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Troy Telford" <ttelford.groups@gmail.com>
Subject: Re: git-svn bug?
Date: Wed, 15 Nov 2006 15:55:21 -0700
Message-ID: <op.ti2xykijzidtg1@rygel.lnxi.com>
References: <op.ti2svo0ozidtg1@rygel.lnxi.com> <7vejs4jshp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 15 Nov 2006 22:56:43 +0000 (UTC)
Cc: git@vger.kernel.org, "Eric Wong" <normalperson@yhbt.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:subject:from:cc:content-type:mime-version:references:content-transfer-encoding:message-id:in-reply-to:user-agent;
        b=QyColwk5HEpZNa/znvy2rY+48Nt2p7w/kz6ziv0csTQEQKue96mq6kxb59E6WdECmERm4NANGm1RX7kxpF5GUCp6psHF23nM5OHXZ4lbJnfFhGY2GnLVIXreaQjavsQQyq4H3CJxcZwAJLK+Z1H+2n+JBSGCQa0zmnilzasZPoc=
In-Reply-To: <7vejs4jshp.fsf@assigned-by-dhcp.cox.net>
User-Agent: Opera Mail/9.10 (Linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31523>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkTg8-000317-Ay for gcvg-git@gmane.org; Wed, 15 Nov
 2006 23:56:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162031AbWKOWzi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 17:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162032AbWKOWzi
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 17:55:38 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:4659 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1162031AbWKOWzh
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 17:55:37 -0500
Received: by ug-out-1314.google.com with SMTP id m3so291162ugc for
 <git@vger.kernel.org>; Wed, 15 Nov 2006 14:55:35 -0800 (PST)
Received: by 10.78.201.15 with SMTP id y15mr19092huf.1163631335258; Wed, 15
 Nov 2006 14:55:35 -0800 (PST)
Received: from rygel.lnxi.com ( [63.145.151.2]) by mx.google.com with ESMTP
 id 11sm1392952hug.2006.11.15.14.55.33; Wed, 15 Nov 2006 14:55:35 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Wed, 15 Nov 2006 14:43:30 -0700, Junio C Hamano <junkio@cox.net> wrote:

> "Troy Telford" <ttelford.groups@gmail.com> writes:
>
>> (using git 1.4.4, svn 1.3.1 on a SLES 10 box)
>> fatal: Not a valid object name  
>> 92e2e0c50bbbacb0a3426b2c0f8b3e043eb4830a~1
>> 32768 at /usr/lib/perl5/5.8.8/Memoize.pm line 269
>> ...
>> I couldn't find an object named
>> "92e2e0c50bbbacb0a3426b2c0f8b3e043eb4830a~1" in .git/
>
> Troy, do you have object 92e2e0c5?  Is it a root commit (i.e. a
> commit that does not have a parent)?

I'll have to admit I'm stabbing in the dark on how to get the correct  
answer this, but here goes:

* `git cat-file -t 92e2e0...` returns 'commit'
* 'git cat-file -p 92e2e0...` returns: (minus the header/footer asterisks)
*********************************************
tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
author unknown <unknown> 961088898 +0000
committer unknown <unknown> 961088898 +0000

New repository initialized by cvs2svn.
*********************************************
-- 
