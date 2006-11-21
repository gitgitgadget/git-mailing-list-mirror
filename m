X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: remotes/* for "foreign" archives
Date: Tue, 21 Nov 2006 07:13:44 -0800
Message-ID: <m2y7q4bzo7.fsf@ziti.local>
References: <86y7q6m3zm.fsf@blue.stonehenge.com>
	<86r6vwkfti.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 21 Nov 2006 15:14:53 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:references:from:in-reply-to:user-agent:date:message-id:mime-version:content-type;
        b=dbCCJJ8ANk9ylNMc3999gfYC7aNoZiIJFYNb043trGMvE/as919rR2DFYoTpM00zGTjLv3gJ0gLlCEBo9boaU483619XJgpiPLwvRJW5FxzmOIRimNhNdxqRTOZrX+uvjLkRq0ZEYSusDIMDN7bLTFGgfPt6i70L0URM1nKaAR0=
In-Reply-To: <86r6vwkfti.fsf@blue.stonehenge.com> (Randal L. Schwartz's message of "21 Nov 2006 06:57:45 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31992>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmXJv-0002Sn-HR for gcvg-git@gmane.org; Tue, 21 Nov
 2006 16:13:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031005AbWKUPNz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 10:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031014AbWKUPNz
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 10:13:55 -0500
Received: from nz-out-0102.google.com ([64.233.162.193]:62224 "EHLO
 nz-out-0102.google.com") by vger.kernel.org with ESMTP id S1031005AbWKUPNz
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 10:13:55 -0500
Received: by nz-out-0102.google.com with SMTP id l1so1084142nzf for
 <git@vger.kernel.org>; Tue, 21 Nov 2006 07:13:54 -0800 (PST)
Received: by 10.78.201.15 with SMTP id y15mr6542973huf.1164122033584; Tue, 21
 Nov 2006 07:13:53 -0800 (PST)
Received: from ziti.local ( [67.171.24.140]) by mx.google.com with ESMTP id
 18sm10977940hue.2006.11.21.07.13.52; Tue, 21 Nov 2006 07:13:53 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

merlyn@stonehenge.com (Randal L. Schwartz) writes:
> It occurred to me after posting this, and while still thinking about the
> presentation I'm writing, that it'd be interesting if "get-fetch" could hide
> this from me.
>
> If the file in remotes/origin looked something like:
>
>         Pull: !git-svn multi-fetch trunk
>         Push: !git-svn commit
>
> then git-fetch and git-push could treat "origin" as a "foreign" branch
> and indirect through these commands.
>
> Then I could just use "git-pull" naively, and it would git-fetch origin,
> invoking git-svn multi-fetch trunk to update it, and later I could
> git-push and it would use git-svn commit.

This sort of integration could be quite cool.  But I think the most
common use of git-svn is with rebase and not pull.  My experience
with git-svn and pull is that I very quickly ended up making broken
commits to svn --- I've had much better luck rebasing.

