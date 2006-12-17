X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] Add file addition/deletion indicator in diffstat
Date: Sun, 17 Dec 2006 07:23:13 +0700
Message-ID: <fcaeb9bf0612161623lae7410dy458d25ac33f41e0c@mail.gmail.com>
References: <20061111123331.GA23829@localhost>
	 <fcaeb9bf0612161612r36470c2fm3c0f19e56f6a16a@mail.gmail.com>
	 <7vhcvv8jjb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 17 Dec 2006 00:23:24 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hiH/tj5ZGYJLFCeRv8tl+7ZDWQOy/kSffhNv+MUJWZk3bBvStjpN7K4u63J2eMlvKDwoInFobwYgMhKHhT2Drf3Vtfpp1ocrFtUql87eKbuXo1rlO/zFvQk6+fRpH0kWImiF9sARDh43jzerLxQ8FJdZW+vICH0YaLrgQWDyVe4=
In-Reply-To: <7vhcvv8jjb.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34670>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvjoF-0005z3-5t for gcvg-git@gmane.org; Sun, 17 Dec
 2006 01:23:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750922AbWLQAXQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 19:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWLQAXP
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 19:23:15 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:34289 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1750922AbWLQAXO (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec
 2006 19:23:14 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1179137uga for
 <git@vger.kernel.org>; Sat, 16 Dec 2006 16:23:13 -0800 (PST)
Received: by 10.78.151.3 with SMTP id y3mr1754557hud.1166314993147; Sat, 16
 Dec 2006 16:23:13 -0800 (PST)
Received: by 10.78.100.8 with HTTP; Sat, 16 Dec 2006 16:23:13 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 12/17/06, Junio C Hamano <junkio@cox.net> wrote:
> "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:
>
> > I have used this patch for a while and found it actually useful,
> > especially while inspecting "git-log --stat". And if you prefer "git
> > diff --stat" over "git status", it may tell you which file you added
> > or deleted. So my only guess is that you missed it somehow. If it is
> > refused, may I know the reason? I can improve it on request :-)
>
> Doesn't seem to add much value over existing --summary.

Oh.. I didn't know that option. Sorry for the noise.
-- 
