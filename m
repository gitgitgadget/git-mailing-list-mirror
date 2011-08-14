From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2011, #03; Thu, 11)
Date: Sun, 14 Aug 2011 14:14:52 +0530
Message-ID: <CALkWK0mxHT8by86-P=Msopgib1ToeHcfwsSXBYBgvN_dm75GnA@mail.gmail.com>
References: <7vr54rpogf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 14 10:45:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsWJq-0004XZ-RA
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 10:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321Ab1HNIpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Aug 2011 04:45:14 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38227 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904Ab1HNIpN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2011 04:45:13 -0400
Received: by wyg24 with SMTP id 24so2943133wyg.19
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 01:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=21uant8S1cthi1aYsGcJn6zq0BssNtV2+QEwogv2IaE=;
        b=rfZoHIdhWjAqZXZMewSO6920g/2e3pYRdZrV1tD0IaEmYbui5/rwwqMFxD4BFfyMfv
         P+Km/mTGn3/NrYmb/0QhheTxpBnt1oYd0mMm2izvwbCcoQTcxhJy2q/aNhCwy6KtZwEC
         +lxIiKDmWn6Qdkl7lBfuNum1/mr/SJC9/1i/I=
Received: by 10.216.131.134 with SMTP id m6mr1835145wei.78.1313311512147; Sun,
 14 Aug 2011 01:45:12 -0700 (PDT)
Received: by 10.216.172.132 with HTTP; Sun, 14 Aug 2011 01:44:52 -0700 (PDT)
In-Reply-To: <7vr54rpogf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179313>

Hi Junio,

Junio C Hamano writes:
> I am envisioning that we would declare feature freeze after most of the
> topics that are in 'next' as of today graduate to 'master' for the next
> release, and keep the remainder cooking for the cycle after that. Hopefully
> that would happen around 24th.

> * rr/revert-cherry-pick-continue (2011-08-08) 18 commits
> [...]
> Will merge to "next".

If this won't graduate to 'next' before the 24th, I have plenty of
time to re-roll fixing all the issues that I've addressed in the
beginning of the new series.  Depending on what you'd prefer, I can:
0. Do nothing.  Get this series merged, and get the fresh series
merged as originally planned.
1. Squash the first few patches in the new series into this series and
post a re-roll.  The new series will then be left with just two
commits.
2. Post a new series that combines both.  I won't introduce any new
code, so no fresh review will be required.  Since both the series have
been reviewed and tested independently, I don't see why this shouldn't
be possible.

Do let me know what you'd like.  Thanks.

-- Ram
