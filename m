From: Xidorn Quan <quanxunzhen@gmail.com>
Subject: Re: [PATCH] credential-osxkeychain: support more protocols
Date: Mon, 27 May 2013 23:02:09 +0800
Message-ID: <CAMdq699G4bZSEQmZorRfOR87RZ7YGdNnkh_oP4rDZXXauOpDnQ@mail.gmail.com>
References: <1369641431-44504-1-git-send-email-quanxunzhen@gmail.com>
 <CAEBDL5W4sLB0R1ZOspb-yQzmyTCE7Y1HeC2KZ69F8R28fJY7_A@mail.gmail.com>
 <CAMdq6987TAj7f03mABkqu9v4wicarrZLYQypNUiOrP0fsLc4mQ@mail.gmail.com> <CAEBDL5XMamYoZFgFWeRr3KTZWZATKp=prFus_44UEMV8LEEtzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Mon May 27 17:03:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ugywy-0006c6-MS
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 17:03:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932847Ab3E0PCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 11:02:51 -0400
Received: from mail-vc0-f177.google.com ([209.85.220.177]:60171 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932720Ab3E0PCu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 11:02:50 -0400
Received: by mail-vc0-f177.google.com with SMTP id ib11so4793877vcb.36
        for <git@vger.kernel.org>; Mon, 27 May 2013 08:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lc5KroYzOBcj44zJJcgWsmuL9BUw8sDCMb6VY6zs+U0=;
        b=W/RktjPOK/eTwLMvsLTnfVdt4c0uEOPgHk7Y5hKSDXY4vH+o6JXe/asWuXZ2CFvu9d
         /bKRjDqTugnAdPAlbFGMLtuDLmUgGLohREX+LPf7NbB7473PBvbOqpa7PHl/PmgVinFo
         om5gZsdEmFnhWTcSSGjZmHnhJsyXcDw3Rzvych1BLT394FBr+WiTxicFj34vI5zfxP9q
         N8RT6nMqVzSw7Igdq56JcRLuk290S6NQrXfloBIyHs1+M29kH1hH9SUKPXCBBiKuGJOs
         VxdaSEv0xWlbWhVlz9sv1u7Q3U+Npqc5q+mz3s7J1LWVMsU+uezrwQjeRTLMl+G7ZWcU
         73lw==
X-Received: by 10.220.112.16 with SMTP id u16mr15631507vcp.40.1369666969805;
 Mon, 27 May 2013 08:02:49 -0700 (PDT)
Received: by 10.52.34.230 with HTTP; Mon, 27 May 2013 08:02:09 -0700 (PDT)
In-Reply-To: <CAEBDL5XMamYoZFgFWeRr3KTZWZATKp=prFus_44UEMV8LEEtzw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225596>

On Mon, May 27, 2013 at 10:28 PM, John Szakmeister <john@szakmeister.net> wrote:
[snip]
>
> You'll need to read Documentation/SubmittingPatches (here's a link to
> a version online:
> https://github.com/git/git/blob/master/Documentation/SubmittingPatches).
>
> You should resend this patch with the fix and change "[PATCH]" to
> "[PATCH v2]", so the folks involved know that this is the second
> iteration.  You also need to include a "Signed-off-by" line in your
> patch, which means you agree to the agreement set forth in the
> "Developer's Certificate of Origin" (which is in the SubmittingPatches
> documentation).  You can easily include this line when you make the
> commit by using the `-s` option on `git commit`.
>
> You can also add an "Acked-by" line for me (since I reviewed and
> approve of the change):
>
>     Acked-by: John Szakmeister <john@szakmeister.net>
>
> HTH!

Thx for your explaining, it helps a lot!

After reading the doc, I have a question that when can I affirm that
the list reaches a consensus?

--
Xidorn Quan
