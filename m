From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2] Maintaince script for l10n files and commits
Date: Thu, 8 Mar 2012 22:20:51 -0800
Message-ID: <CAJDDKr7A1LN_r5v0yiacpEHTtEqQG2Hf=YZ6GbtsOHLadozDKA@mail.gmail.com>
References: <7v399iddw3.fsf@alter.siamese.dyndns.org>
	<1331273307-64598-1-git-send-email-worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	avarab@gmail.com
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 07:21:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5tCE-0007ij-HX
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 07:20:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070Ab2CIGUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 01:20:53 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41110 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725Ab2CIGUw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 01:20:52 -0500
Received: by yhmm54 with SMTP id m54so697706yhm.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 22:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mMq+FrEJf8wUj6io6KRfpQHpNCV/8U3GqhvKanaWzlM=;
        b=Ecv21hsd6czwNaadquDJv8IKGlAfuwXN224my89utPk+BRB2A8abSf/sayKdxo/SJm
         h4yT1pFlTI5OdvrbFmEXwt4HT8vB5DvXvuZBRZ3BvyO/gr0GjZ/u/XL3XB+7oyAE/kYF
         sNqP9De35sc/TJE1oWNRW9nKhDSU6sq2N7AiUf74PE+2oinHtuuXyjGDZMKqAC87/irz
         9jLOKaAMWQ1bBC7i1efNzzbChLbmQsuEtu0zw0KCD+GZq0CbbanxbEFnRrVIZbm2cjAH
         H4INLIuhi+d1I4hGKCVD8ftnOApnvzCqRwiAZ+rNVdNp9BoBAH9htKys/EaYEdKiIU3O
         EC6g==
Received: by 10.236.155.6 with SMTP id i6mr955219yhk.87.1331274051968; Thu, 08
 Mar 2012 22:20:51 -0800 (PST)
Received: by 10.146.205.20 with HTTP; Thu, 8 Mar 2012 22:20:51 -0800 (PST)
In-Reply-To: <1331273307-64598-1-git-send-email-worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192681>

On Thu, Mar 8, 2012 at 10:08 PM, Jiang Xin <worldhello.net@gmail.com> wrote:
> diff --git a/po/po-helper.sh b/po/po-helper.sh
> new file mode 100755
> index 0000000..166ebb7
> --- /dev/null
> +++ b/po/po-helper.sh
> @@ -0,0 +1,387 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2012 Jiang Xin
> +
> +GIT=git

I think it's customary to just write `git` in shell scripts.  It looks
nicer then seeing $GIT everywhere, IMO.  I guess this could be helpful
in the future but I don't see GIT being reassigned anywhere.

Cheers,
-- 
David
