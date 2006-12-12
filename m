X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Bahadir Balban" <bahadir.balban@gmail.com>
Subject: stgit: stg mail
Date: Tue, 12 Dec 2006 12:12:36 +0000
Message-ID: <7ac1e90c0612120412i1297ce05uecbeea1107b8c704@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 12:12:50 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ikq4mbJ1fMba24Q9z9LQ4kdVFECpW2lqLt8RWgilmht3ukVIb8wMsDzXC1qQT9wNafArB49f1rS6NBtADJ9wJMHwI+bvxINNsbWggAI0XcG9gQATN4MiZf2cnbhuR7zwGddyrCW2NlElUnhr83SLGT6gx3F5maRuIwWKrUOYHik=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34086>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu6V0-0006Nq-0V for gcvg-git@gmane.org; Tue, 12 Dec
 2006 13:12:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751214AbWLLMMj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 07:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWLLMMi
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 07:12:38 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:49723 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751214AbWLLMMi (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec
 2006 07:12:38 -0500
Received: by nf-out-0910.google.com with SMTP id o25so220711nfa for
 <git@vger.kernel.org>; Tue, 12 Dec 2006 04:12:37 -0800 (PST)
Received: by 10.82.138.6 with SMTP id l6mr645797bud.1165925556430; Tue, 12
 Dec 2006 04:12:36 -0800 (PST)
Received: by 10.82.186.15 with HTTP; Tue, 12 Dec 2006 04:12:36 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

I couldn't succeed in getting stg mail produce an mbox file with a
Signed-off-by line (using stgit 0.11).

stg mail -m --to=user@mail.com patchname > patchname.diff

works OK. If I add the template with Signed-off-by I get:

stg mail -m --to=user@mail.com -t ~/patch.tmpl patchname > patchname.diff
stg mail: No "From" address

Also tried -c with same result.

Config file:
[stgit]
# Default author/committer details
authname: name surname
authemail: user@mail.com
commname:  user@mail.com
commemail: user@mail.com

I guess it expects to find everything in the template? How do you
normally supply signoff field?

Thanks,
