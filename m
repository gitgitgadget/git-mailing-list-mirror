From: Linus Arver <linusarver@gmail.com>
Subject: Re: [PATCH 4/7] Documentation: git-init: --separate-git-dir: clarify
Date: Fri, 8 Aug 2014 09:42:37 -0700
Message-ID: <20140808164236.GB791@k0>
References: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
 <1407002817-29221-5-git-send-email-linusarver@gmail.com>
 <xmqqiom6oabe.fsf@gitster.dls.corp.google.com>
 <20140806052129.GC12559@k0>
 <xmqqsil9msgs.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 18:42:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFnFd-000496-QW
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 18:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756791AbaHHQmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 12:42:42 -0400
Received: from mail-yh0-f54.google.com ([209.85.213.54]:60369 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756435AbaHHQml (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 12:42:41 -0400
Received: by mail-yh0-f54.google.com with SMTP id v1so4246134yhn.41
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 09:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=dp7b82PJCeAFFifj6YmN7Ptv5Yw0CbWKwf60wmCJiKo=;
        b=i/Y5UXWtOSLHO0SyGLICeV1DVrf1vGrZv7b/huyGWFS+AS5dyd8HqrUrnDZ9/FjDsu
         5iwtrbaDih4KvczKsIkk+xK1KlUJghJ7ErhsC+gBA+ONsQARV393sCDx/oUA07IA2aJS
         gnsJhemoozXqjcw0n2taK34S7cWnlIYeBEOsPMuXsZPL5yyjAUz+n8e8JeBDfg/5rmyf
         +y74xNwrWYW+SznrAXkwuAiWfssuXQioFVBuZjvRIYA2uLWB2IGoRUAIE1Bqsr1v45ly
         gCwFW0oCS+hmzXzG3q7cUT2dyAWK6m/WAtxNOZoTE9kREcjOhWA3udVee+h51VoxXqJT
         f/Lg==
X-Received: by 10.236.130.140 with SMTP id k12mr15983140yhi.80.1407516160938;
        Fri, 08 Aug 2014 09:42:40 -0700 (PDT)
Received: from k0 (107-223-14-32.lightspeed.sntcca.sbcglobal.net. [107.223.14.32])
        by mx.google.com with ESMTPSA id c25sm6567745yhc.24.2014.08.08.09.42.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Aug 2014 09:42:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqsil9msgs.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255024>

On Wed, Aug 06, 2014 at 10:35:31AM -0700, Junio C Hamano wrote:
> While I agree that it is a very good idea to state "what it does,
> what it is for" with the very first sentence of the paragraph,
> "separate the git repository from your working tree" does not say
> much more than the name of the option "--separate-git-dir" already
> tells the reader.

Ah, I see.

> And I do not offhand think of a better version
> (and obviously I didn't think of any when the current text was
> reviewed and committed).  The second sentence in your version is
> definitely an improvement over the first and the second sentences of
> the original ("where it is supposed to be" does not give any new
> information to those who don't know, and does not help those who
> already know).

OK.

> Perhaps we can simply remove the first sentence from your version?

Yes, I agree. I enjoy cutting excess verbiage.
