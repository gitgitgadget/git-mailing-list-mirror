From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Sporadic test failures on OSX 10.10.3
Date: Mon, 22 Jun 2015 02:55:05 -0400
Message-ID: <CAPig+cRc7dbRxbKudcP5kfd11XK4=p73_4V3-_gMPRJEbRNL7Q@mail.gmail.com>
References: <20150620094758.GA22226@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Jun 22 08:55:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6vdP-0002tO-PH
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 08:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753756AbbFVGzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 02:55:08 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:35688 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786AbbFVGzF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 02:55:05 -0400
Received: by ykdy1 with SMTP id y1so17776513ykd.2
        for <git@vger.kernel.org>; Sun, 21 Jun 2015 23:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=GN0ZoZYvw7k3HVgLpGVVf4Ug6tlglApTP/s9N8SdPbA=;
        b=LcvflgRxLbfQ/VxmdroehxFx4vtcJmJ96FBadUxB0/PJJfEZr7IMJ8bF1CIRR144ot
         Uof3iNT/xQ90PMq0skMWtwEGNjtm9t7Ae6mpkiYOPZwOW7iRxmvM+fH0nv/yshsq/Wg5
         QZFkPYQjK8kuTMu/j+1zde6RQF2zQpKN+Ozy7fpTLhavBse8mVTWhvcIrHQzTp5zxwgU
         Cq4s0JdJdPNlvBuIbuvcsaHJCV8TxFfwCOtELwTsYGtTl3u4+54jCZAD7/kH1Ld+Ppa0
         9SVVLxpFXsVEXONtj2qixDsl/YSqhSjtKXs2ILjuE/T3kgiIVLlKbyFi9Du0BXssZBES
         2Acw==
X-Received: by 10.13.204.207 with SMTP id o198mr32938035ywd.163.1434956105230;
 Sun, 21 Jun 2015 23:55:05 -0700 (PDT)
Received: by 10.37.36.214 with HTTP; Sun, 21 Jun 2015 23:55:05 -0700 (PDT)
In-Reply-To: <20150620094758.GA22226@book.hvoigt.net>
X-Google-Sender-Auth: ks1QCiCu0QcEcjdgFqgQ2UVeMck
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272317>

On Sat, Jun 20, 2015 at 5:47 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> I am currently experiencing sporadic test failures on Mac OS X 10.10.3:
>
> Test Summary Report
> -------------------
> t7503-pre-commit-hook.sh                         (Wstat: 256 Tests: 11 Failed: 1)
>   Failed test:  9
>   Non-zero exit status: 1
> t7502-commit.sh                                  (Wstat: 256 Tests: 64 Failed: 1)
>   Failed test:  59
>   Non-zero exit status: 1
> t7407-submodule-foreach.sh                       (Wstat: 256 Tests: 17 Failed: 1)
>   Failed test:  14
>   Non-zero exit status: 1
> t7406-submodule-update.sh                        (Wstat: 256 Tests: 43 Failed: 2)
>   Failed tests:  36-37
>   Non-zero exit status: 1
> Files=702, Tests=12559, 618 wallclock secs ( 6.56 usr  2.08 sys + 716.50 cusr 932.03 csys = 1657.17 CPU)
> Result: FAIL
> make[1]: *** [prove] Error 1
> make: *** [test] Error 2
>
> When I execute the tests individually they succeed. Sometimes running the
> testsuite succeeds sometimes it does not. For example now running the
> testsuite the first and second time showed no failures. Only the third run
> revealed the above.
>
> Is anyone else experiencing this as well? I am seeing this on Junios
> master (f86f31ab33c3). The list of failed tests varies sometimes.

Confirmed.
