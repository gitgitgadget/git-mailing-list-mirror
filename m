From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t4202 (log): add failing test for log with subtree
Date: Mon, 22 Apr 2013 18:07:17 +0530
Message-ID: <CALkWK0kaYeOt3pdjae8rXPiPBWnfrAPOoOaQ73m2qktVxvoeTw@mail.gmail.com>
References: <1366632487-28153-1-git-send-email-artagnon@gmail.com>
 <vpqa9oqpxx7.fsf@grenoble-inp.fr> <87r4i2pxo5.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Apr 22 14:38:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUG0Q-0007jJ-2I
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 14:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753442Ab3DVMh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 08:37:58 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:40508 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840Ab3DVMh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 08:37:57 -0400
Received: by mail-ie0-f182.google.com with SMTP id bn7so4838475ieb.27
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 05:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=IB7bRjyY3Ux+IcRS0w1NG2kU7gGdA+CFsjCyAkbZlLE=;
        b=TgNIG0Ib9VUCRkhUYDUSqPShD6IWGmE9DtS4rz546KfVYlfgkA9yuZPJUsmMHcryVb
         oLABuARa4lfAlzWWcOdGxkp5dUheDdhOv1gScUKS1Vlvv1I3FMOysyFSuOfOKTJWy9vY
         MSa731lpgXH/nFtndVpYaUVY0tRdoaKwHub27QzxpBEIud0b0hPDTKLCNHQ9RUXkff72
         rH8vUgqXiaUCQFEE6yrD6sK/3x0dpXc8XPxNKbXHg4iEwWVBxOrd+G/Le8wAR7euSvHN
         ICpwkcFX9OQ7B/oQf4R4Bs8qnjYP8k5jdfqpQwHEXa7ArxHs+CQ0cCAwrFWatEqvlAog
         8AAg==
X-Received: by 10.50.17.71 with SMTP id m7mr15225202igd.14.1366634277270; Mon,
 22 Apr 2013 05:37:57 -0700 (PDT)
Received: by 10.64.63.48 with HTTP; Mon, 22 Apr 2013 05:37:17 -0700 (PDT)
In-Reply-To: <87r4i2pxo5.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222011>

Thomas Rast wrote:
> Umm, it should follow the rename.

There is no rename.  Unless there is a commit with the following diff
(with heuristically similar content), I don't see how --follow can
work:

    diff --git a/README b/README
    deleted file mode 100644

    diff --git a/subproject/README b/subproject/README
    new file mode 100644

Here, we just created one tiny merge commit after reading a tree into
a non-/ prefix.  There is no diff associated.
