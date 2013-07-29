From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] git-rebase: fix typo
Date: Mon, 29 Jul 2013 15:58:16 +0530
Message-ID: <CALkWK0=8Ue7-a0nz0NafB6-a6J=3Waw4oy0rr5Q-Cj8ypA0FdQ@mail.gmail.com>
References: <1375071883-3017-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 29 12:29:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3khJ-00034F-Ge
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 12:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754485Ab3G2K26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 06:28:58 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:32866 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753541Ab3G2K25 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 06:28:57 -0400
Received: by mail-oa0-f41.google.com with SMTP id j6so3151466oag.0
        for <git@vger.kernel.org>; Mon, 29 Jul 2013 03:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PUn7RX3gcSjMq3xnahTldWMFpPguKySlKIrZdBK1pnc=;
        b=fht2AZ9QpHezAGC1vZd2KG12u9ARhoMFWL8ckUz0IAkRu4qhwPzf/nh9GSqcgVe+WK
         znRpl9uur0uccqD6/MMnolAz2lZ3h5J1I103C9E2c4FqnuAsoeqqpfrnk+yggsYQcdkx
         9AEwyHjSifzoNmVhmLwL6cL2rr5XXEytJL+Isn8tnZIDuVGrrimOcfjQOEwdIK0tgVEC
         XNIVKjKWO/L15dRdH2kWzxF3BBGqb1L2PUZ8TXHSk3zBEPSi6E8vSpZp/TBHQ7bEjb23
         K796TGTkpuo6C9gbolKTQ6qTyQxixnHr8X3m+LWp1WG9piERkNP4bSlOdSoJb0LAM3MH
         yqOQ==
X-Received: by 10.42.76.5 with SMTP id c5mr21648711ick.91.1375093736921; Mon,
 29 Jul 2013 03:28:56 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Mon, 29 Jul 2013 03:28:16 -0700 (PDT)
In-Reply-To: <1375071883-3017-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231282>

Ralf Thielow wrote:
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 0039ecf..8d7659a 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -159,7 +159,7 @@ finish_rebase () {
>                         die "$(eval_gettext "Cannot store \$stash_sha1")"
>                         gettext 'Applying autostash resulted in conflicts.
>  Your changes are safe in the stash.
> -You can run "git stash pop" or "git stash drop" it at any time.
> +You can run "git stash pop" or "git stash drop" at any time.

Good eyes, thanks.
