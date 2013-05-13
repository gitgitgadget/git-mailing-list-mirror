From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 0/6] remote-hg: fixes and cleanups
Date: Mon, 13 May 2013 18:15:18 -0500
Message-ID: <CAMP44s0ArwaQ7GmwnP8r5DyqxDShJDkSJnUYQsGSzU589o2Quw@mail.gmail.com>
References: <1368219566-1399-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 01:15:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc1xm-0007o6-R2
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 01:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755497Ab3EMXPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 19:15:20 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:59352 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755480Ab3EMXPT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 19:15:19 -0400
Received: by mail-lb0-f178.google.com with SMTP id p10so3311336lbv.9
        for <git@vger.kernel.org>; Mon, 13 May 2013 16:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Tnr3fOUCWgKdfn2Gu3ubuoENeT+OESmwHy/RvpAmaHU=;
        b=BwLA2w/lY6d8/PEogY8F/gzWpf6NfRlys+bSmZ3vbjrODAJMmNbkXb2f7HJdiXzK67
         VpQVKaUZSnYRKfRvyGt5jgrfc9k9Qe/RD3z+FvdZqFj1L2+6gcyw7QCh+HN/97Z2JfHI
         GUk0acMff6PjETQ8bHZ1bbcaZpdZlqlE3Rgs6FlYjp5NY2aYKc3RsjwEZB/Pd3vHnXbf
         KSZx1KEWWz13VkgQZusf+FyMESgtbSOftOeW7CfghgeAdLKy/1K9PMwZ+6eGgkmEVfRE
         EBfBU7smAmzQQ49N5dOQiVRLJ7IfmU4SuShcYZIMu3dD9cZ4Gxyry5MWTEpi8uke2JeF
         PjRQ==
X-Received: by 10.112.125.130 with SMTP id mq2mr13853386lbb.103.1368486918148;
 Mon, 13 May 2013 16:15:18 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Mon, 13 May 2013 16:15:18 -0700 (PDT)
In-Reply-To: <1368219566-1399-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224229>

On Fri, May 10, 2013 at 3:59 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

> A few fixes since last series, plus a few more patches. Simple no-brainers.
>
> Felipe Contreras (6):
>   remote-hg: disable forced push by default
>   remote-hg: don't push fake 'master' bookmark
>   remote-hg: update bookmarks when pulling
>   remote-hg: test: be a little more quiet
>   remote-hg: fix new branch creation
>   remote-hg: trivial reorganization
>
>  contrib/remote-helpers/git-remote-hg | 18 +++++++++++-------
>  contrib/remote-helpers/test-hg.sh    |  4 ++--
>  2 files changed, 13 insertions(+), 9 deletions(-)

I was expecting these to be merged to 'master', but since they are
still not merged, I decided to send more cleanups.

-- 
Felipe Contreras
