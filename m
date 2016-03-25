From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: GSoC 2016 | Proposal | Incremental Rewrite of git bisect
Date: Fri, 25 Mar 2016 15:45:05 +0530
Message-ID: <CAFZEwPM=+U8gC0JRL1Zi6yJboenuSw6hBKJeLNzf_=NYQTCSGA@mail.gmail.com>
References: <CAFZEwPNXKo5YN9OPPCkO90bSPD3ittU+y8eDxh-JLxnihBznuw@mail.gmail.com>
	<CAP8UFD0muBUEp9XknmcTWqg==ChzWP3m-p-v6vXyC09OC88U7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 11:18:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajOox-0007da-Sb
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 11:18:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbcCYKPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 06:15:09 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34835 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbcCYKPI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 06:15:08 -0400
Received: by mail-yw0-f196.google.com with SMTP id u8so818479ywa.2
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 03:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=wzp3NvEvUm7dGjPaxWSKCprKQxeKHchTBr11tUxbXIE=;
        b=kaYgyBvk19MpVUYsq2M1u5DqkJOyFPmtNBwO9XSyM04tJlVMLUpg4SogoArGWWOSU2
         MkIte1wdLbInl1I6CG1LSuFniDo8i15fp/43GeoSI1D83teYOp4YbXd2S9Sl/x7Xr+Rw
         rQw8JMP+3XwYq8b0hekvgyizEQlhPOernHIt5RW71e5uvEnSwNzHHGgO6Av5mBsnZaWV
         VKC/Et7agFWw3yocrTQW0JeEkgE7WqGTGiiT4HD7fFk6aIyvnvy8VdPXaK9Q37hk4kgK
         72nVVou2qfsZIVUiTD+WCyDxXsboNbEXb341PaNJdukoGhw8Ya4EChbw0CW4fEoqxpxE
         xgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=wzp3NvEvUm7dGjPaxWSKCprKQxeKHchTBr11tUxbXIE=;
        b=En2Q86PNTtuaMqCy2ow3V6/pIc6DHirTCNhnzOMJGcY562f8PnaiagUt5czhkXjMED
         MfgvAfogO67jhqk0agJ8M3K9nq2IuMeDDvFkOwEfQapvoxEcp3K6M8TgciS0QedFU38U
         GSg5i3ZIexYaEYxNsm5bJE0eqFB5/2Vlg8djITQv7aR5XqfIPoVaFamS87PTd6BKJxpJ
         fOF8GfcKQXipUDApbwzQ5zUbsJBrBGu7GSLDMN9lKO+Ao1E/IKrpuS9Qv9U3bdhsbEin
         eDrrYTYToUKginuWzjEhx5IOvTLtxKEGYANy5sLD9GtsnE1ny/Q3uZiqOnheGVXara/Q
         U+/Q==
X-Gm-Message-State: AD7BkJI1oGvBONJxJm6av9nbVSTQX4aUwopU/aHSC9q9HM/k7qZ+njvh4LzrDTiJBLzWJ3XaS/cxW/w8ZUKdtA==
X-Received: by 10.13.252.67 with SMTP id m64mr7623341ywf.67.1458900906017;
 Fri, 25 Mar 2016 03:15:06 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Fri, 25 Mar 2016 03:15:05 -0700 (PDT)
In-Reply-To: <CAP8UFD0muBUEp9XknmcTWqg==ChzWP3m-p-v6vXyC09OC88U7w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289873>

> - you will add an option to "git bisect--helper" to perform what the
> git-bisect.sh function did, and
> - you will create a test script for "git bisect--helper" in which you
> will test each option?

I had very initially planned to do this. But Matthieu pointed out that
it would be much better to use the existing test suite rather than
creating one which can lead to less coverage.

Thanks,
Pranit Bauva
