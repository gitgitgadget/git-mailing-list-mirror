From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] submodule: make 'show' an alias for 'summary'
Date: Mon, 1 Oct 2012 12:15:14 +0530
Message-ID: <CALkWK0nRKopT4fm36UVyR4Jy1gfeSY4zGy+-nzxm=H=NGcR=DQ@mail.gmail.com>
References: <1348926195-4788-1-git-send-email-artagnon@gmail.com>
 <50670A94.2070504@web.de> <CALkWK0nCahg7165_JuJSj7u0UfYRGZgFjJ6O-o=HCwdsPwU-xg@mail.gmail.com>
 <50671364.5030205@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 01 08:45:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIZlA-0007TF-S7
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 08:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964Ab2JAGpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 02:45:35 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:52671 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416Ab2JAGpf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 02:45:35 -0400
Received: by qaas11 with SMTP id s11so1272297qaa.19
        for <git@vger.kernel.org>; Sun, 30 Sep 2012 23:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=u9G5D4CNoRiYFb+sVjOxmb3B9+8rNnmFxhp+WFsKDkc=;
        b=sN3Rb837lCHs6s+HoBHLnOf7mVz46d0dQsOopzJa80FzBDDGXGhYA4nweft0gmHwgK
         Vu7rXpe4v0Ywq+7koSL/jyInWP/UPcYI28U//DLibvFQrbt03zHmhJSzskb+LrEIKqop
         1midYEEmnZOeazzEURGbmlJrnlcy6iSIDJa7jnovCM5jeSf54dST97f1zWUEfSiY7tX2
         Ek09/RR5E83rVDIFdINTYILUie1y2dU5j5zsqgPsCQAnQu2aqKTd0rWrXENOykDW+Oq1
         Z6IqzGzpX976n7PFrORRKm4hwYGD/ghYzJj7REuZ/yniFm5pHFc3/BEq6gE31evu3EWT
         lZhw==
Received: by 10.224.192.66 with SMTP id dp2mr34625672qab.95.1349073934451;
 Sun, 30 Sep 2012 23:45:34 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Sun, 30 Sep 2012 23:45:14 -0700 (PDT)
In-Reply-To: <50671364.5030205@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206719>

Hi Jens,

Jens Lehmann wrote:
> I'm very interested in your feedback as a first time submodule user,
> what you wrote above makes sense and explains why you did that patch
> (and it would have been nice to read some of it in the commit message
> ;-). What information did you expect to get from a "git submodule
> show" which isn't already provided by "git status" and "git diff"
> (especially as they give you some information the "git submodule"
> commands don't)?

I expected 'git submodule show' to list all the submodules, and show
changes to specific submodules like the 'git submodule summary'
output.

Ram
