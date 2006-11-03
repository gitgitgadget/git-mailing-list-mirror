X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Allow hand-editing of patches before sending
Date: Fri, 3 Nov 2006 14:01:43 +0000
Message-ID: <b0943d9e0611030601v7db6d862ve568c95b17dd0da1@mail.gmail.com>
References: <20061101090046.1107.81105.stgit@localhost>
	 <b0943d9e0611020232x1e343bbco9451c8183c84d68@mail.gmail.com>
	 <20061102113631.GA30507@diana.vm.bytemark.co.uk>
	 <b0943d9e0611030139i7be9569bh4a29596a768e82a3@mail.gmail.com>
	 <20061103095859.GC16721@diana.vm.bytemark.co.uk>
	 <b0943d9e0611030444w13e04586u185413c2562d45bc@mail.gmail.com>
	 <20061103130259.GA20611@diana.vm.bytemark.co.uk>
	 <b0943d9e0611030525t5da2cce7nf7b41323411e8d2d@mail.gmail.com>
	 <20061103133933.GP20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 3 Nov 2006 14:13:48 +0000 (UTC)
Cc: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qD3h3lMjV9mubXh0iXDD42pgNSIWnOYDHu9flyZYSrTv2Lfc5kyMNTteJhrAQlED2EeWtLZvYAdL43+mXxm0OoOvDqqJwt4yUHm6XXLgOBTc18mPpwqXUim1jueWjxPwKk0yq7Xtfj3U+fdY72qAws7mDEIugFUmFXY37x70REQ=
In-Reply-To: <20061103133933.GP20017@pasky.or.cz>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30856>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfzlv-0006Bt-Jr for gcvg-git@gmane.org; Fri, 03 Nov
 2006 15:11:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752976AbWKCOLs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 09:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753213AbWKCOLs
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 09:11:48 -0500
Received: from py-out-1112.google.com ([64.233.166.177]:24105 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S1752976AbWKCOLr
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 09:11:47 -0500
Received: by py-out-1112.google.com with SMTP id a73so323716pye for
 <git@vger.kernel.org>; Fri, 03 Nov 2006 06:11:46 -0800 (PST)
Received: by 10.35.77.1 with SMTP id e1mr3347199pyl.1162562503867; Fri, 03
 Nov 2006 06:01:43 -0800 (PST)
Received: by 10.35.77.5 with HTTP; Fri, 3 Nov 2006 06:01:43 -0800 (PST)
To: "Petr Baudis" <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

On 03/11/06, Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Fri, Nov 03, 2006 at 02:25:36PM CET, I got a letter
> where Catalin Marinas <catalin.marinas@gmail.com> said that...
> > I just run git-am and "stg uncommit" or "assimilate".
>
> git-am calls git-mailsplit and git-mailinfo, and those two tools will do
> most of the work (basically everything except the actual committing) for
> you, I use them in cg-patch -m and it should be fairly trivial to make a
> stg command reusing those too.

Yes, indeed, these are the commands I would use. I wouldn't go further
in calling git-am or git-applymbox directly as I try not to use too
many of the porcelain'ish git scripts.

-- 
