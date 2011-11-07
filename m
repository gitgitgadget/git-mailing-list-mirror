From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] Introduce gc.autowarnonly config option
Date: Sun, 6 Nov 2011 19:18:01 -0500
Message-ID: <CAG+J_DzNsAP1xAswkNxTAN6ze8ZV5pFqDMeQXKkjCoQgPUgEQQ@mail.gmail.com>
References: <20111105140529.3A6CE9004A@inscatolati.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Fernando Vezzosi <buccia@repnz.net>
X-From: git-owner@vger.kernel.org Mon Nov 07 01:19:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNCvY-0006e6-6R
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 01:19:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754752Ab1KGASE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Nov 2011 19:18:04 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:58974 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754393Ab1KGASD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Nov 2011 19:18:03 -0500
Received: by ggnb2 with SMTP id b2so4664422ggn.19
        for <git@vger.kernel.org>; Sun, 06 Nov 2011 16:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=3wXOKpjI2K9qrZExuhFIiRMT8Gv0lbP/RqLI7wSUXFY=;
        b=sPQ0rSqp5DqKlA+4ZftVEDe2DOu70vA1VLgnC4Pne3CpPR+E6bs9EBNBp2U+nvYAlR
         7BmMigy3zLbKbyWTWwLLpWM5F9bcwW+6OHf9uiJPsWZQz3RNSrnFnQzNuiVw7jML3AeH
         g6rFBYKRed6pwx23kwZI4TpWVi0b52RrSAXjM=
Received: by 10.147.161.9 with SMTP id n9mr5464788yao.23.1320625081894; Sun,
 06 Nov 2011 16:18:01 -0800 (PST)
Received: by 10.147.125.14 with HTTP; Sun, 6 Nov 2011 16:18:01 -0800 (PST)
In-Reply-To: <20111105140529.3A6CE9004A@inscatolati.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184937>

On Sat, Nov 5, 2011 at 9:39 AM, Fernando Vezzosi <buccia@repnz.net> wro=
te:
> When `git gc --auto` would detect need for garbage collection to run,=
 it
> would just run. =C2=A0With this patch, enabling gc.autowarnonly will =
instead
> make it just emit a warning.
>
> Reviewed-by: Sverre Rabbelier <srabbelier@gmail.com>
> Signed-off-by: Fernando Vezzosi <buccia@repnz.net>

This is much better than the solution I've been living with the last
year, which was to put a pre-auto-gc in my templates directory of:

#!/bin/sh
echo "time to run git gc"
exit 1

So, thank you.

j.
