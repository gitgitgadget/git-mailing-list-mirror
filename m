From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2012, #04; Thu, 11)
Date: Fri, 12 Oct 2012 09:43:04 +0200
Message-ID: <CACBZZX6pzeWBshrA17oyTte0ZfOBQaK1SvP07TnTN4=v5imsjw@mail.gmail.com>
References: <7vtxu061tf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 09:43:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMZuD-0000hn-Up
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 09:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757450Ab2JLHn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2012 03:43:26 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:41274 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756551Ab2JLHnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2012 03:43:25 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so2622147oag.19
        for <git@vger.kernel.org>; Fri, 12 Oct 2012 00:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oVnL67IyG5+ma6TD6UroqDkwIIEUBf0HphREc5he6i8=;
        b=wBAA2GTnIjZiIcaUW8ZLxx8miRWd8wcm8rTGY/6IIVzbjaN4Is/nqsicRUN4UP3PM0
         m70wvrbvwiKRQLACEJLH6NQbCqpFgZ8v3eF11U5uiL5CI3DfUgOohwrqffuY0msM1XFu
         9q6G48QSSwX5oSU6v3sz8ZrMxuqhBtevP3hJdfGsfS9VuKsjE8fK7vdi5rnDrwfIOYM/
         +5YxzyTSg1I4uKvb8igdJ9WCoDOA7zOz9qQ05i5GfI3d8E9hcgYs5O7ahxyLgZnxS2zi
         mEItkt3NqezPzX9/bS0p5VCXpGKQDEXgAW1QGKH7X5EkKrcTG5GwRO7MqL+e1XFdEXm0
         AWrg==
Received: by 10.60.29.134 with SMTP id k6mr2810552oeh.5.1350027805091; Fri, 12
 Oct 2012 00:43:25 -0700 (PDT)
Received: by 10.60.94.225 with HTTP; Fri, 12 Oct 2012 00:43:04 -0700 (PDT)
In-Reply-To: <7vtxu061tf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207537>

On Fri, Oct 12, 2012 at 1:12 AM, Junio C Hamano <gitster@pobox.com> wrote:

> * jk/peel-ref (2012-10-04) 4 commits
>   (merged to 'next' on 2012-10-08 at 4adfa2f)
>  + upload-pack: use peel_ref for ref advertisements
>  + peel_ref: check object type before loading
>  + peel_ref: do not return a null sha1
>  + peel_ref: use faster deref_tag_noverify
>
>  Speeds up "git upload-pack" (what is invoked by "git fetch" on the
>  other side of the connection) by reducing the cost to advertise the
>  branches and tags that are available in the repository.

FWIW I have this deployed at work for a userbase of a few hundred
users, none of whom have had any issues with it, it does speed things
up a lot though.
