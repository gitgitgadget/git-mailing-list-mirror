X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Add "next" link to commitdiff view
Date: Sun, 29 Oct 2006 04:10:29 +0200
Message-ID: <200610290310.30265.jnareb@gmail.com>
References: <672246.46875.qm@web31808.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 29 Oct 2006 02:10:42 +0000 (UTC)
Cc: Luben Tuikov <ltuikov@yahoo.com>, Junio Hamano <junkio@cox.net>,
	Petr Baudis <pasky@suse.cz>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=i9XgwCpekElaOlvTHaoOjbOmr9a3+CwhjZgdSltKnS7TA3gIFytXOhkauYopMzHduGuNonMUOCMZ8giH/U5dDYZSi8ALd5BWXvbKloZwMcD8kV/3dATmsQjp90ii7NxrdRNze6epGw2IQTGKHi1WGLtzXziQg+Imvc1sJvjShu8=
User-Agent: KMail/1.9.3
In-Reply-To: <672246.46875.qm@web31808.mail.mud.yahoo.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30407>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ge08E-0001TW-Af for gcvg-git@gmane.org; Sun, 29 Oct
 2006 03:10:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964900AbWJ2CKf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 22:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbWJ2CKf
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 22:10:35 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:48960 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S964900AbWJ2CKe
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 22:10:34 -0400
Received: by ug-out-1314.google.com with SMTP id 32so933912ugm for
 <git@vger.kernel.org>; Sat, 28 Oct 2006 19:10:33 -0700 (PDT)
Received: by 10.66.252.4 with SMTP id z4mr1939949ugh; Sat, 28 Oct 2006
 19:10:33 -0700 (PDT)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id c1sm1232407ugf.2006.10.28.19.10.32; Sat, 28 Oct
 2006 19:10:32 -0700 (PDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Luben Tuikov wrote:
> --- Jakub Narebski <jnareb@gmail.com> wrote:
>>
>> It is commit-7, but that can be easily changed.
> 
> Please do change it to "commit-8" -- it'd be consistent with the rest
> of GIT.

Well, some parts of GIT use "commit-8" (for example git-describe),
other use "commit-7...": this includes git-diff both in --raw
(git diff --raw, as opposed to git-diff-tree), git-diff in it's patch 
format in "index <hash>..<hash>" extended header, in "Merge:" line for 
merges in git-show output.

-- 
Jakub Narebski
