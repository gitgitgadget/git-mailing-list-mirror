From: "Matt Graham" <mdg149@gmail.com>
Subject: Re: [PATCH] I don't known anyone who understands what it means when they do a merge and see "file.txt: needs update". "file.txt: has changes" is much clearer.
Date: Sat, 3 May 2008 11:24:02 -0400
Message-ID: <1c5969370805030824h3ecdb967ub0c57f6fc9cbba58@mail.gmail.com>
References: <1209798522-13618-1-git-send-email-timcharper@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Tim Harper" <timcharper@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 03 17:24:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsJbc-0001ew-28
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 17:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756914AbYECPYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 11:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756870AbYECPYH
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 11:24:07 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:7880 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755871AbYECPYE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 11:24:04 -0400
Received: by wx-out-0506.google.com with SMTP id h31so218564wxd.4
        for <git@vger.kernel.org>; Sat, 03 May 2008 08:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=MN1N0Naj0e7kE1pAWb+c0ahW+8OtjUDeMVAGkGlS0WY=;
        b=Gh7s+ViBXuCxe+1QO9smTAaclpSLWIjvH/8QXXAceN8SvGQZu6BxY0rHOm+tSQD+SkIRNUq2Vf2j69TGzZPyKHF3HZe0XYJNHE0qqJ8IAaSZcTEhdpIs3A5yLBiXSfhN3WbGNs8dBzjxklra96121iqkTs2mdbXJ6h7ytnMCXcU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XdhlBdh6GAQKnoDexip824p/U61wet9IF+J8nqqSNX6LnMMv9VeDJg/CrHClLkhfLkgQ9DHi9+vcT/MR+6w/ZalXfIOQxCjIVG9RHrUxRFu4eRjga95GwbqqeWfCSk+o8MT11+Vkh5haAhZBcG6pEcX14fCcTab9KnZOZDa7OCY=
Received: by 10.142.47.6 with SMTP id u6mr1728028wfu.159.1209828242744;
        Sat, 03 May 2008 08:24:02 -0700 (PDT)
Received: by 10.142.170.10 with HTTP; Sat, 3 May 2008 08:24:02 -0700 (PDT)
In-Reply-To: <1209798522-13618-1-git-send-email-timcharper@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81097>

On Sat, May 3, 2008 at 3:08 AM, Tim Harper <timcharper@gmail.com> wrote:
> ---
>   read-cache.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
>  diff --git a/read-cache.c b/read-cache.c
>  index a92b25b..971667d 100644
>  --- a/read-cache.c
>  +++ b/read-cache.c
>  @@ -999,7 +999,7 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
>                         }
>                         if (quiet)
>                                 continue;
>  -                       printf("%s: needs update\n", ce->name);
>  +                       printf("%s: has changes\n", ce->name);
>                         has_errors = 1;
>                         continue;
>                 }
>  --
>  1.5.5.1

Yes, "needs update" is definitely cryptic and confusing.
