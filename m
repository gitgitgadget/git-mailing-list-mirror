From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH] pathspec.c: Fix some sparse warnings
Date: Tue, 25 Sep 2012 19:03:06 +0100
Message-ID: <CAOkDyE8NGbApsF+v=UJUuaxvd9PYUfvf4yNDhNpHZ0tuqHHoBg@mail.gmail.com>
References: <5061E6BD.2070109@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Sep 25 20:03:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGZTc-0007qE-6T
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 20:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708Ab2IYSDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2012 14:03:10 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58726 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781Ab2IYSDI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 14:03:08 -0400
Received: by bkcjk13 with SMTP id jk13so1434793bkc.19
        for <git@vger.kernel.org>; Tue, 25 Sep 2012 11:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=NboVDJCmw7yP/d/zfLpbA2ylAcQGTaqFhYtHA6Yf5A8=;
        b=FKA3Gjjszly5CkTxO6yZxf/f9ag1+M4pxA2mz8jQgUD6HfeNfZzEkfQnuuLvwh0Zpq
         +rEYnGoOsqSnZbNLF0V3zZp9FMUePKkuhiB3dKeHZ/IXeKhAmt05hyeE9pVj9SKVqHTt
         a+X1zStN3/yu5Jl9F/ezLRUp6rE08vmUllOsWKQwuT26Z9erN5nsfVCaAKVrmTBrYEDw
         NvOY7VguvlzAuw/ixewET/OAAgnoEWxOUPOdgdlzVjx+e6PHLJ3p2TU5I03E4Oiixegu
         SBWpV+kmTr7gNYHNcNx7YtDexSA9c1yrc0aaF8KxJoLdFy+XuuvxRCBhdHzw8FgN3p68
         mxBQ==
Received: by 10.204.156.209 with SMTP id y17mr3981055bkw.134.1348596186809;
 Tue, 25 Sep 2012 11:03:06 -0700 (PDT)
Received: by 10.205.81.80 with HTTP; Tue, 25 Sep 2012 11:03:06 -0700 (PDT)
In-Reply-To: <5061E6BD.2070109@ramsay1.demon.co.uk>
X-Google-Sender-Auth: R9MIr7tlAiVHth-LfMONcIsaGgg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206368>

On Tue, Sep 25, 2012 at 6:15 PM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
>
> Sparse issues a warning for all six external symbols defined in this
> file. In order to suppress the warnings, we include the 'pathspec.h'
> header file, which contains the relevant extern declarations for these
> symbols.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>
> Hi Adam,
>
> When you re-roll your 'as/check-ignore' branch could you please squash
> this patch into commit a1080211 ("pathspec.c: move reusable code from
> builtin/add.c", 20-09-2012).

Will do, thanks a lot!
