From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv2] Documentation/SubmittingPatches: Explain the rationale
 of git notes
Date: Mon, 29 Dec 2014 18:18:37 -0500
Message-ID: <CAPig+cQgG5Ua-k1D8yKF5K+tfXeSB_wTN9W3m08F+K7AtKWDaw@mail.gmail.com>
References: <xmqqwq5ja7s2.fsf@gitster.dls.corp.google.com>
	<1419874942-9901-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 00:18:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5jaF-0000jU-Ot
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 00:18:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbaL2XSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 18:18:39 -0500
Received: from mail-yk0-f169.google.com ([209.85.160.169]:33750 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbaL2XSi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 18:18:38 -0500
Received: by mail-yk0-f169.google.com with SMTP id 79so6803692ykr.14
        for <git@vger.kernel.org>; Mon, 29 Dec 2014 15:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=AjRx23k6qDXEJAllQM0/6GSZWzdRE/wXxAx3qByhJwk=;
        b=fWqJ/0jYxsoq3WdL6SSTbS/G4rweD7x2w9lajwmEs9xJdfi393LLGF04AV4+Hf7ZKn
         JFLVO6MttJArPyG7ieV08RdLleKZlHtqqFSs2q4BfSpM/W81lWzrpeLW4RQxJiv/9FQT
         9LU2ubTUcqSCXRWT3v72KmrPDxiDXSsJiOAIOdlrbO3P5zVTKQ3zyMSko/rKEf9c7rrK
         oWi5u39fN7X1AAjmXFt9ACAtRSZKhlikG74IBbNLdDjZJQkAtYglZC1n8d+XvomK7Exu
         dy7ZhWbujlwhjnnoof3ZUIpPuOyhgUav5Y+mXFvegh7TQAvlVzheU9Z6oRP0F1PTD987
         kzuQ==
X-Received: by 10.236.89.172 with SMTP id c32mr40324508yhf.180.1419895117789;
 Mon, 29 Dec 2014 15:18:37 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Mon, 29 Dec 2014 15:18:37 -0800 (PST)
In-Reply-To: <1419874942-9901-1-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: aVg30GRrNFjTy7lc-blW_Us6EaU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261897>

On Mon, Dec 29, 2014 at 12:42 PM, Stefan Beller <sbeller@google.com> wrote:
> This adds more explanation of why you want to have the --notes option
> given to git format-patch.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index e3c942e..f42c607 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -177,7 +177,12 @@ message starts, you can put a "From: " line to name that person.
>  You often want to add additional explanation about the patch,
>  other than the commit message itself.  Place such "cover letter"
>  material between the three dash lines and the diffstat. Git-notes
> -can also be inserted using the `--notes` option.
> +can also be inserted using the `--notes` option. If you are one
> +of those developers who cannot write perfect code the first time
> +and need multiple iterations of review and discussion, you may
> +want to keep track of the changes between different versions of
> +a patch using notes and then also use the `--notes` option when
> +preparing the patch for submission.

Perhaps this could be rephrased in a less derogatory fashion like this:

    ...material between the three dash line and the diffstat.
    For patches requiring multiple iterations of review and
    discussion, an explanation of changes between each iteration can
    be kept in Git-notes and inserted automatically following the
    three dash line via `git format-patch --notes`.

>  Do not attach the patch as a MIME attachment, compressed or not.
>  Do not let your e-mail client send quoted-printable.  Do not let
> --
> 2.2.1.62.g3f15098
