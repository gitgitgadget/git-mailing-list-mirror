From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 4/3] use string_list initializer consistently
Date: Mon, 13 Jun 2016 18:31:29 +0700
Message-ID: <CACsJy8CoOJKLUQXPKx_KvHvwbUdOfyBKu_-v5F2U7ccrmCcewA@mail.gmail.com>
References: <20160610115726.4805-1-pclouds@gmail.com> <20160612220316.GB5428@sigill.intra.peff.net>
 <CACsJy8C+NtiXRo8NcU3rtgWrMSj8Zv3mYtdYfyvzwYRHifKVCQ@mail.gmail.com>
 <20160613053203.GB3950@sigill.intra.peff.net> <CACsJy8CAT54pTotUFKm-piWRppNFz9mjTsnz+5p1+7ykVg60HQ@mail.gmail.com>
 <20160613100420.GA16229@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 13 13:32:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCQ6S-0006bf-7C
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 13:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422913AbcFMLcD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 07:32:03 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:34475 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161227AbcFMLcA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 07:32:00 -0400
Received: by mail-io0-f181.google.com with SMTP id 5so117062482ioy.1
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 04:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SWRj0IWonL5P9AQFChL7SRPKyh9ItcJyb6dTKyKnMfg=;
        b=ov7/AAgVu6HJfHpyPoUXaZP/aFDfy6e4UBehN03hEXeobA/ufNrXjECvK/w+gc1mOJ
         O645YskcJUaltajVhywXQXrKlJtrbTaY5LRI2Q5fYwxoKrbTqaJw7wTuUDI2z6gJIfQe
         Ozs9CeUWpFjcuJhyRJPsxBg2KcfN4V7IEzkLCD4nzHeyAmHoJgrztbsl3rJUt2EEKaBc
         fkMeZEBQKls3DjQsGR7uPjjKS0u1rWLaeidcTEdr+Je53r4B2p6Ouau23UGlJ7p2l92z
         x/UHRo1GKVf7q1nqppMy90RfixX0iuPOzWNeYViHei1sGUiwOXnazqwM7u+wXluZjTgu
         PRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SWRj0IWonL5P9AQFChL7SRPKyh9ItcJyb6dTKyKnMfg=;
        b=GdeuN3arZaUtUgGOXDM/i+okwpGux9JJi+S7RqK2BZkKTgSUChLNxbQm4tYtJw5thh
         /Mv/Bq7WEn82twQBuvPl/o1bGrslTYpyAvoQOBoXoAAwXttk5KpDo7wNLo7L6MOvTqqa
         x3h7cY/z02oSLGi8oT2D4x6st4rQlAuDANr9Ld/i6KJZvj9d6WCNc5M3HOKnlbmbBrD2
         eEKL1iyGnCQdDnZLkjroqu6N9TmINcC/e2sD/pCFz6hcI0zFJtqc7igC29yTcgl8+t9U
         y3raaRSZMXTvehbKe/bVfZjq3XjhkybFuSveLCFjKxHHJ1t4OhgITFzSQHH2XTwG7gny
         hJHg==
X-Gm-Message-State: ALyK8tIcjB6kCA58cvscbjwJhK1lxTH4EWBbGFbR99EMAoutc/ZCjhKwcJsTIgRuMovmoKLMcaC4s6SxgS6nKQ==
X-Received: by 10.107.159.84 with SMTP id i81mr21034309ioe.29.1465817519346;
 Mon, 13 Jun 2016 04:31:59 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Mon, 13 Jun 2016 04:31:29 -0700 (PDT)
In-Reply-To: <20160613100420.GA16229@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297178>

On Mon, Jun 13, 2016 at 5:04 PM, Jeff King <peff@peff.net> wrote:
> -- >8 --
> Subject: use string_list initializer consistently
>
> There are two types of string_lists: those that own the
> string memory, and those that don't. You can tell the
> difference by the strdup_strings flag, and one should use
> either STRING_LIST_INIT_DUP, or STRING_LIST_INIT_NODUP as an
> initializer.
>
> Historically, the normal all-zeros initialization has
> corresponded to the NODUP case. Many sites use no
> initializer at all, and that works as a shorthand for that
> case. But for a reader of the code, it can be hard to
> remember which is which. Let's be more explicit and actually
> have each site declare which type it means to use.
>
> This is a fairly mechanical conversion; I assumed each site
> was correct as-is, and just switched them all to NODUP.

Looking good. If we still want to reduce noise level down (by a tiny
bit), we could remove _INIT because I think it's obvious from

struct string_list var = STRING_LIST_NODUP;

that's it's initialization (I wish we could write "auto var =
STRING_LIST_NODUP;")
-- 
Duy
