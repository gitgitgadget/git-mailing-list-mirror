From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH v4 0/3] Finishing touches to "push" advises
Date: Thu, 24 Jan 2013 23:14:41 -0600
Message-ID: <CAEUsAPZfLafLUiQmk8GhF4hUHGDFP-4X85Nfv8Q7-hHy_Mp5OA@mail.gmail.com>
References: <20130121234002.GE17156@sigill.intra.peff.net>
	<1358978130-12216-1-git-send-email-gitster@pobox.com>
	<CAEUsAPYAikZUTf9OE=PoGBYot6Udnw9XTYDs6Ug7h=PWbCYM1Q@mail.gmail.com>
	<7va9rx7t0e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 06:15:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tybd3-00035L-NK
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 06:15:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961Ab3AYFOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 00:14:45 -0500
Received: from mail-lb0-f170.google.com ([209.85.217.170]:55272 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667Ab3AYFOn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 00:14:43 -0500
Received: by mail-lb0-f170.google.com with SMTP id ge1so73665lbb.1
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 21:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=61b4AR8ODP/4CwYHo37rTiNbZ9qWPOu7xaJdb2b7ZTU=;
        b=Mvpaa5ZzOgqtn9TK6ncvbTCrIsUe2gDYaY148dnQRVMU+68wWBJvYdQxGbSz3o82W5
         u78wrTKXYr71eBNHti2gaA0b3gDimN5WuSCfOLBqwqEbGw4DgI8n4YjxRyeGLnRcCVcQ
         f96T79Kfow3IWmxgq6XxVM3l1J41+es2fETFt3P1BYVecuxn6NW/HjJSrUwrtW1wcYDL
         40WxrLs+CFI3Yvd7uV9nhWjYYIbxqZAEhJQIDyMAyEfP+Pig9GvxLtXCy5I3Y02JFK+w
         b4y46MRYCmzl5FF6NMe9EuFmVlLiOR2kIrjc4+EMLPgTETzwDgd+8b/31H+7+O/mR35l
         pVRA==
X-Received: by 10.112.26.41 with SMTP id i9mr1692172lbg.77.1359090882094; Thu,
 24 Jan 2013 21:14:42 -0800 (PST)
Received: by 10.114.2.97 with HTTP; Thu, 24 Jan 2013 21:14:41 -0800 (PST)
In-Reply-To: <7va9rx7t0e.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: qeJvCH8naIFXtXzsyOOr3ruvWko
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214498>

On Thu, Jan 24, 2013 at 11:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Would it be sufficient to do this?  I think "the tag already exists
> in the remote" is already clear that we are talking about the
> destination.

Good point.

> diff --git a/builtin/push.c b/builtin/push.c
> index a2b3fbe..78789be 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -228,7 +228,7 @@ static const char message_advice_ref_fetch_first[] =
>            "See the 'Note about fast-forwards' in 'git push --help' for details.");
>
>  static const char message_advice_ref_already_exists[] =
> -       N_("Updates were rejected because the destination reference already exists\n"
> +       N_("Updates were rejected because the tag already exists\n"
>            "in the remote.");
>
>  static const char message_advice_ref_needs_force[] =

Looks like the new-line is now unnecessary, but that looks good to me.

Thanks,

Chris
