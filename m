From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] git-am: ignore leading whitespace before patch
Date: Wed, 3 Aug 2011 15:21:44 +0200
Message-ID: <CAGdFq_it-QAA5uSme6S715dRzHs-s-Uj=MWKzBK2MOaaSdiXtg@mail.gmail.com>
References: <1312323646-93427-1-git-send-email-davidbarr@google.com> <CALUzUxpn-vCWpTQyB7z9dsu8a+UBL9MPjEycOfTmyws5ndz5kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Barr <davidbarr@google.com>,
	Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 15:22:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QobP3-0008Qh-L1
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 15:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755805Ab1HCNWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 09:22:25 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:43335 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755668Ab1HCNWY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 09:22:24 -0400
Received: by pzk37 with SMTP id 37so64860pzk.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 06:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=N9I7Ucjy+11svfSv/63vcWHRCj8t0zSTCMN1Vbj7o0c=;
        b=fec0Mjy8KUODlTdWoQ4PRghzSJXWqg58fk9UQOHv4Mj9uWaS4kJTIsuClPTat130gF
         8it9wB2maPFsleAh8QdO2lT0wWdam9DHfpobVRUdsOQGyQWjiq5aIOEAJyOCeup9TwEB
         VFeJG9gE9LRJpNQAbxgCrSeTuG7hHP62iFf+o=
Received: by 10.143.16.20 with SMTP id t20mr4617835wfi.349.1312377744090; Wed,
 03 Aug 2011 06:22:24 -0700 (PDT)
Received: by 10.68.71.162 with HTTP; Wed, 3 Aug 2011 06:21:44 -0700 (PDT)
In-Reply-To: <CALUzUxpn-vCWpTQyB7z9dsu8a+UBL9MPjEycOfTmyws5ndz5kA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178568>

Heya,

On Wed, Aug 3, 2011 at 14:28, Tay Ray Chuan <rctay89@gmail.com> wrote:
> On Wed, Aug 3, 2011 at 6:20 AM, David Barr <davidbarr@google.com> wrote:
>> Some web-based email clients prepend whitespace to raw message
>> transcripts to workaround content-sniffing in some browsers.
>> Adjust the patch format detection logic to ignore leading
>> whitespace.
>>
>> Signed-off-by: David Barr <davidbarr@google.com>
>
> Finally, patches from GMail that play nice with git-am!

So how do you get the patches out of gmail? Do you just copy/paste the
output of the "Show original" page?

-- 
Cheers,

Sverre Rabbelier
