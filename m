From: Stas Cherkassky <scherkas@gmail.com>
Subject: Re: collapsing old git history to reduce repo size, while preserving
 commit #s and tags
Date: Wed, 30 Oct 2013 09:52:19 +0200
Message-ID: <CAJSXqrrMCWmRBoRNCLuD6DvU=CSk+MVGrSOCeOROROEaKouVKQ@mail.gmail.com>
References: <CAJSXqrr4nA6azBgaD7rBbYSLWonQkn7PvSsPTXjAPaxW6E+LiA@mail.gmail.com>
	<CAJSXqrqz3KeiPKWz6rFKb4o0F88o9=63Sv37MJSp5qmYtod-6A@mail.gmail.com>
	<CAH5451=DGp0aRaA6c-ThO0Aj0VCAUFX17p8gOKPpURwEnjcpdA@mail.gmail.com>
	<CAJSXqrr7rHxyXX=_+xgJ4FW2UHSts2jRt7zwrkkw1L3uKHnCtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 08:52:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbQZk-0003eO-8r
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 08:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792Ab3J3HwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 03:52:20 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:61368 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784Ab3J3HwU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 03:52:20 -0400
Received: by mail-we0-f174.google.com with SMTP id u56so900301wes.33
        for <git@vger.kernel.org>; Wed, 30 Oct 2013 00:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DNOJKbW6IXgd0w5IjbENrppHpCyDk8Fj7BjiD00KkLI=;
        b=kjFrNsN7XDKweTDw757GCTR4f9of5LWhdJylrRr/FYDo7vjzktVInn1S9iwQx9ZkJH
         rb1kkhph07/G3IJHTMGWqk0/WE0Y8oilq7p26K26UTX99gGHzpkA7KoKeVR/vwXjWg61
         CBueIyKHYGTVZoIewjcsQc1QXZYqQzJ577llDd3sQk23TO+/HTf9MO3O7hmFZxhABy5T
         nn5LEJSQgGSdFJpopVteOmyIMBM8b0/OkKlYh+JybjywYz0x6Cvm4ISZlc5OFsuawZx3
         4A2rFCqiBqzP6w4+g8Va8xPfUYireNlXnVl8MwOSjtsJiPbcksWYSgWukfpkpJX+HxDU
         6AnA==
X-Received: by 10.194.185.173 with SMTP id fd13mr243169wjc.86.1383119539179;
 Wed, 30 Oct 2013 00:52:19 -0700 (PDT)
Received: by 10.194.201.97 with HTTP; Wed, 30 Oct 2013 00:52:19 -0700 (PDT)
In-Reply-To: <CAJSXqrr7rHxyXX=_+xgJ4FW2UHSts2jRt7zwrkkw1L3uKHnCtw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236998>

Andrew,

Shallow clone (if that's what you meant) is not suitable because it
doesn't allow to push/pull to/from this shallow repository.

I understand that generally git is designed to preserve the history.
But the problem is real,  and probably is not unique to our project.
The fact that there ARE some ways to modify history (collapse commits,
rebase, filter-branch) made me hopeful that what I need is also
possible..

thanks,
Stas
