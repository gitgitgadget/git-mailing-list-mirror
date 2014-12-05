From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] refs.c: let fprintf handle the formatting
Date: Fri, 5 Dec 2014 11:54:58 -0800
Message-ID: <CAGZ79kbYDK0kJuwk+ksx3iB2cHzKvP54rCaH1o2Pknh-Axcfqw@mail.gmail.com>
References: <1417809221-27209-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 20:55:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwyy0-000487-RW
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 20:55:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989AbaLETzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 14:55:00 -0500
Received: from mail-ie0-f182.google.com ([209.85.223.182]:64694 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbaLETy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 14:54:59 -0500
Received: by mail-ie0-f182.google.com with SMTP id x19so1398784ier.13
        for <git@vger.kernel.org>; Fri, 05 Dec 2014 11:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FJoGrt8Bj927BMsDJPB9LbioM+jxCnQhx4W3huaium0=;
        b=Sut1ysIGeYS8jI5l/7Ql1uPX4peLzQjB0Ftqr4Vj1AYtjCfKl0/T0YOus9RUXjP+lG
         XmIEpeGQOD6lfUB9s38OU23KTFGheWUFCwsd2JGebcCGO8qUTe9SO283/zonyKh5jmmG
         4e7/FkzpvspsT03GRweiPTWYGK/1Gf/k75qB74RuPzeaFoeeSWKyW/K8mkzQoUkxqYbO
         JQyL6z0CoiPscENcshntqIFdN5Ylth4uS4XDn5jQNKVJXSTZ4RldgtC6tv8KbtFdcB03
         eO1NV76OCD0zC+pDQdbFotUwjL8AE4ZQvoPheC0gvmU70TslB0km0GmEesUK+IY2F0wM
         UIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=FJoGrt8Bj927BMsDJPB9LbioM+jxCnQhx4W3huaium0=;
        b=KDvfHNIcRSLdiaHQcSVVzAmDcVsNiHsdqkilIN0cdAnC4mM5xvs9mHJp1JWHz3DQJ4
         9LZhcmYxQ3Xn1HEIae/Zi4KabdfbwDxjqPR+KCBHy/Rb3+isLQi0eMb1h0q5Wg4UqKFa
         SGAjFrf8HghvmsuKJGyvYj/ZKh3upIYCydpjbaLNCadJiYsX8lIUkqBluTL3gxZyl9fu
         11y4wiclZRdt7bo0W3dQGKY+z4F0e+fpDlxCTjGHj6YYdqMIwZRLwqqmoe2eJbmVALMC
         GQHOI/JDHvoRMD6tNpdX4+jVI5AFxhYU7ZV6t1Yw4mXilDvJEpG4LIorWXeb+3FT27pc
         t0Hw==
X-Gm-Message-State: ALoCoQluD4S2rbV8dz65fZ3rnDZmq15ur+P5VQ03OCe6NNxf0BTwpSLewxAwFvsDEeeQ7lRO8ZK9
X-Received: by 10.43.82.72 with SMTP id ab8mr17582469icc.76.1417809298693;
 Fri, 05 Dec 2014 11:54:58 -0800 (PST)
Received: by 10.107.1.199 with HTTP; Fri, 5 Dec 2014 11:54:58 -0800 (PST)
In-Reply-To: <1417809221-27209-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260888>

On Fri, Dec 5, 2014 at 11:53 AM, Stefan Beller <sbeller@google.com> wrote:
> Instead of calculating, whether to put a plus or minus sign, offload
> the responsibilty to the fprintf function.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Ah! I forgot the --notes switch when sending out the email:

    Michael,

    please queue this on top of your reflog series.
    More to come.

    Thanks,
    Stefan




>  refs.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 40c5591..1147216 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3972,12 +3972,9 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
>                         printf("prune %s", message);
>         } else {
>                 if (cb->newlog) {
> -                       char sign = (tz < 0) ? '-' : '+';
> -                       int zone = (tz < 0) ? (-tz) : tz;
> -                       fprintf(cb->newlog, "%s %s %s %lu %c%04d\t%s",
> +                       fprintf(cb->newlog, "%s %s %s %lu %+05d\t%s",
>                                 sha1_to_hex(osha1), sha1_to_hex(nsha1),
> -                               email, timestamp, sign, zone,
> -                               message);
> +                               email, timestamp, tz, message);
>                         hashcpy(cb->last_kept_sha1, nsha1);
>                 }
>                 if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
> --
> 2.2.0
>
