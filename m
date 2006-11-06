X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH/RFC] Convenient support of remote branches in git-checkout
Date: Tue, 7 Nov 2006 00:30:53 +0100
Message-ID: <200611070030.53935.Josef.Weidendorfer@gmx.de>
References: <200611070026.16425.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 6 Nov 2006 23:35:34 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.3
In-Reply-To: <200611070026.16425.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31033>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhDzx-0004e6-0v for gcvg-git@gmane.org; Tue, 07 Nov
 2006 00:35:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753719AbWKFXfW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 18:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753932AbWKFXfW
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 18:35:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:62103 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1753719AbWKFXfV (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 18:35:21 -0500
Received: (qmail invoked by alias); 06 Nov 2006 23:35:19 -0000
Received: from p5496B896.dip0.t-ipconnect.de (EHLO noname) [84.150.184.150]
 by mail.gmx.net (mp030) with SMTP; 07 Nov 2006 00:35:19 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Oops.

Corrections in example:

On Tuesday 07 November 2006 00:26, Josef Weidendorfer wrote:
> Example to hack on git's next branch:
> 
>  git-clone --use-separate-remote http://www.kernel.org/pub/scm/git/git.git
>  cd git
>  git-checkout origin/next
>  <hack on next>
>  git pull (to merge patches from remote 'next')
> 
> The checkout creates local branch 'master' to checkout read-only remote branch
                                     ^ next
> 'remotes/origin/master'. Additionally, it sets up 'remotes/origin/master' from
                  ^next                                             ^next
> remote repository 'origin' as default merge source for the new development branch.

