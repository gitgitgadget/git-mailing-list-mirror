X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Explicitly add the default "git pull" behaviour to .git/config on clone
Date: Wed, 6 Dec 2006 12:55:41 +0000
Message-ID: <200612061255.42379.andyparkins@gmail.com>
References: <200612061207.23437.andyparkins@gmail.com> <el6crv$p7e$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 12:55:54 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Uxe5ookaz7jUsk8txBwTeyiJpsE/4RMpzmMQwIvJHn+xJPzeQNgkGsxbcjjYLO6IMrJiX/6sgc8HiO26YsGUanQlFzjpeR30Ls9ip/1uV1Q+sLsBBCbrx7lbUBsCvW3h5ZcPFT3j/nRswRxq95Q+rRRfxVtNRywjdncElUKRE7c=
User-Agent: KMail/1.9.5
In-Reply-To: <el6crv$p7e$1@sea.gmane.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33451>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrwJS-000557-9h for gcvg-git@gmane.org; Wed, 06 Dec
 2006 13:55:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760577AbWLFMzr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 07:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760578AbWLFMzr
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 07:55:47 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:59326 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1760577AbWLFMzq (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec
 2006 07:55:46 -0500
Received: by ug-out-1314.google.com with SMTP id 44so131213uga for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 04:55:45 -0800 (PST)
Received: by 10.67.117.2 with SMTP id u2mr728352ugm.1165409745407; Wed, 06
 Dec 2006 04:55:45 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 13sm30232329ugb.2006.12.06.04.55.44; Wed, 06 Dec 2006 04:55:45 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 2006 December 06 12:27, Jakub Narebski wrote:

> This doesn't help newbies if they do "git pull" on branch other than
> "master". Git would fetch (a) from default remote "origin" (which can
> be unexpected a bit) (b) into current branch (which can be very
> unexpected for newbie) (c) the first branch in remote (which can be
> very unexpected).

That's why I was suggesting to remove the default behaviour when there is no 
branch defined.  In that case git-pull would just exit with an appropriate 
message.

> Perhaps protected by config option and/or pull option... or perhaps not.
> Refuse pulling into current branch if it doesn.t have branch.<name>.remote
> matching current remote and doesn't have branch.<name>.merge entry, unless
> of course refspec is provided.

That's exactly what I meant; although your description is better.

Andy


-- 
Dr Andy Parkins, M Eng (hons), MIEE
