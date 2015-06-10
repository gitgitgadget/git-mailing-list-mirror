From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: format-patch: fix typo
Date: Wed, 10 Jun 2015 14:36:13 -0700
Message-ID: <xmqqbngni6uq.fsf@gitster.dls.corp.google.com>
References: <1433970074-12497-1-git-send-email-fransklaver@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 23:36:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2nfY-0003Dg-Dd
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 23:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010AbbFJVgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 17:36:16 -0400
Received: from mail-ig0-f196.google.com ([209.85.213.196]:36479 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbbFJVgP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 17:36:15 -0400
Received: by igdh15 with SMTP id h15so6797244igd.3
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 14:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=erQMhapF732ruOn3eR/thl/cS3chBzCe3xfutJBfB4g=;
        b=Da3MRncuZSorr1eQurRVM7waiKBdBUGqZ6V4hNp6fx7VzvYUT8lKqor0op+hn60PUc
         mzAFLSuZKNMfOu3NiWU2nD60Te/fcwTPLQmbF4kDraSAePSNoF/NVdq9xai2Vfi5fM4Q
         9umBEiPRuL7eUrWdjptcj6QuyGTcEZ6CgEyTWrm981Faky1skEILWqv7IOTSVBST6J+y
         lhYAWrXyXNwlK7KKbbPaGJKYElJxk3U10U80fyzPIwr5kvfqDLNYsOmFwtxQvI9tPpGj
         uJhy0f0Tf56I9fCrdytMWWbNRJEbqhc8/Pf2m/k2tX/BriD0v3x3aJmW/XKqEO7lwdaA
         z9pw==
X-Received: by 10.107.14.193 with SMTP id 184mr7088518ioo.15.1433972174467;
        Wed, 10 Jun 2015 14:36:14 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:683f:a599:6eb8:1b1d])
        by mx.google.com with ESMTPSA id qs10sm4055532igb.14.2015.06.10.14.36.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jun 2015 14:36:13 -0700 (PDT)
In-Reply-To: <1433970074-12497-1-git-send-email-fransklaver@gmail.com> (Frans
	Klaver's message of "Wed, 10 Jun 2015 23:01:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271360>

Frans Klaver <fransklaver@gmail.com> writes:

> reroll count documentation states that v<n> will be pretended to the
> filename. Judging by the examples that should have been 'prepended'.
>
> Signed-off-by: Frans Klaver <fransklaver@gmail.com>
> ---

Good eyes; thanks.

>  Documentation/git-format-patch.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index bb3ea93..0dac4e9 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -170,7 +170,7 @@ will want to ensure that threading is disabled for `git send-email`.
>  -v <n>::
>  --reroll-count=<n>::
>  	Mark the series as the <n>-th iteration of the topic. The
> -	output filenames have `v<n>` pretended to them, and the
> +	output filenames have `v<n>` prepended to them, and the
>  	subject prefix ("PATCH" by default, but configurable via the
>  	`--subject-prefix` option) has ` v<n>` appended to it.  E.g.
>  	`--reroll-count=4` may produce `v4-0001-add-makefile.patch`
