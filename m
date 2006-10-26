X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (resend)] gitweb: Use --no-commit-id in git_commit and git_commitdiff
Date: Thu, 26 Oct 2006 11:37:11 +0200
Message-ID: <200610261137.12211.jnareb@gmail.com>
References: <200610261050.21214.jnareb@gmail.com> <7vejsvpi4d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 09:37:00 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bkES5XRK/e1kFUFnOTxUWJwSxi93n7x5qvhHFWHCZW344U5/rj9Vxo703qlKR2T7q1MhgtBT1osAq84Z294igQ3F3VFTjlFDlxgKVbyJbm1q9GmVkmhyi/IL4iJNM1oanqbZbiu+27b8Gdb2ET8XPstpueILbxNAGHL0WJlTUk8=
User-Agent: KMail/1.9.3
In-Reply-To: <7vejsvpi4d.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30169>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd1fO-00036D-FU for gcvg-git@gmane.org; Thu, 26 Oct
 2006 11:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422976AbWJZJgi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 05:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422961AbWJZJgi
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 05:36:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:18096 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1422976AbWJZJgh
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 05:36:37 -0400
Received: by ug-out-1314.google.com with SMTP id 32so316806ugm for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 02:36:36 -0700 (PDT)
Received: by 10.67.103.7 with SMTP id f7mr2429764ugm; Thu, 26 Oct 2006
 02:36:34 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110]) by
 mx.google.com with ESMTP id k2sm3032162ugf.2006.10.26.02.36.33; Thu, 26 Oct
 2006 02:36:34 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Use --no-commit-id option to git-diff-tree command in git_commit and
> > git_commitdiff to filter out commit ID output that git-diff-tree adds
> > when called with only one <tree-ish> (not only for --stdin). Remove
> > filtering commit IDs from git-diff-tree output.
> >
> > This option is in git since at least v1.0.0, so make use of it.
> 
> *BLUSH*
> 
> I think we would need something like this, if only for
> completeness.
> 
> -- >8 --
> [PATCH] combine-diff: honour --no-commit-id
> 
> Somehow we forgot to look at no_commit_id flag in these
> codepaths.

It's good that I haven't started coding support for combined commitdiff
in gitweb, as I would probably wonder why the code doesn't work ;-)
-- 
Jakub Narebski
