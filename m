From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH] Fix grammar in the 1.8.3 release notes.
Date: Tue, 30 Apr 2013 11:12:35 -0400
Message-ID: <CABURp0p+y_O4HVUfLpzTivmJrk61-bKdd+aEKm0uOtFCpTxBRQ@mail.gmail.com>
References: <7vvc78u8jl.fsf@alter.siamese.dyndns.org> <1367262904-9885-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 17:13:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXCEo-0003IO-7w
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 17:13:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267Ab3D3PM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 11:12:57 -0400
Received: from mail-vc0-f175.google.com ([209.85.220.175]:58961 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932247Ab3D3PM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 11:12:56 -0400
Received: by mail-vc0-f175.google.com with SMTP id lf10so503276vcb.6
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 08:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=+6CotA4O/gUU1rFQ07UEu9d8kmT0dldjfvPU0WPpwhk=;
        b=Kh0Bvq0y8e6ZDSavDPALbHluqbX3hfDr8WIoThwtSoYvIgfd9zU3WSX899o76S06Fq
         vD6yivkwgcHbQ7MvExB5P8OoPAxvjdYu5RMJtAfdH00MJSjGXmNCh8OZIOgzFhTcJUDF
         cEBwxcW0zE1CdjSZ4W2fl1NmTkp1LBMEcsKse4ETCuu2nRHLvAX5IrnKo1XzQWLXnejg
         atvlUBFJxO+cdWbjC8oYBPaT/BzSiZPd9o7LPxelqMqKJiC2fSm4a9+cnPZGzuD2qCkn
         J93S64SGGvtpp6kLiH4Kk65sIfgPpTOcvH/aXc6nzBELpxB6QleMeW7NdCrxFpYUISV5
         4WAg==
X-Received: by 10.52.26.209 with SMTP id n17mr30418379vdg.26.1367334775477;
 Tue, 30 Apr 2013 08:12:55 -0700 (PDT)
Received: by 10.58.135.1 with HTTP; Tue, 30 Apr 2013 08:12:35 -0700 (PDT)
In-Reply-To: <1367262904-9885-1-git-send-email-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222939>

On Mon, Apr 29, 2013 at 3:15 PM, Marc Branchaud <marcnarc@xiplink.com> wrote:
> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
>
> ---
>
> This started out as an attempt to make the backward compatibility notes
> more parsable, but then I just kept going...

s/parsable/parseable/
jk :-)

>  Documentation/RelNotes/1.8.3.txt | 145 +++++++++++++++++++--------------------
>  1 file changed, 72 insertions(+), 73 deletions(-)
>
> diff --git a/Documentation/RelNotes/1.8.3.txt b/Documentation/RelNotes/1.8.3.txt
> index 6d25165..06bc831 100644
> --- a/Documentation/RelNotes/1.8.3.txt
> +++ b/Documentation/RelNotes/1.8.3.txt
> @@ -8,23 +8,22 @@ When "git push [$there]" does not say what to push, we have used the
>  traditional "matching" semantics so far (all your branches were sent
>  to the remote as long as there already are branches of the same name
...
>
> - * "rev-list --stdin" and friends kept bogus pointers into input
> + * "rev-list --stdin" and friends kept bogus pointers into the input
>     buffer around as human readble object names.  This was not a huge

So long as you're at it...
s/readble/readable/

> @@ -268,17 +267,17 @@ details).
>   * "git diff --diff-algorithm algo" is also understood as "git diff
>     --diff-algorithm=algo".
>
> - * The new core.commentchar configuration was not applied to a few
> + * The new core.commentchar configuration was not applied in a few
>     places.
>
>   * "git bundle" did not like a bundle created using a commit without
> -   any message as its one of the prerequistes.
> +   any message, as it is one of the prerequistes.

s/prerequistes/prerequisites


P
