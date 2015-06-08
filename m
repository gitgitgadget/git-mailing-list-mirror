From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 02/13] remove_branches(): remove temporary
Date: Mon, 8 Jun 2015 09:45:34 -0700
Message-ID: <CAGZ79kaW-jT5x2SNLjL6xtY=Qe_U86G6+nh8y2sP9Sv=CHc5Kg@mail.gmail.com>
References: <cover.1433763494.git.mhagger@alum.mit.edu>
	<77713838b598b95c5973a1fe73569635f5f31ee9.1433763494.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 08 18:45:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z20BA-0002UG-NZ
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 18:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391AbbFHQpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 12:45:36 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:35683 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300AbbFHQpf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 12:45:35 -0400
Received: by yken206 with SMTP id n206so54699949yke.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 09:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/Sk1VWjEISKU5IpIJmu/pZx2yQ8a2rhAYR6MhL8qE2M=;
        b=jXzzdYPCXHCE2A0z5uVUCoqcCkF8RcRZc9sXw2UAYtTeeeyKgeEGgh7pLUjcwo576t
         dXI8lLyZcumgPhUKBNzoDAkjr1qepd+caV8gvNQnE22hdnag84R6TCzFf5I+dqTUwL5U
         QcX4xfaxk2E9fIS4XIjoeIGYflBJe8kqFnk+ulYHVyLIBipfZB6dF9CJYjUV8/ZhSoez
         AMgouhEa4E6JvXexiLELXB69Tm28qg9zO7P5MepK0XbyR1JHpXRtfjbf4/SBk6g9RyLW
         8D7qAv5KqvgYKwETTWpLLC8gI4fv2UPduRkuu32I+zP8OuXZu7Y7aIyOXfiyAbahEM+1
         rF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=/Sk1VWjEISKU5IpIJmu/pZx2yQ8a2rhAYR6MhL8qE2M=;
        b=FKqfqyBjnebrJHuCkRp5SjNeoPNp2IlDZ0xchzs740ArqEbD3ZYGTNjrjFWA0yuXeW
         AjIFU60krUhT2Ib+oONy+Xa4BNdTxIFdIPV+yQMhNyQhT6EwNn4nMhvF5L99x2xlvlft
         pHXX7vhclTpKDHAbShpDPsGmfaJIaYAuvPVLvyTVEPCnMTINEO7GVhLLWsNCL9owIawY
         wF250nwFDpAbFVZA8EN1P6e8ZqfH/d9IzMe/aG5SeGqs/9rRaZ/dX5yqZhKAowoJhAwY
         lg+R5NhNhadi69mmt9ctPdzM/Niln0JFeWUk5IFjWWry23+64opssbEqCOmmbFQm0J+X
         jAcQ==
X-Gm-Message-State: ALoCoQl+PIaPbYQlA7myh2GZ4BZ4jpXus0SqYp5a33soichqRSk5VcLR8N8N4PolHNSrzFdipA3c
X-Received: by 10.129.98.132 with SMTP id w126mr16846524ywb.32.1433781934365;
 Mon, 08 Jun 2015 09:45:34 -0700 (PDT)
Received: by 10.37.101.197 with HTTP; Mon, 8 Jun 2015 09:45:34 -0700 (PDT)
In-Reply-To: <77713838b598b95c5973a1fe73569635f5f31ee9.1433763494.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271072>

On Mon, Jun 8, 2015 at 4:45 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

Found-to-be-Obviously-Correct-by: Stefan Beller <sbeller@google.com> ;)
> ---
>  builtin/remote.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index f4a6ec9..53b8e13 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -756,8 +756,7 @@ static int remove_branches(struct string_list *branches)
>         strbuf_release(&err);
>
>         for (i = 0; i < branches->nr; i++) {
> -               struct string_list_item *item = branches->items + i;
> -               const char *refname = item->string;
> +               const char *refname = branches->items[i].string;
>
>                 if (delete_ref(refname, NULL, 0))
>                         result |= error(_("Could not remove branch %s"), refname);
> --
> 2.1.4
>
