From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Fixed translation error (say(_())) functions
Date: Mon, 04 May 2015 17:19:45 +0200
Message-ID: <vpqpp6ggyjy.fsf@anie.imag.fr>
References: <554769df.43c8c20a.4b7f.ffffc3cb@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Alangi Derick <alangiderick@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 04 17:20:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpIAE-0005w5-F6
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 17:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbbEDPUC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 11:20:02 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51371 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752641AbbEDPTt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 11:19:49 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t44FJhAU020774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 May 2015 17:19:43 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t44FJjTA024078;
	Mon, 4 May 2015 17:19:45 +0200
In-Reply-To: <554769df.43c8c20a.4b7f.ffffc3cb@mx.google.com> (Alangi Derick's
	message of "Sun, 3 May 2015 23:05:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 04 May 2015 17:19:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t44FJhAU020774
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1431357584.37834@Zbc/VH+H36yutznE5fYThw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268330>

It seems you are posting putting the list in Bcc. Don't do that: it
makes it painful to reply to your message (I had to re-add git@vger
manually).

Alangi Derick <alangiderick@gmail.com> writes:

> Subject: [PATCH] Fixed translation error (say(_())) functions

Please, read the "(2) Describe your changes well." section of
SubmittingPatches (actually, read the whole document if not done
already, but particularly this section). Your subject does not adhere
the usual format.

> Signed-off-by: Alangi Derick <alangiderick@gmail.com>
> ---
>  base85.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/base85.c b/base85.c
> index 5ca601e..4160f44 100644
> --- a/base85.c
> +++ b/base85.c
> @@ -78,7 +78,7 @@ int decode_85(char *dst, const char *buffer, int len)
>  
>  void encode_85(char *buf, const unsigned char *data, int bytes)
>  {
> -	say("encode 85");
> +	say(_("encode 85"));

These are debug statements (see the top of base85.c). I don't think you
want to translate them.

> @@ -96,7 +96,7 @@ void encode_85(char *buf, const unsigned char *data, int bytes)
>  		}
>  		buf += 5;
>  	}
> -	say("\n");
> +	say(_("\n"));

Same, plus the fact that a \n would not need to be translated anyway I
guess.

Regards,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
