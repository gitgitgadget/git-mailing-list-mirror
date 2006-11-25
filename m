X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Fredrik Kuivinen" <frekui@gmail.com>
Subject: Re: [RFC] Teach git-branch howto rename a branch
Date: Sat, 25 Nov 2006 11:39:03 +0100
Message-ID: <4c8ef70611250239h4e03b9c7k971b60187aa0f56d@mail.gmail.com>
References: <1164409429445-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 25 Nov 2006 10:39:17 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pfYeZDUJCLu8U7PEpHrnorqCsoBfnyGzIxyt8yqFkm52Yx2w7WJV1RNt6hm7pDktiFa6S9ynD3xcZuCve3O+2tl1qq1+xhMOA1svW82reuwhPsvc1nLkt23ZBwgDYiRJyysYGU2u7Jbn3LJ4jGqlsFVj2cUYMcPPlm9Sr0k5ChU=
In-Reply-To: <1164409429445-git-send-email-hjemli@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32279>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnuwB-0007Kz-8T for gcvg-git@gmane.org; Sat, 25 Nov
 2006 11:39:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966417AbWKYKjH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 05:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966420AbWKYKjH
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 05:39:07 -0500
Received: from wx-out-0506.google.com ([66.249.82.234]:42077 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S966417AbWKYKjF
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 05:39:05 -0500
Received: by wx-out-0506.google.com with SMTP id h27so1129959wxd for
 <git@vger.kernel.org>; Sat, 25 Nov 2006 02:39:04 -0800 (PST)
Received: by 10.70.56.4 with SMTP id e4mr2746353wxa.1164451144304; Sat, 25
 Nov 2006 02:39:04 -0800 (PST)
Received: by 10.70.49.14 with HTTP; Sat, 25 Nov 2006 02:39:03 -0800 (PST)
To: "Lars Hjemli" <hjemli@gmail.com>
Sender: git-owner@vger.kernel.org

On 11/25/06, Lars Hjemli <hjemli@gmail.com> wrote:
> This adds a '--rename' option to git branch. If specified, branch
> creation becomes branch renaming.
>
> With a single branchname, the current branch is renamed and .git/HEAD is
> updated.
>
> With two branchnames, the second name is renamed to the first.

Nice idea. But wouldn't it be more sensible to rename the first branch to the
second instead of the other way around? That is, the syntax would be

    git branch --rename FROM TO

which is more similar to how "mv" works.

