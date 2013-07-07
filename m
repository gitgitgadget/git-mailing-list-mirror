From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH] prompt: do not double-discriminate detached HEAD
Date: Sun, 7 Jul 2013 09:35:29 -0400
Message-ID: <CAEBDL5UfHpR3GNeqbDf9X3Ya+Spcpx0Byq5MZPMMsE=a3y2jhg@mail.gmail.com>
References: <1373201565-14030-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	"Eduardo R. D'Avila" <erdavila@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 07 15:38:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvp82-0007Z9-6C
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 15:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792Ab3GGNfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 09:35:31 -0400
Received: from mail-we0-f175.google.com ([74.125.82.175]:52255 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759Ab3GGNfb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 09:35:31 -0400
Received: by mail-we0-f175.google.com with SMTP id t59so3050231wes.34
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 06:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=hgY2MNx0k6RXo3cQR006LksUplvQvRSr5Dy9iF6hsw4=;
        b=iXIjPXv2WOMCzzAAQJizPY/cYFYHf1px9OkWH7VWYCErcugujaY7LVRuSz2F9tt0VF
         hzmojFdYY9oxJ5K2eZQhqXBXBubtnDO38XNZAaxtAboQ0LX/G0o01fCZy4DkUxOLNQxB
         I2auEG51Qau5NTm91O4pAXPmu6NWjXy5teCObNN8Oc/v1V89D5KwOlfRFhnjAq4G8xrj
         JPZ7RNIoJeljs1jwPnr5s3XCBbs0OB00cXxiE1YP0e7yh0thZi52yqF4AQ4KMcpgwix0
         WRPZfWucha/+O5WJozXAgkoY9aChBK8ULtzuIfXxrgyKFimAl0O0MsuagNI12BOAVe1f
         HRMA==
X-Received: by 10.180.21.209 with SMTP id x17mr9437794wie.47.1373204129802;
 Sun, 07 Jul 2013 06:35:29 -0700 (PDT)
Received: by 10.180.160.200 with HTTP; Sun, 7 Jul 2013 06:35:29 -0700 (PDT)
In-Reply-To: <1373201565-14030-1-git-send-email-artagnon@gmail.com>
X-Google-Sender-Auth: T23m2lKVpQxFzWXsVIFuCuFwHlI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229775>

On Sun, Jul 7, 2013 at 8:52 AM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> When GIT_PS1_SHOWCOLORHINTS is turned on, there is no need to put a
> detached HEAD within parenthesis: the color can be used to discriminate
> the detached HEAD.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  For cuteness :)

Personally, I'd rather see the parens kept.  Not everyone sees red
very well--I know several people who can't see it at all, and it keeps
it consistent with non-colored output.

-John
