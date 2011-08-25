From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCH] attr: map builtin userdiff drivers to well-known extensions
Date: Thu, 25 Aug 2011 17:00:51 -0400
Message-ID: <CAPig+cQ33PESWC5fzN8enLFRwNPx8o+PgRUTeCva4dSJ_EdwOw@mail.gmail.com>
References: <20110825200001.GA6165@sigill.intra.peff.net>
	<20110825204047.GA9948@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Boaz Harrosh <bharrosh@panasas.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 25 23:00:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwh2n-0003ZO-Hw
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 23:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754733Ab1HYVAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 17:00:52 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:54080 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754577Ab1HYVAw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 17:00:52 -0400
Received: by gwaa12 with SMTP id a12so2114657gwa.19
        for <git@vger.kernel.org>; Thu, 25 Aug 2011 14:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=bU2gxMSFeOw1NL+7rmrOtb6hGWw4ikLFZ8UHu1jrzhk=;
        b=W9eU/hYDjuD+1orYzoTLYAPH6JBu5hvmutWJyIU3Xs2hkRWVdbVq9dIcZzZJtgqGst
         lZ5IkHeQYzaAvuyqN4vjjXnr8MFMNHeiF4H5WqId0C0W2oPZ46XwjnsUyZfD5+XSdw9A
         yfU0he2YmvqXk0lAHvMM/5EOrgNvJWN24oxbw=
Received: by 10.231.56.75 with SMTP id x11mr344535ibg.98.1314306051321; Thu,
 25 Aug 2011 14:00:51 -0700 (PDT)
Received: by 10.231.145.141 with HTTP; Thu, 25 Aug 2011 14:00:51 -0700 (PDT)
In-Reply-To: <20110825204047.GA9948@sigill.intra.peff.net>
X-Google-Sender-Auth: Zgjtzv51BT8ZThn0H6icCBoQg5o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180116>

On Thu, Aug 25, 2011 at 4:40 PM, Jeff King <peff@peff.net> wrote:
> We already provide sane hunk-header patterns for specific
> languages. However, the user has to manually map common
> extensions to use them. It's not that hard to do, but it's
> an extra step that the user might not even know is an
> option. Let's be nice and do it automatically.
>
> Also, any other extensions that would go into such a list? I have no
> idea what the common extension is for something like pascal or csharp.

C# uses extension ".cs".

".cpp" is common, in fact often required, by Windows compilers.

What about ".h" and ".hpp"?

-- ES
