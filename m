X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] Introducing cg-xxdiff for conflict resolution
Date: Fri, 3 Nov 2006 15:41:47 +1300
Message-ID: <46a038f90611021841p54c38d72x12360ec93f32a8ad@mail.gmail.com>
References: <11546624471356-git-send-email-martin@catalyst.net.nz>
	 <20060924165037.GS20017@pasky.or.cz>
	 <46a038f90609241002i1db98ed6n118077089c9e417f@mail.gmail.com>
	 <20060924171246.GY13132@pasky.or.cz>
	 <46a038f90609241022i6ac11da1o1a1cba199595d036@mail.gmail.com>
	 <20060924172838.GZ13132@pasky.or.cz>
	 <46a038f90611021540s14b6098p477a68ef00c826e9@mail.gmail.com>
	 <20061103001135.GN20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 3 Nov 2006 03:06:58 +0000 (UTC)
Cc: "Martin Langhoff" <martin@catalyst.net.nz>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nZkjn+bkGv5nqIjFjQuhEF2MEO1iBuZsVgb65WGdIhv9XKYTA4KrKuKG6+ecPt99PUsY/dNBjIrFYmJOUzOgTf8c+9SAmBVaF+bCusfcaipAZNPZtWj2Vt+cZynWWcy+iuX0JLO2ueR8k9pqusFtEQdoH2a/kdW59fg1bywByi8=
In-Reply-To: <20061103001135.GN20017@pasky.or.cz>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30779>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfpAO-0003wO-40 for gcvg-git@gmane.org; Fri, 03 Nov
 2006 03:52:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752987AbWKCClu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 21:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752988AbWKCClu
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 21:41:50 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:41632 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1752986AbWKCClt
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 21:41:49 -0500
Received: by nf-out-0910.google.com with SMTP id x30so1184481nfb for
 <git@vger.kernel.org>; Thu, 02 Nov 2006 18:41:47 -0800 (PST)
Received: by 10.48.48.1 with SMTP id v1mr511065nfv.1162521707607; Thu, 02 Nov
 2006 18:41:47 -0800 (PST)
Received: by 10.49.60.1 with HTTP; Thu, 2 Nov 2006 18:41:47 -0800 (PST)
To: "Petr Baudis" <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

On 11/3/06, Petr Baudis <pasky@suse.cz> wrote:
> > Paski, did this one get dropped? Change of heart? Heart attack?
>
> Hmm, I thought we've agreed to go for the cg-resolve solution
> instead...?

Oops. That wasn't my reading. Misunderstood. In any case, if you go
back a bit in the conversation, the usage model I find this useful is
one where it makes sense to try different tools that have entirely
different parameters. That is why it makes sense to call them
differently.

So cg-meld [meld params] , is different from cg-xxdiff [xxdiff params]
and cg-wiggle [wiggle params] makes more sense to me and can be
maintained by different people (those who like meld probably dont' use
xxdiff ;-)

And from a packaging perspective, cg-resolve will depend on a zillion things.

cheers,


