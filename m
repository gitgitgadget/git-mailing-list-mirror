From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] Undocument deprecated alias 'push.default=tracking'
Date: Mon, 23 Apr 2012 08:21:01 -0700
Message-ID: <xmqqmx62lbj6.fsf@junio.mtv.corp.google.com>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335170284-30768-3-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Apr 23 17:21:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SML4g-0000Yd-DS
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 17:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898Ab2DWPVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 11:21:05 -0400
Received: from mail-bk0-f74.google.com ([209.85.214.74]:36386 "EHLO
	mail-bk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882Ab2DWPVE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 11:21:04 -0400
Received: by bkcjk7 with SMTP id jk7so75018bkc.1
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 08:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=1lPVGBtRU25OBo/J3RhKQcY1J/6L3LAv7STToH1c6O0=;
        b=A26aGJBRypjCf8bDyMgqnVwBVuG+2Ks7NLlpKbcOHCQXX4OuyEG1IPmFe+ihbZtGP5
         z37062iyZwo/6hpGHAiq1sojCXYHLO5v9ilO3PFl2gfYrogN/bUqPbpvRmkj0UGqo5sd
         T9y0nVFaFIRpzPC8dCb8iqyjtfO8TvUMjWmetvVu1tPt7XlxPaedV1SetGDcAOHCKTi3
         cgWN6j0cRbInGCJ6pDBo0pa2Akg9nculefXrQ/fB16KtaSa6dAWNAC8EEx9YLmbm6OBH
         BjQUK1kNNEgieGNgggbt5+v8kiw1Wr2Ov00QJ+ZopzdVEl2lUibwHX1XmAbzUSxQDrKp
         5auQ==
Received: by 10.213.35.65 with SMTP id o1mr1339661ebd.2.1335194462286;
        Mon, 23 Apr 2012 08:21:02 -0700 (PDT)
Received: by 10.213.35.65 with SMTP id o1mr1339644ebd.2.1335194462150;
        Mon, 23 Apr 2012 08:21:02 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id a14si14944816een.0.2012.04.23.08.21.02
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Mon, 23 Apr 2012 08:21:02 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id EBBCC5C0065;
	Mon, 23 Apr 2012 08:21:01 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 5CEBBE120A; Mon, 23 Apr 2012 08:21:01 -0700 (PDT)
In-Reply-To: <1335170284-30768-3-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Mon, 23 Apr 2012 10:37:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQm4MFgEMQFYKsDYLQbmQWR4RsnTk1K5oNQ8uTUBHrAuLyizTubHgN739ZjGmjodm+8i5+9HAw3PWpCEoLsEbQ1ZbVfxJL1YA5UDhBX+qPQ572AXszkbT7zDOgxJoJs5j6q0IC962CyudCye/mH7WlGmek9c98R921/ClYFJx7qNWX20J/E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196130>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> It's been deprecated since 53c4031 (Johan Herland, Wed Feb 16 2011,
> push.default: Rename 'tracking' to 'upstream'), so it's OK to remove it
> from documentation (even though it's still supported) to make the
> explanations more readable.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> Feel free to squash into previous one if needed.

Thanks, but let's keep it separate.

>  Documentation/config.txt |    1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index e38fab1..ddf6043 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1693,7 +1693,6 @@ push.default::
>    makes `git push` and `git pull` symmetrical in the sense that `push`
>    will update the same remote ref as the one which is merged by
>    `git pull`.
> -* `tracking` - deprecated synonym for `upstream`.
>  * `current` - push the current branch to a branch of the same name.
>    +
>    The `current` and `upstream` modes are for those who want to
