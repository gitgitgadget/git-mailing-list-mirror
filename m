From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] filter-branch: remove multi-line headers in msg filter
Date: Mon, 12 Oct 2015 09:05:29 -0700
Message-ID: <xmqqtwpwm5rq.fsf@gitster.mtv.corp.google.com>
References: <20151009002113.GA329@freya.jamessan.com>
	<561767AC.6060503@drmicha.warpmail.net>
	<xmqqpp0oormv.fsf@gitster.mtv.corp.google.com>
	<561B60B1.10003@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: James McCoy <vega.james@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Oct 12 18:05:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlfbX-0007DJ-Ug
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 18:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752229AbbJLQFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 12:05:33 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33756 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052AbbJLQFb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 12:05:31 -0400
Received: by pabrc13 with SMTP id rc13so22636639pab.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 09:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=0SZK3BlVV7N0IXJXj8lgIFRJ07dQm7VYi/WfuyUXitY=;
        b=H2q5J60PBtFyG7l7uJeD+pWAG/EkpXj2ureLmqn2yVOH/7fNJiGdPopw8hVQ5QjWS6
         K1dVZ6ufsAr4zRZ9b/GpUdP21rxkVRNrZJMqaGhBmlUcTQ0MjGwv0l93ENNPrL/+gNSH
         GlDEpgCFTrclR5yi4vDHIFTKXWqxBZNCxGrIvTg6O1ew62ieZrOfV4GUUS2ST2WaeVi3
         TuXWBuNfMBT+5sEnIqPUhumMHOi0e9p9A21SeFU41/8P9Xpa8Flr43XAw4d5pjuoQUM6
         i6cClUicW4r19A/kM5LCbIRSSmg/vAdwPmI4o45dIbT1aKSGZejtGYamYVHatjzrIDxr
         SWHw==
X-Received: by 10.69.17.1 with SMTP id ga1mr34689270pbd.163.1444665930651;
        Mon, 12 Oct 2015 09:05:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:448f:3a3:d25a:82f])
        by smtp.gmail.com with ESMTPSA id zn9sm19267294pac.48.2015.10.12.09.05.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 12 Oct 2015 09:05:30 -0700 (PDT)
In-Reply-To: <561B60B1.10003@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Mon, 12 Oct 2015 09:26:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279379>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Yep, I'm fine with "mini-mentoring", and just to be safe, the 7 new
> characters in git-filter-branch.sh are (also)
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>
> in case that is needed or preferred.

I was wondering if we want to do that or I can just add comments
"based on MJG's suggestion" or somesuch.  Most likely I'd do both
;-)

Thanks.
