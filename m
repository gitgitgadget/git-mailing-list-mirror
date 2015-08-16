From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v11 00/13] port tag.c to use ref-filter APIs
Date: Sun, 16 Aug 2015 00:38:59 -0700
Message-ID: <CA+P7+xpWFT=NJC2VdnamjA86LcYRc4z__La91ca_yGdtFPHahw@mail.gmail.com>
References: <1439661643-16094-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 16 09:39:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQsXM-00088S-3z
	for gcvg-git-2@plane.gmane.org; Sun, 16 Aug 2015 09:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbbHPHjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2015 03:39:19 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:37187 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbbHPHjT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2015 03:39:19 -0400
Received: by igui7 with SMTP id i7so36411688igu.0
        for <git@vger.kernel.org>; Sun, 16 Aug 2015 00:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=unzvduxMMykALS3rZf+WJ64glVPu2cnDRPEt22EMZRY=;
        b=ryP+eC7AKV7vKeJ9bBbsIIfADQgWroNkC6RNkNo22m7/zcyejLuZcy373jjOl3QWrJ
         LTxAbT7s49HFH/78hDT9HZUlgLS+/hCl1KhFE0794VYPFHp55hgU4PS3n175zydldpRf
         pSULHF3DOe784a/ysfMj41qRrxvktrUYqUICAFnLyMi9PxAf4I0XvWFqG8sYWzHIvnVH
         TWi7bNOHJdeRBzlAUE7U/X3C5SBWy+/05jp1wSDChn+20ha403fKZLN2QHFCmAdebKYz
         u3mNQKrmU91Um7JryksX2ZRYzmhQQgmvx2pw6aDa3pKJ8D8yKSQmgaQRyshM0wOoU+2K
         fqKQ==
X-Received: by 10.50.72.113 with SMTP id c17mr10288864igv.73.1439710758529;
 Sun, 16 Aug 2015 00:39:18 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Sun, 16 Aug 2015 00:38:59 -0700 (PDT)
In-Reply-To: <1439661643-16094-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276014>

On Sat, Aug 15, 2015 at 11:00 AM, Karthik Nayak <karthik.188@gmail.com> wrote:

>
>  align::
> -       Implement an `align` atom which left-, middle-, or
> -       right-aligns the content between %(align:..)  and
> -       %(end). Followed by `:<position>,<width>`, where the
> +       left-, middle-, or right-align the content between %(align:..)
> +       and %(end). Followed by `:<position>,<width>`, where the


Everywhere else in the code seems to now put position second now, but
the documentation here doesn't say this is allowed or required.

Regards,
Jake

>         `<position>` is either left, right or middle and `<width>` is
>         the total length of the content with alignment. If the
>         contents length is more than the width then no alignment is
> -       performed. Currently nested alignment is not supported.
> +       performed.
>
