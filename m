From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] t6030: explicitly test for bisection cleanup
Date: Fri, 27 May 2016 21:00:17 +0200
Message-ID: <CAP8UFD0NfUZa_SH7Q9WizV0=5DbjGq58sOU2COe5NSPSSn=+-Q@mail.gmail.com>
References: <1463134469-26071-1-git-send-email-pranit.bauva@gmail.com>
	<CAFZEwPMyts8msEgdHOiPfC-_HEXp8SJ7-8FQScr-af=5tSxq7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>, chriscool@gmail.com
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 27 21:00:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6Mzg-0004rG-27
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 21:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755539AbcE0TAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 15:00:20 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35416 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754934AbcE0TAT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 15:00:19 -0400
Received: by mail-wm0-f46.google.com with SMTP id a136so4276550wme.0
        for <git@vger.kernel.org>; Fri, 27 May 2016 12:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=BgOptZpuPpVCEDFBmTJJoyeViL35YupYA6yp8yPeYz8=;
        b=Qr1rHQtJ2EA6R/0/z9DdFHsWV1Gu6x05Icmkc0ytX2TfXCpMslQVeRVq/1XJTciO8f
         Qg0Kt28lFZJ30b/By+bpPD1pGu3ZzKucTgzHW0MYUxmuO+xk9/My6D6KbTh0gnQCAPqJ
         Gpox3exfeqw1BKgEyrUSm9hgylIXn1vPACk1GN6r7+wF3mlnOIEzcK6Xihm1m/GVf43V
         zlUaW4dZ4mFwHtNCinO4UUy7C8Zt/fJdiokm8VZqvdlsIhtdsOfgHz8eOybJ4or7b7H+
         osCXX7BpVMEbsZBzsj0pLyFsUg7vGgrK6Ry9hBNdszJLtHH8hkUh/mrMOz0FXPaJDOSx
         lYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=BgOptZpuPpVCEDFBmTJJoyeViL35YupYA6yp8yPeYz8=;
        b=IBWiBSq6qjHBfqCkrsZVD9sNoSg7/7epl+4SXB4Ws7vKAuqvZlzMf05m/pru/hTFYI
         lLm2Z5xCIgalVhXuj+A8pfL8TcUZmqjJwJaPqIoGz68Zqv3gmmgAHBI2VoYbfTrh1LL7
         K3PRmFVznaEsfR+ibt3He9sBJLtmy5H9hF2dEE/AplgomB6FZxv9ghGj3AC+QLst33OV
         hHB81PYAwoQmCOIeEWkLQNkPIBr2XmJVATAIUZ3+0oIjFB+4hTGrWBhkvTFAHmWGNRsM
         iK2U7iQpiD8fA1Hehz0COD+qlXEAtu5zPpAreVwm+GGKYZLqltv3kSyPHolq+xb62VQM
         cW6Q==
X-Gm-Message-State: ALyK8tLW7jsp0vnaRrBy6HwjyVQaWOmykOFLDzHEhCmqsAVPAljl1Qs9VVbwowxPXtWbyPsMAX72oWkkcvdIcQ==
X-Received: by 10.28.94.194 with SMTP id s185mr164001wmb.62.1464375617784;
 Fri, 27 May 2016 12:00:17 -0700 (PDT)
Received: by 10.194.148.146 with HTTP; Fri, 27 May 2016 12:00:17 -0700 (PDT)
In-Reply-To: <CAFZEwPMyts8msEgdHOiPfC-_HEXp8SJ7-8FQScr-af=5tSxq7w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295786>

On Fri, May 27, 2016 at 7:57 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>
> Anyone any comments?

Maybe you could add this patch to, or squash it into, the patch that
convert bisect_clean_state to C.

Thanks,
Christian.
