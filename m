X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Rename detection at git log
Date: Mon, 20 Nov 2006 11:06:56 +0100
Message-ID: <81b0412b0611200206q4ded162drdc450715d7f801e0@mail.gmail.com>
References: <200611201157.23680.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 20 Nov 2006 10:07:13 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZKP36dFZpYkLS+EuXVsS7AFDY0m4s+r0hNBFGhTpb3HNVDxjWvZeZHuq1b2YGgtXC7rX/HrJFi0lhKUhqSugPZh8akSm2T2YeIc9wR1xYezcXm2LE5DDYHgRJ5H2dHNjdQSXXBwYaC3bds5aU2BiRNQqJ6Me3/Nqmv1eNREtcaU=
In-Reply-To: <200611201157.23680.litvinov2004@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31892>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gm63K-0004X5-EF for gcvg-git@gmane.org; Mon, 20 Nov
 2006 11:07:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965552AbWKTKG7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 05:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965555AbWKTKG7
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 05:06:59 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:21979 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S965552AbWKTKG6
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 05:06:58 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1131154ugc for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 02:06:57 -0800 (PST)
Received: by 10.78.201.15 with SMTP id y15mr5023664huf.1164017216555; Mon, 20
 Nov 2006 02:06:56 -0800 (PST)
Received: by 10.78.135.19 with HTTP; Mon, 20 Nov 2006 02:06:56 -0800 (PST)
To: "Alexander Litvinov" <litvinov2004@gmail.com>
Sender: git-owner@vger.kernel.org

On 11/20/06, Alexander Litvinov <litvinov2004@gmail.com> wrote:
> How can I see all changes for one file ? Including renames/copies ?

git log -M -C -r --name-status

> PAGER=cat git log -M -C --pretty=oneline b/a
>
> At lastline I would like to see two commits : renaming a -> b/a and creation
> of a. By the way, how can I see commit message with git log ?

