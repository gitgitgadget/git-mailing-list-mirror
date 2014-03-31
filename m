From: "Jason St. John" <jstjohn@purdue.edu>
Subject: Re: [PATCH 3/4] Fix misuses of "nor" in comments. (v3)
Date: Mon, 31 Mar 2014 15:54:10 -0400
Message-ID: <CAEjxke9pe23YAc_D-JmAd+HkgocNuTrwQxSkGS7DaJhgw9GMRg@mail.gmail.com>
References: <1396133950-5285-1-git-send-email-jlebar@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Richard Hansen <rhansen@bbn.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Justin Lebar <jlebar@google.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 21:54:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUiI2-0002vY-Ij
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 21:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbaCaTyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 15:54:33 -0400
Received: from mailhub248.itcs.purdue.edu ([128.210.5.248]:52935 "EHLO
	mailhub248.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750966AbaCaTyc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Mar 2014 15:54:32 -0400
Received: from mail-qa0-f49.google.com (mail-qa0-f49.google.com [209.85.216.49])
	(authenticated bits=0)
	by mailhub248.itcs.purdue.edu (8.14.4/8.14.4/mta-auth.smtp.purdue.edu) with ESMTP id s2VJsU4A031021
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Mon, 31 Mar 2014 15:54:31 -0400
Received: by mail-qa0-f49.google.com with SMTP id j7so8448901qaq.22
        for <git@vger.kernel.org>; Mon, 31 Mar 2014 12:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=drtDhBoD2CymUIg/kV0/Oi8pPRtvolJGclwt78Xi2sU=;
        b=Qv2lYQl0Kk1ENeBOZcujW38hgtMo7+gGNqKbYjcGHuI2Kyirk3g02/Euiy4RcaUiTl
         9IEW5AUQ5Vs2Og3LQPjxAzuaBhkM+RqSL4UWt8rqJOFsE+J5oIViuX0sjIaBF9LaLcoh
         8KcQooGw+dER46z7gQ+8PqEEsUIUmvsS4tJZBD1Ln5cBxTWj5xCM7iQsCO6kW0bTsJe/
         Flhu3vWotvkZCDk48ReUz/hRM3Q7WsA52GIih9tSusdVnxjtn2hPYvx//JWOvzD9KtR0
         1dQS9XMDkM4kbW0yK2Ay4/xXKb4UNsuIWtVZlAvH0DzYSWf79Fb8sRu1WNUjXuDCu3M7
         nLqA==
X-Received: by 10.224.36.194 with SMTP id u2mr9870309qad.73.1396295670272;
 Mon, 31 Mar 2014 12:54:30 -0700 (PDT)
Received: by 10.140.92.138 with HTTP; Mon, 31 Mar 2014 12:54:10 -0700 (PDT)
In-Reply-To: <1396133950-5285-1-git-send-email-jlebar@google.com>
X-PMX-Version: 6.0.2.2308539
X-PerlMx-URL-Scanned: Yes
X-PerlMx-Virus-Scanned: Yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245520>

On Sat, Mar 29, 2014 at 6:59 PM, Justin Lebar <jlebar@google.com> wrote:
> This version applies successfully to master, maint, next, and pu.  The other
> patches in the previous version of this queue apply successfully without any
> changes.
>
> Signed-off-by: Justin Lebar <jlebar@google.com>
>
> ---
>  Makefile                                    | 2 +-
>  builtin/apply.c                             | 2 +-
>  builtin/checkout.c                          | 2 +-
>  builtin/log.c                               | 2 +-
>  builtin/pack-objects.c                      | 2 +-
>  column.c                                    | 4 ++--
>  contrib/examples/git-checkout.sh            | 2 +-
>  contrib/examples/git-reset.sh               | 4 ++--
>  contrib/fast-import/import-directories.perl | 4 ++--
>  delta.h                                     | 2 +-
>  diff.c                                      | 2 +-
>  git-am.sh                                   | 2 +-
>  gitweb/gitweb.perl                          | 2 +-
>  http.h                                      | 4 ++--
>  perl/Git/SVN.pm                             | 2 +-
>  perl/Git/SVN/Migration.pm                   | 2 +-
>  pkt-line.h                                  | 8 ++++----
>  remote.c                                    | 2 +-
>  sha1_file.c                                 | 2 +-
>  test-chmtime.c                              | 2 +-
>  20 files changed, 27 insertions(+), 27 deletions(-)
>

<snip>

> diff --git a/http.h b/http.h
> index cd37d58..0a7d286 100644
> --- a/http.h
> +++ b/http.h
> @@ -13,8 +13,8 @@
>  /*
>   * We detect based on the cURL version if multi-transfer is
>   * usable in this implementation and define this symbol accordingly.
> - * This is not something Makefile should set nor users should pass
> - * via CFLAGS.
> + * This shouldn't be be set by the Makefile or by the user (e.g. via
> + * CFLAGS).
>   */
>  #undef USE_CURL_MULTI

There's a rather minor typo here: "be be"

Jason
