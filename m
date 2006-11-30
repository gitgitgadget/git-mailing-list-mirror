X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Michael K. Edwards" <medwards.linux@gmail.com>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 13:41:37 -0800
Message-ID: <f2b55d220611301341n45c45506rca312dfa8ee6f795@mail.gmail.com>
References: <7virgzuf38.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0611300903080.3513@woody.osdl.org>
	 <Pine.LNX.4.64.0611301229290.9647@xanadu.home>
	 <87irgwu6e6.wl%cworth@cworth.org> <87hcwgu5t1.wl%cworth@cworth.org>
	 <Pine.LNX.4.64.0611301132350.3513@woody.osdl.org>
	 <Pine.LNX.4.64.0611301521320.9647@xanadu.home>
	 <Pine.LNX.4.64.0611301253380.3513@woody.osdl.org>
	 <eknhjr$nce$1@sea.gmane.org> <878xhsty3t.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 21:42:08 +0000 (UTC)
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WME1xEdJ1w/RrqLLrBq++e3xMHpVk8bR27t+QJUQLhkw/kFw+bu17UyWA3fJUdjyzdPN8zBibqv8rbxUOQsuryQq8+/EVnLb0Lpmf2U7V+5mX5cYakk+PVoHamV8ozUhcxcGEcL7rYWAWP8EAZz/5+/qfibifRM0+h98fqWKWqI=
In-Reply-To: <878xhsty3t.wl%cworth@cworth.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32806>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gptf3-0002qd-O6 for gcvg-git@gmane.org; Thu, 30 Nov
 2006 22:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967930AbWK3Vlj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 16:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967931AbWK3Vlj
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 16:41:39 -0500
Received: from wx-out-0506.google.com ([66.249.82.236]:60546 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S967930AbWK3Vli
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 16:41:38 -0500
Received: by wx-out-0506.google.com with SMTP id h27so2788312wxd for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 13:41:37 -0800 (PST)
Received: by 10.90.120.13 with SMTP id s13mr4319289agc.1164922897442; Thu, 30
 Nov 2006 13:41:37 -0800 (PST)
Received: by 10.90.94.7 with HTTP; Thu, 30 Nov 2006 13:41:37 -0800 (PST)
To: "Carl Worth" <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

On 11/30/06, Carl Worth <cworth@cworth.org> wrote:
> So I'd vote for "resolve" along with something else for the
> mark-as-edited case. Maybe "refresh"? That's the best I've thought of
> so far. Anyone else have a better suggestion? It does clash with the
> separate notion of "git update-index --refresh" which is a bit
> annoying. Any other suggestions for this?

git mark

and git add becomes just a synonym for git mark.

Cheers,
