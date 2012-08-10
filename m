From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] mergetool,difftool: Document --tool-help consistently
Date: Fri, 10 Aug 2012 09:17:11 +0200
Message-ID: <CAHGBnuMCLkALCCAp1MiwQ1J+TuUhD=4k3LTGP2BMrp1LThb=HQ@mail.gmail.com>
References: <1344574365-5534-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 09:17:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzjTC-0000Rb-Ja
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 09:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755349Ab2HJHRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 03:17:13 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:57476 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595Ab2HJHRL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 03:17:11 -0400
Received: by vbbff1 with SMTP id ff1so843155vbb.19
        for <git@vger.kernel.org>; Fri, 10 Aug 2012 00:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iWrC1tWxDodfRxDzczIUcZ71zYjNdOVm1trlsIS8xc0=;
        b=HKQsqIV5+vbx9ebTPxgUjBqJRgD7QbvD+x+pHrn1hP6y+WPAejvbIDkfOgzC8skG8T
         6bHE4ZzsjWtdJJgPqOkRTgfPxghuTTQrgyXWJ1k3zmJWF7NbUOpQJw035xRLOyB0Fbv0
         3+XaEouK9y2xLVGzhscRIapHCcNMEjwCJddZVxuiKlmPxLEhb8k9uX+SoH9NinJ+fRc8
         +JOg8umrM1pcCtrJNqM0gYYnziIZBm5LwCJSb+REokAENBVtTRSiYj3TVqmsPPeU1+My
         Leo17d7m4A9dEDWjMW24Hil5lWQIqitgPQYAK2eBJHPZfnbvF9oq87c2FyO38+S+IU6P
         p4YQ==
Received: by 10.220.152.134 with SMTP id g6mr1739384vcw.10.1344583031203; Fri,
 10 Aug 2012 00:17:11 -0700 (PDT)
Received: by 10.58.68.167 with HTTP; Fri, 10 Aug 2012 00:17:11 -0700 (PDT)
In-Reply-To: <1344574365-5534-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203203>

On Fri, Aug 10, 2012 at 6:52 AM, David Aguilar <davvid@gmail.com> wrote:

> Add an entry for --tool-help to the mergetool documentation.
>
> Move --tool-help in the difftool documentation so that it is
> listed immediately after --tool so that it is easier to find.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>

Funny, I was doing almost the same thing in [1], so I obviously like
it. Back then Junio found it "Meh" because "it already is mentioned in
the
description of --tool above", but I still think all available command
line option should be listed as such.

> --- a/Documentation/git-mergetool.txt
> +++ b/Documentation/git-mergetool.txt
> @@ -64,6 +64,9 @@ variable `mergetool.<tool>.trustExitCode` can be set to `true`.
>  Otherwise, 'git mergetool' will prompt the user to indicate the
>  success of the resolution after the custom tool has exited.
>
> +--tool-help::
> +       Print a list of diff tools that may be used with `--tool`.
> +

This should say "list of merge tools", however.

[1] http://thread.gmane.org/gmane.comp.version-control.git/201913/focus=201922

-- 
Sebastian Schuberth
