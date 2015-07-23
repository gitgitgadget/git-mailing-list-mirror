From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Config variables and scripting // was Re: [RFC/PATCH] log: add
 log.firstparent option
Date: Wed, 22 Jul 2015 23:55:27 -0700
Message-ID: <CA+P7+xrX5q_abQYZ-LkzAjvEKmZ+-ykJBS-DwOaLJ6d62-CHPw@mail.gmail.com>
References: <20150723012343.GA21000@peff.net> <20150723044007.GA3651@gmail.com>
 <20150723051445.GA24029@peff.net> <20150723054816.GA1917@peff.net>
 <CA+P7+xrNiK168rXX3SwwmQFPR6i4iA0nhFdfHKL7wqwtwvnEPA@mail.gmail.com> <20150723065310.GA7542@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	Josh Bleecher Snyder <josharian@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 23 08:55:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIAQ4-000273-3J
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 08:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbbGWGzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 02:55:48 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:35978 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbbGWGzr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 02:55:47 -0400
Received: by iehx8 with SMTP id x8so105338891ieh.3
        for <git@vger.kernel.org>; Wed, 22 Jul 2015 23:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=F8Gx1y7XCGJR8tm517V+MoJDd1tQWaB5zzHWzo/kGUA=;
        b=eHYDf6K5adAhXsUkftoo5fA2E2trlSQ0kO7w7/bGPD6opkmhFuiUIUFSkz+gna+Jwh
         oZAXcZbsjywYo56DuB8f1s9oH4UdPOdFfLDr4WKQjssvRVhUXM4L9EP9zmCBCbaqGm4N
         g9bCybTPtlnQYdpNQ1dfHgDJ7tlROtDqZWRBgfiR6xaVtFE5LL9+ZNLjKz0TSPmrI8ix
         KTa+/jlOWV4+bUfYOQtET8OsoBvmYmq5d/wdqss+DcA/bmTziCS1Bu/HeLQaXcXEPuXN
         m1HGEKhvuErbeQxPcBsDH5SfjVq1xyIgcymG9rSw93XECls7uhutwWY4cVkg7QdwS9ua
         k4Mg==
X-Received: by 10.50.102.68 with SMTP id fm4mr12753946igb.25.1437634546719;
 Wed, 22 Jul 2015 23:55:46 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Wed, 22 Jul 2015 23:55:27 -0700 (PDT)
In-Reply-To: <20150723065310.GA7542@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274484>

On Wed, Jul 22, 2015 at 11:53 PM, Jeff King <peff@peff.net> wrote:
> "man git" already has such a list (which is generated from the
> annotations in command-list.txt). But I agree that it would probably be
> helpful to point people directly from "git log" to "git rev-list" and
> vice versa.
>
> -Peff

That's good. I just know that I've had many a co-worker complain
because the man page felt too technical because they accidentally
found their way into a plumbing section. If I heard a specific case of
confusion again in the future I'll try to work up a patch for it.

Regards,
Jake
