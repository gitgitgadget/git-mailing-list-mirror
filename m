From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: About my git workflow; maybe it's useful for others
Date: Wed, 22 Apr 2015 16:38:01 -0300
Message-ID: <CACnwZYf6-Fh0JZeJZ4j3QOyqRF_2-NKJB06Wh20ipsRmrRN+qw@mail.gmail.com>
References: <CAGZ79kaK-uRAE9-rH=-5t8djAw5e9rwkPjZuw=+XWEq+V6R5Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 21:38:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl0TK-0001NU-KS
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 21:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755531AbbDVTiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 15:38:06 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:34713 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754484AbbDVTiD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 15:38:03 -0400
Received: by oiko83 with SMTP id o83so188185869oik.1
        for <git@vger.kernel.org>; Wed, 22 Apr 2015 12:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=byUqzKojIJ4zjCYlbNHXGM9/JzeJukAwmb8EKxC3PcQ=;
        b=ywtYv5oYS+a+x/b/t8YbMaapNFGnLKJWU6g9cU8P64VtLWJr72HqKjQGhfDutdDWaQ
         FHmqxAW0YSZQ4mIoos2bHHUyd/hxW6b3dJ60q9cwMGriuiIA2ZJVClOrNuuOk/tss+ER
         WS7OqErleo2+vEpPeyiEaDL/ChLL+6Y1JBYvfbKmhESRMSJAoabsR6tahWC/hshG4k5j
         MfusVzJgyH+UeuMi9BArHFoamCpnYs9GrAZfygUvF7/HVCm0HLB25DTfZo8vaLWtQMqP
         OiUBWFW6ptCiZdWz50FmNdqHGLQUqW1WoWHDp2f/VUVoV+tjDB6ZztSHQPDrLpIYpOUn
         l0mg==
X-Received: by 10.60.155.42 with SMTP id vt10mr6279822oeb.21.1429731482214;
 Wed, 22 Apr 2015 12:38:02 -0700 (PDT)
Received: by 10.202.80.136 with HTTP; Wed, 22 Apr 2015 12:38:01 -0700 (PDT)
In-Reply-To: <CAGZ79kaK-uRAE9-rH=-5t8djAw5e9rwkPjZuw=+XWEq+V6R5Yg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267622>

On Mon, Dec 29, 2014 at 10:22 PM, Stefan Beller <sbeller@google.com> wrote:
> Hi,
>
> so I have been sending commits to the git mailing list occasionally
> for quite some time. In the last couple of weeks I send more and more
> patches to the mailing list as it's part of my job now. Here is a
> collection of practices I am following (or want to follow) and they
> seem to be effective.
>
> Most of this is already documented in various documents in Documentation/*
> and this email is no news for the regular contributors. It may help new comers
> though.
>
> * Split patches up into logical pieces as you go.
>
> It's easy to go wild and after hours of hacking you have implemented a cool new
> feature. This the natural flow of hacking as it's the most fun. But
> this approach
> is not easy to be reviewed. So let me explain how reviewing works in
> the git project.
>
>         Reviewing works in the git project is quite liberal, anybody
> is encouraged to
>         comment on patches flying by. Junio, the maintainer then
> decides which patches
>         he picks up and merges them into the various stages of git
> (pu, next, master, maint).
>         The decision which patches are worth for inclusion is based on
> the amount of discussion
>         by the community and generally a patch only makes it if a
> concensus is met.
>
> * git send-email is the only email client I trust for sending patches
>
IMO, sending email is the easiest part.

The hard begins when you have to edit your patch and resend with the
reviewers' feedback incorporated. For me that is the most tricky and
hard part to get right, specially when using GMail as an email client.

How do you handle that part of the process?

-- 
Thiago Farina
