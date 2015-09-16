From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2015, #03; Mon, 14)
Date: Wed, 16 Sep 2015 09:04:28 -0700
Message-ID: <xmqqio7as643.fsf@gitster.mtv.corp.google.com>
References: <16A99EC6028D41FFB0D36D4A1945B113@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Git List" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Sep 16 18:04:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcFCE-0001h8-HY
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 18:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826AbbIPQEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 12:04:30 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34140 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145AbbIPQEa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 12:04:30 -0400
Received: by padhy16 with SMTP id hy16so213051871pad.1
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 09:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=OqeC5Bt1dsFgSeeUvEbRh2zSEkwWr7ud0iQDnIAfITg=;
        b=zFPrwRQd4NP7x9NyWApP1acq4ksQWmjgwKjT2uZ6LnX9OwwoT8VFywsJpR+WbFphOJ
         +DQMXJG1rlQHe+o3Yd9nb95n9PZO7B61QjOc902xnbU8QbaIkMOM2b2O2uqNHxaxgzMf
         D7yujwI84Vvs/UevAWk2/6dTucjko8Sjwfy5Hi7lGuZ3aU8sZmPV2qBDRuZQJ+eN61ef
         Wh4hhQmWBfltR2kQ7E2elj/Go3Ef/yIhTvQC44Tsr+Sh4C1wHtz03uJTp1hGt6eGmxwC
         izqJxAqJReftCtbMdwAST/9qj+lL5Ttz6U3KEleANm/8PkPxLlKQX95FfKtl1RS/JGTP
         x1FA==
X-Received: by 10.67.1.106 with SMTP id bf10mr61461093pad.74.1442419469657;
        Wed, 16 Sep 2015 09:04:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:150c:7d53:9693:493e])
        by smtp.gmail.com with ESMTPSA id xd10sm28767253pab.25.2015.09.16.09.04.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 09:04:28 -0700 (PDT)
In-Reply-To: <16A99EC6028D41FFB0D36D4A1945B113@PhilipOakley> (Philip Oakley's
	message of "Tue, 15 Sep 2015 20:08:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278034>

"Philip Oakley" <philipoakley@iee.org> writes:

> Oops..
> ...
>> Shall I just rework/resend the V2 patch-up ($gmane/277829) that also
>> links to 'merge's' usage as a fresh patch (would be tonight UK)?
>
> I now see that the full V2 patch is already there at 4934a96.

OK.  I was wondering what I missed.  4934a96^2 is a copy of your v2.

> I'd mistakenly just compared your note to the slightly fuller V2 commit
> message and in the morning rush hadn't had time to check.
>
> Sorry for the noise.

Thanks for being careful.
