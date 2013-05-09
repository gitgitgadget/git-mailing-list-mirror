From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH 3/4] {fast-export,transport-helper}: style cleanups
Date: Thu, 9 May 2013 04:46:32 -0400
Message-ID: <CAEBDL5XZhEo14WKiz2m3KFRX+NsTFhmcz3adSti33RATMd897w@mail.gmail.com>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
	<1368062218-22440-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 09 10:46:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaMUu-0007ip-AT
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 10:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782Ab3EIIqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 04:46:36 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:43837 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309Ab3EIIqd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 04:46:33 -0400
Received: by mail-wi0-f171.google.com with SMTP id l13so5936665wie.16
        for <git@vger.kernel.org>; Thu, 09 May 2013 01:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=e0Jx1EX7yFwM8eMPCENiyVMYUAV5RVnNkCfw0a15uJM=;
        b=J3ZDDLaR5DPw1qIqmBQaGa/37CCqTY2H4i4ouKXrCYUiRN5F2dmeLv7vGQucPuZn3S
         GVHuj+u4lpRsU8HmqN/IchFFeMzK/t6cYTkGI145zgVXOVEtVmizekBbk2tab/Wh708y
         me0VZnkqnei2dQ+kMq6d0D0phVKzaEKGnbEL7s0U2qxbUCfs29WZXcxBJn0p97+Vujm6
         uTOlkz58zxATZGnDH/vDxkcpQFML1AkNbU/lryiFI2bB8rM2eU3DKiJmLdT+QK4lXWgY
         iyKduQFiIvMrGPXuZmDCdEjlGyTEdeN5Ij7VlELORPz0mFS0s33WPdZguIuxf9zJXnjR
         ijzA==
X-Received: by 10.180.183.210 with SMTP id eo18mr27293559wic.17.1368089192403;
 Thu, 09 May 2013 01:46:32 -0700 (PDT)
Received: by 10.180.78.69 with HTTP; Thu, 9 May 2013 01:46:32 -0700 (PDT)
In-Reply-To: <1368062218-22440-4-git-send-email-felipe.contreras@gmail.com>
X-Google-Sender-Auth: S4bQxE0jixPIJwQYCWe_CytAYSU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223715>

On Wed, May 8, 2013 at 9:16 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/fast-export.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index d60d675..8091354 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -135,7 +135,7 @@ static void export_blob(const unsigned char *sha1)
[snip]
> @@ -289,13 +289,13 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
>         parse_commit(commit);
>         author = strstr(commit->buffer, "\nauthor ");
>         if (!author)
> -               die ("Could not find author in commit %s",
> +               die("Could not find author in commit %s",
>                      sha1_to_hex(commit->object.sha1));

It looks like your simple replace didn't account for calls with
multiple lines.  Now the remaining lines don't line up.
:-)  There's several more places like this in the patch.

-John
