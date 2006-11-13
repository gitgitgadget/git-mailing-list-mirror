X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alexander Litvinov" <litvinov2004@gmail.com>
Subject: Re: Getting new branches from remote repo.
Date: Mon, 13 Nov 2006 11:29:25 +0600
Message-ID: <6e1787fe0611122129l211f7bcaued9f4981225a241b@mail.gmail.com>
References: <6e1787fe0611122033p49671e13xf5b7f95beeba8b06@mail.gmail.com>
	 <7v8xigar36.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 13 Nov 2006 05:30:16 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WPhiABJR+N/5g9B7sXmD2YfolJrBFo+xmEkMCodOXoQ/KqkXE9P42tbDbQveZJyG9RWxsYs8gyStKzIRrayZSBmhyJ3Zb8hCJJMkVn2bbkypQmUvwJhqvNDNZXWjHlet4J+EQmAdGN3PoTk9M91n+9MFsFOg91CVfJ51kTEsbRQ=
In-Reply-To: <7v8xigar36.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31292>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjUO4-00042y-RP for gcvg-git@gmane.org; Mon, 13 Nov
 2006 06:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753945AbWKMF3h (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006
 00:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753952AbWKMF3g
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 00:29:36 -0500
Received: from nz-out-0102.google.com ([64.233.162.193]:14764 "EHLO
 nz-out-0102.google.com") by vger.kernel.org with ESMTP id S1753945AbWKMF3g
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 00:29:36 -0500
Received: by nz-out-0102.google.com with SMTP id l1so677359nzf for
 <git@vger.kernel.org>; Sun, 12 Nov 2006 21:29:29 -0800 (PST)
Received: by 10.35.109.2 with SMTP id l2mr10239026pym.1163395765480; Sun, 12
 Nov 2006 21:29:25 -0800 (PST)
Received: by 10.35.108.4 with HTTP; Sun, 12 Nov 2006 21:29:25 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

> After finding out $that_new_branch's name, add either
>
>         Pull: refs/heads/$that_new_branch:refs/heads/$that_new_branch

> You would still see them if you say "ls-remote" without --heads.

Thanks for help, these commands solve my trouble:
1. Get remote branches by 'git ls-remote origin refs/remotes/*'
2. Fetch needed branch by adding: 'Pull:
refs/remotes/origin/BRANCH:refs/heads/BRANCH' into .git/remotes/origin

Is there any way to automaticly edit .git/remotes/origin before
