X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: svn versus git
Date: Thu, 14 Dec 2006 07:55:13 -0800
Message-ID: <m2slfilbfi.fsf@ziti.local>
References: <200612132200.41420.andyparkins@gmail.com>
	<20061213225627.GC32568@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 15:55:30 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=l7+WbfZSvX4BUwsFtm9Okwqy6GCzKi6kqMRGtwT6hFjIpYe4C1m2FMGVGKBy751qPtZEeixSzkTxZGJTI5mPhPqnLgd7chMzL97DDrtVTD5NEER8GJdZ3//D++82XN/ToXgB/NjBhid7kdECol1X66ZH3COztovTbuB6ybWJdTk=
In-Reply-To: <20061213225627.GC32568@spearce.org> (Shawn Pearce's message of "Wed, 13 Dec 2006 17:56:27 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34356>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GusvX-0001RU-Ij for gcvg-git@gmane.org; Thu, 14 Dec
 2006 16:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932835AbWLNPzP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 10:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932837AbWLNPzP
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 10:55:15 -0500
Received: from an-out-0708.google.com ([209.85.132.250]:46041 "EHLO
 an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932835AbWLNPzN (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 10:55:13 -0500
Received: by an-out-0708.google.com with SMTP id b33so171498ana for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 07:55:13 -0800 (PST)
Received: by 10.100.131.6 with SMTP id e6mr940921and.1166111712962; Thu, 14
 Dec 2006 07:55:12 -0800 (PST)
Received: from ziti.local ( [67.171.24.140]) by mx.google.com with ESMTP id
 b12sm2798669ana.2006.12.14.07.55.11; Thu, 14 Dec 2006 07:55:11 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> Andy Parkins <andyparkins@gmail.com> wrote:
>> svn cat::
>> Output the contents of specified files or URLs.  Optionally at a
>> specific revision.
>> git cat-file -p $(git-ls-tree $REV $file | cut -d " " -f 3 | cut -f 1)::
>
> better:
>
>   git cat-file -p $REV:$file

FWIW, after some amount of git experience, I had a need for git
cat-file and I found it hard to use.  Why?  Because following the
pattern of some other commands, I really expected the following to work:

   git cat-file -p HEAD^2 $file

Since that is similar to

   git diff HEAD^^ $file
   git checkout HEAD $file
   
Where else uses the colon syntax?

My $0.02.

