From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH (try 3)] http.c: 'use_git_config_string' on
 configuration options.
Date: Sun, 20 Apr 2008 06:06:29 +0200
Message-ID: <20080420060629.38407fe1.chriscool@tuxfamily.org>
References: <480A7499.1040705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Tordek <kedrot@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 20 06:02:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnQks-0002GF-Ni
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 06:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbYDTEBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 00:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbYDTEBT
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 00:01:19 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:34582 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750705AbYDTEBS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 00:01:18 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 85B8E1AB2BD;
	Sun, 20 Apr 2008 06:01:17 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 2FDE21AB2C0;
	Sun, 20 Apr 2008 06:01:17 +0200 (CEST)
In-Reply-To: <480A7499.1040705@gmail.com>
X-Mailer: Sylpheed 2.5.0beta1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79947>

On Sat, 19 Apr 2008 19:39:21 -0300
Tordek <kedrot@gmail.com> wrote:

> Signed-off-by: Guillermo O. Freschi <tordek@tordek.com.ar>
> ---
> My apologies, I had made a mistake on the previous attempt.
>
>   http.c |   36 ++++++++++++------------------------
>   1 files changed, 12 insertions(+), 24 deletions(-)
>
> diff --git a/http.c b/http.c
> index 256a5f1..8ae6432 100644
> --- a/http.c
> +++ b/http.c
> @@ -13,14 +13,14 @@ static CURL *curl_default;
>   char curl_errorstr[CURL_ERROR_SIZE];
   ^
There is one spurious whitespace before "char" in the above line.

>   static int curl_ssl_verify = -1;
   ^
In the above line too.

> -static char *ssl_cert = NULL;
> +static const char *ssl_cert = NULL;

These 2 lines above are fine.

>   #if LIBCURL_VERSION_NUM >= 0x070902
   ^
Here again there is one spurious whitespace.

[...]

>   static long curl_low_speed_time = -1;
>   static int curl_ftp_no_epsv = 0;
> @@ -100,39 +100,27 @@ static int http_options(const char *var, const 
> char *value)

"char *value)" should have stayed on the same line as "http_options(const char *var, const ".

Please try to send yourself your own patch and try to apply it using "git am", before you send it to the list. 

Thanks,
Christian.
