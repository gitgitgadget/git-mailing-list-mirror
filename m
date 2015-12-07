From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/2] gitk spacing/sizing tuning for HiDPI
Date: Sun, 6 Dec 2015 23:09:02 -0500
Message-ID: <CAPig+cSwWxLMRh7e231svhtiJQH-5WuMO+3Y5x-e9tEOyHtqDg@mail.gmail.com>
References: <1449404723-27177-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Paul Mackerras <paulus@samba.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 05:09:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5n6r-00029A-1p
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 05:09:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755283AbbLGEJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2015 23:09:04 -0500
Received: from mail-vk0-f54.google.com ([209.85.213.54]:33339 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754774AbbLGEJD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2015 23:09:03 -0500
Received: by vkca188 with SMTP id a188so96290964vkc.0
        for <git@vger.kernel.org>; Sun, 06 Dec 2015 20:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=lVuylnQ9E9nfhcpCVYxCZ6IjQR7+HKGJYK/01t9Z7GA=;
        b=cbW234MXiUEwcwEv9vYvIU8PH1iJSotzFG9hTxyPJiALD4W9RFM9kPmy9VUY5p+3Dg
         K5IwwwRf95Pr6apKwOOgMerpP2TVxDo55LN3/lo/PjTdzArdlsbx/Os/dPSnKXKpKzQd
         tyx3LlgLIBIUbAqbVI9YjyN9tgZhgR6UAW7KsFMSdCqIzTgdiLIsy7i/BEZ8Yo+HxfLZ
         h3ENC8rlZ544thXeghuNVkh599TaW2ufv0SSsfPmxKGe0nBytTD0PQJ/Hncpq4yx0j4E
         fbuQL5x+SbVeeFXdaJ6Scallg/Pbaeq1VL3r0I16OnGjKJxg0J/k9zsiKrFVrBJQ56QU
         7Tcg==
X-Received: by 10.31.58.74 with SMTP id h71mr20240222vka.151.1449461342407;
 Sun, 06 Dec 2015 20:09:02 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 6 Dec 2015 20:09:02 -0800 (PST)
In-Reply-To: <1449404723-27177-1-git-send-email-giuseppe.bilotta@gmail.com>
X-Google-Sender-Auth: 1T_MbU1Y0-t_oS-0FPGG9YsVg1k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282076>

On Sun, Dec 6, 2015 at 7:25 AM, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
> On my HiDPI monitor, most elements in gitk are correctly rendered, with two
> exceptions:
>
> * when using ttk, some elements do not use the same fonts as gitk would use
>   without, and since ttk picks _unscaled_ sizes this is very noticeable (and
> borderline illegible); the first patch fixes this;
> * the spacing between the checkboxes on top of the diff window are a little too
>   tightly-spaced; the second patch adds a little bit of breathing space.

Both patches are missing your Signed-off-by:.
