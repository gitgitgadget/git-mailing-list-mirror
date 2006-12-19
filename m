X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Vincent Legoll" <vincent.legoll@gmail.com>
Subject: Re: git-diff & cg-diff behavior difference
Date: Tue, 19 Dec 2006 11:33:21 +0100
Message-ID: <4727185d0612190233w26188a56t50ad49d2de58b88b@mail.gmail.com>
References: <4727185d0612170911l52fab839x694399db729fd62d@mail.gmail.com>
	 <46a038f90612181249y5ee69a8al28e97a22dca80c81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 19 Dec 2006 10:33:57 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Xd4Aa5qq/mR3ubfQE4rA3+POXB3gDMp0HtfivBsZtyHwQ4FdLnPBsyP1vBqRppXu6e7Nqvky6LCoVonmqgpGkn+xCqzpcxWTI7G/MTd9rHBXLpfVqO0bgQS2+GXXDuy9rrx4FTyS+r2AxDMbnn2w8my2JyPQ/VwaB3z0EJekI6s=
In-Reply-To: <46a038f90612181249y5ee69a8al28e97a22dca80c81@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34816>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwcHv-0001lb-CO for gcvg-git@gmane.org; Tue, 19 Dec
 2006 11:33:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932766AbWLSKdY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 05:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932762AbWLSKdY
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 05:33:24 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:35423 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932765AbWLSKdX (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec
 2006 05:33:23 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1772838uga for
 <git@vger.kernel.org>; Tue, 19 Dec 2006 02:33:21 -0800 (PST)
Received: by 10.82.107.15 with SMTP id f15mr882527buc.1166524401640; Tue, 19
 Dec 2006 02:33:21 -0800 (PST)
Received: by 10.78.177.13 with HTTP; Tue, 19 Dec 2006 02:33:21 -0800 (PST)
To: "Martin Langhoff" <martin.langhoff@gmail.com>
Sender: git-owner@vger.kernel.org

On 12/18/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> I'd say that it's a bug that cg-diff doesn't work in a subdir.
> However, there is a much more important difference between cg-diff and
> git-diff: cg-diff is equivalent to git-diff HEAD because cogito hides
> the index from you.

That's what I wanted to know: if it was a deliberate behavior, a bug on
my side, or on git's...

> If you are developing in a (mostly) straight line, and not dealing
> much with merges and rebases, that's a great simplification. If you
> are coming from a different SCM it's probably a good thing too.

That's me and me !

> If/when you want to use git's smarts for merging and rebasing, you'll
> definitely want to know a lot more about the index, and you'll
> probably stop using cogito.

That will be me some times...

> (Actually, even though I know and love the index I use cogito all the
> time, and switch to git commands for merging and rebasing. Works
> great... and yet Linus is in a merge-centric role, so changing the
> defaults to ignore the index most of the time is a bit of a hot issue

That's no problem with me, if behavior is properly documented...

-- 
