From: David Michael <fedora.dm0@gmail.com>
Subject: Re: [PATCH v2] compat: convert modes to use portable file type values
Date: Thu, 4 Dec 2014 14:27:24 -0500
Message-ID: <CAEvUa7nxzX=54QJto_R3hfvAO4FKhs8Pancz0TTiC7ev22--Kw@mail.gmail.com>
References: <87wq68w3se.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 04 20:27:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwc3l-0006VM-Fh
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 20:27:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932885AbaLDT10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 14:27:26 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:50900 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932820AbaLDT1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 14:27:25 -0500
Received: by mail-pa0-f41.google.com with SMTP id rd3so18528127pab.14
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 11:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=dHfMD8g5PqIcO/ca00VF2GmhEp2wp6884fhXIRifWdw=;
        b=quqaH/Fhr74fqVpeUO+pQ2fNLAANSK4Onnq+g/g+CZIg9oE86GczYkKlzoTVwSzbx+
         Hw80lSKBMkYmkeIeb91DPHBIHfw3Ops+2hzH1h0mlFUyxgkPSx8RmvmhX5HuPRP2dGqT
         SbSc6OPOENDcIG2PfKuenZjHqyP6BPWGNeFP5/hVW0kAUNlwPR7SU3yQdUJuBJAlQlol
         2Vr9/ef9SowY7YtVOsM4e/1kX1w6CLGSTgbdhitYBhLXLprVPdkRFSasMxSiWvT6Av/M
         6057ZfvIRe18Hq79VsyRHYfWaBQjsoqj+rwJ9BgGEkzlwpdfcZB81v49UCSHr+4lc6Go
         VIIg==
X-Received: by 10.68.69.109 with SMTP id d13mr28762871pbu.57.1417721244825;
 Thu, 04 Dec 2014 11:27:24 -0800 (PST)
Received: by 10.70.55.36 with HTTP; Thu, 4 Dec 2014 11:27:24 -0800 (PST)
In-Reply-To: <87wq68w3se.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260786>

On Wed, Dec 3, 2014 at 9:24 PM, David Michael <fedora.dm0@gmail.com> wrote:
> --- /dev/null
> +++ b/compat/stat.c
> @@ -0,0 +1,49 @@
> +#define _POSIX_C_SOURCE 200112L
> +#include <stddef.h>    /* NULL         */
> +#include <sys/stat.h>  /* *stat, S_IS* */
> +#include <sys/types.h> /* mode_t       */

Oops, the <stddef.h> line can be removed now that this is no longer
testing for NULL.  Let me know if this warrants a v3 if there is no
other feedback.

Thanks.

David
