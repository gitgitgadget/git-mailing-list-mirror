From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 42/43] refs: add LMDB refs backend
Date: Wed, 07 Oct 2015 12:08:21 -0700
Message-ID: <xmqqvbaits2i.fsf@gitster.mtv.corp.google.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
	<1443477738-32023-43-git-send-email-dturner@twopensource.com>
	<56129B77.1030409@alum.mit.edu>
	<1444182660.7739.77.camel@twopensource.com>
	<561564EC.8070704@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 07 21:08:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zju4i-0001hN-Mo
	for gcvg-git-2@plane.gmane.org; Wed, 07 Oct 2015 21:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022AbbJGTIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2015 15:08:24 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:32897 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbbJGTIY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2015 15:08:24 -0400
Received: by pacex6 with SMTP id ex6so29339203pac.0
        for <git@vger.kernel.org>; Wed, 07 Oct 2015 12:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=T/YXmuz/p2+5j1vVHG6GIoog+T3TPR4ZSSAwV6cWDCc=;
        b=1AkMAkHZ9iekjsJ3GKugaGWwG7jdjmbjTHm5ZwRWY4mGFN+xMhq08X0f+ktI86t8yE
         f2gau09zeWKeW4VMAeMwInw3GgexwLz2Y1Is4yGIGRCidsBHWmsGOlu7AQLUIDq1No4g
         ywkxovc4DUVQDAUGFQnfFeS+kFyBjw133UZfhpJWuDmQNPp2jCXYdgUcTBUhrPuiJu5b
         cMGV42PwVemoCc4DxeGklinv5MuZ6lB8KvAd8/BVjV6FjxNHbjTS8ai+d9rXUylJw8U/
         FBQWnoJgePAMEfgq0ou8KUd4+s6OgROerr/jzhw3h2m5cdmab7uFTzQbW0daTB6xj6EV
         xIrQ==
X-Received: by 10.66.219.74 with SMTP id pm10mr2782531pac.93.1444244903466;
        Wed, 07 Oct 2015 12:08:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c434:fdeb:15ec:325c])
        by smtp.gmail.com with ESMTPSA id tk4sm41165422pab.45.2015.10.07.12.08.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 07 Oct 2015 12:08:22 -0700 (PDT)
In-Reply-To: <561564EC.8070704@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 07 Oct 2015 20:31:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279193>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I'm really happy about your work.
>
> Regarding strategy: I think a good approach would be to get as much of
> the preparatory work as possible (the abstraction and separation of
> refs-be-files) to the point where it can be merged before there is too
> much more code churn in the area. That work is not very controversial, I
> think, and letting it wait for a long time will increase the likelihood
> of conflicts with other people's changes. The refs-be-lmdb patches, on
> the other hand, (1) will take longer to get polished, (2) will take
> longer to review because other people are not familiar with LDMB, and
> (3) won't bitrot very fast anyway because they don't overlap as much
> with areas that other people are likely to work on. So I would advocate
> working on those at a more deliberate pace and planning for them to be
> merged as a separate batch.

I agree with you on all counts.

My wish is for you to play an interim maintainer starting around
week #7 (Nov 9th) of this cycle and merge the early "preparatory"
part to 'next' before I come back around the end of November ;-)
to be shipped as part of the release at the end of this cycle.

Thanks.
