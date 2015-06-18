From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/19] Make git-pull a builtin
Date: Thu, 18 Jun 2015 13:13:54 -0700
Message-ID: <xmqqfv5oepvh.fsf@gitster.dls.corp.google.com>
References: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 22:14:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5gCG-0007kp-Od
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 22:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756137AbbFRUN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 16:13:57 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:35588 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417AbbFRUN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 16:13:56 -0400
Received: by igbzc4 with SMTP id zc4so3648404igb.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 13:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=tA+OgY7pAoFRT87nugj7ZVjtIRtQp5m/s7gOfZHbp3Q=;
        b=LoNwV+sdLBe8o8yZt1Q8Trl5nVYWowzmIbTOVvAQt/xTg3CCpT7SW88Q0jKxjq4MgF
         pcfnEeDwiVoS/xowQQNzQ1LM+LG8c3zdCRNCP9gE1P9FQBgEZzFyJZt9HEcpT9IGrFSC
         7dXNppxxkEXkZQQWWQ8U4VbDuH9vVnUclA3sz8gLslucfN8jXYwxtruxn4bUq9MC6M/j
         RfP+lSqYNDNQqdnIevTzf9aawlS3veWJjwLEm0y2p3cTks3MTK1t++ekOcYfXVBdR77J
         QxZjCqzeUK32zGNsNZ5pT9DZ5VqNcyDi7jrCw9YG1dR0c3/szQD+5+/YFENxuGZsWYOv
         7QLQ==
X-Received: by 10.50.30.105 with SMTP id r9mr44920194igh.11.1434658435591;
        Thu, 18 Jun 2015 13:13:55 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e04a:861:67b3:9e25])
        by mx.google.com with ESMTPSA id eg3sm2447562igb.0.2015.06.18.13.13.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jun 2015 13:13:55 -0700 (PDT)
In-Reply-To: <1434624852-6869-1-git-send-email-pyokagan@gmail.com> (Paul Tan's
	message of "Thu, 18 Jun 2015 18:53:53 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272064>

Paul Tan <pyokagan@gmail.com> writes:

> This is a re-roll of [v3]. It squashes in Ramsay's patch "fix some sparse
> warnings", and fixes the use-before-free reported by Duy. Thanks a lot for
> dealing with my mess :-).
>
> Other than that, there are no other changes as I'm working on the git-am side
> of things.

I didn't look carefully, but does that mean 04/19 has the "what if
you start from a subdirectory and are still using the scripted one?"
issue we discussed recently for "am"?
