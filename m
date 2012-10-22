From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] remote-testgit: properly check for errors
Date: Mon, 22 Oct 2012 14:01:23 -0700
Message-ID: <CAGdFq_gOb3GX1iZshGZahZEbj3RqQSEk8AN_hHXKyD5aHwfxYA@mail.gmail.com>
References: <1350939394-21622-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 22 23:02:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQP8d-0001z8-M3
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 23:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755559Ab2JVVCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2012 17:02:07 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:44299 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754889Ab2JVVCF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2012 17:02:05 -0400
Received: by mail-qc0-f174.google.com with SMTP id o22so1764075qcr.19
        for <git@vger.kernel.org>; Mon, 22 Oct 2012 14:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=KI4TZpQZfw+tpoXfxO0fXhNC30usc9JlWERBjFvKO4Q=;
        b=XqZWBaAv3mCmr/rX6jnvH0BIoEsvOgsQRZ8dLczKCR78ukzhj3+qLI3DV/TIXQHmfX
         +UsVW3KwM+b0uPaPkxzWKUu1bKmWdbpIRMaCPWGKZAsFY1E6/sF2a8MOyssE9TY9aI87
         2KYjTVGURgTmerbob+O60areUl+o7NS5aKXO+097cvQeESFnNkpmimRU87vErquBRzUL
         qOnAapAdaeqy4bVCeJxraWpGApssguaLbRm/gAsaGIezXfBAfKwYv3+PH4LIeF8OdQ34
         TRmaDrniD2Mfn7sRapNU6VWZClUH38uF5NNNL38QnqwyPaiy+WOlcPjcjJTdFF03b9ny
         h2rw==
Received: by 10.224.58.132 with SMTP id g4mr4613642qah.21.1350939723318; Mon,
 22 Oct 2012 14:02:03 -0700 (PDT)
Received: by 10.49.36.195 with HTTP; Mon, 22 Oct 2012 14:01:23 -0700 (PDT)
In-Reply-To: <1350939394-21622-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208203>

On Mon, Oct 22, 2012 at 1:56 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> diff --git a/git-remote-testgit.py b/git-remote-testgit.py
> index 5f3ebd2..b8707e6 100644
> --- a/git-remote-testgit.py
> +++ b/git-remote-testgit.py
> @@ -159,6 +159,11 @@ def do_import(repo, args):
>          ref = line[7:].strip()
>          refs.append(ref)
>
> +    print "feature done"

There's not enough context for me to see in which part of the code
this is, import or export? If you advertise 'feature done', shouldn't
you also print 'done' when you finish writing the fast-export stream?
If that's already the case feel free to ignore me :)

-- 
Cheers,

Sverre Rabbelier
