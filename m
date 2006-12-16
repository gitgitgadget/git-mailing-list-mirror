X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 16 Dec 2006 02:20:00 +0100
Message-ID: <e7bda7770612151720w2e65fe83s9942e1ec1f7092a2@mail.gmail.com>
References: <20061130170625.GH18810@admingilde.org>
	 <200612150007.44331.Josef.Weidendorfer@gmx.de>
	 <e7bda7770612150943j71a7362bmb509cea3b7756003@mail.gmail.com>
	 <200612152242.50472.Josef.Weidendorfer@gmx.de>
	 <e7bda7770612151543o39c9d233q91ea643a134196d3@mail.gmail.com>
	 <e7bda7770612151713k418434e6gd8d565e49a766477@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 16 Dec 2006 01:20:40 +0000 (UTC)
Cc: "R. Steve McKown" <rsmckown@yahoo.com>,
	"Linus Torvalds" <torvalds@osdl.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pkW+LRo0Cfp1GFzQYJRAjNp+F5fGLcVPI2KJr/G1hPwMkwZxhxEZhrujtk0vlCXe8CfakH74C3k4xmUtLpjODJh8v6flEvcAWv+HhQp5ZVaJti5+TXaPGzqFstj44gLxfbyiSx+fAhkam9JfVIgnNos6ibvg63R1Km4xWwtPqS4=
In-Reply-To: <e7bda7770612151713k418434e6gd8d565e49a766477@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34583>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvOE3-00038U-Op for gcvg-git@gmane.org; Sat, 16 Dec
 2006 02:20:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965315AbWLPBUG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 20:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965314AbWLPBUG
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 20:20:06 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:1852 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S965316AbWLPBUF (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec
 2006 20:20:05 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1281663nfa for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 17:20:02 -0800 (PST)
Received: by 10.49.58.13 with SMTP id l13mr709747nfk.1166232000534; Fri, 15
 Dec 2006 17:20:00 -0800 (PST)
Received: by 10.49.28.8 with HTTP; Fri, 15 Dec 2006 17:20:00 -0800 (PST)
To: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

On 12/16/06, Torgil Svensson <torgil.svensson@gmail.com> wrote:
>
> example tree object:
>
> 100644 blob <sha1 of blob>    README
> 100644 blob <sha1 of blob>    REPORTING-BUGS
> 100644 link <sha1 of blob>     <sha1 of commit>
> 040000 tree <sha1 of tree>    arch
> 040000 tree <sha1 of tree>    block
> 040000 link <sha1 of tree>     <sha1 of commit>
>

Sorry, I was sloppy and forgot the names:

100644 blob <sha1 of blob>    README
100644 blob <sha1 of blob>    REPORTING-BUGS
100644 link <sha1 of blob>     <sha1 of commit>   AUTHORS
040000 tree <sha1 of tree>    arch
040000 tree <sha1 of tree>    block
040000 link <sha1 of tree>     <sha1 of commit>   misc

Now it doesn't looks like trees/blobs anymore so maybe a link object is handy:

100644 blob <sha1 of blob>    README
100644 blob <sha1 of blob>    REPORTING-BUGS
100644 link <sha1 of link>      AUTHORS
040000 tree <sha1 of tree>    arch
040000 tree <sha1 of tree>    block
040000 link <sha1 of link>     misc

link-object:
<sha1 of commit>
