From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] t0008: 4 tests fail with ksh88
Date: Fri, 20 May 2016 23:01:48 +0200
Message-ID: <CAP8UFD3-B9SiBN479RQwjmtJsTns5Q2XUepdf9_NS0NVoQPGGw@mail.gmail.com>
References: <CALR6jEhviK9KZxR6R6xzkZ5EAO-RjWj3xYah_DOSDXhEjYsT-A@mail.gmail.com>
	<xmqq37pchi90.fsf@gitster.mtv.corp.google.com>
	<xmqqk2iog16g.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Armin Kunaschik <megabreit@googlemail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 20 23:01:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3rYR-0005Jp-7C
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 23:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbcETVBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 17:01:51 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33092 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961AbcETVBu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 17:01:50 -0400
Received: by mail-wm0-f67.google.com with SMTP id 67so48578wmg.0
        for <git@vger.kernel.org>; Fri, 20 May 2016 14:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=8s7aUnvgmu63nNtaEoYd30co7d1s3ZbSelSIPJAu66g=;
        b=r65xsclSGrzU23DgEaUv/ZHM6YfFuA9hbqVPyUBJqf8TEUqIQ8pwA0S8yb/tWHekEz
         z4/UU5V2Mag9s4HwKxlZ0yknmlPC1UZGGWxJI5hvEdf1b0Fxnr/dU4gBXcPxS9EAwCvs
         +63EOZiVyrLOKGhY7OkOKMeUF6+UBhMoj+Gao75dT4sKRH1NttAAcJD1P/Xp1lDNraC5
         laZYIhs9zNG5/5+bDMSCUEkWAkUG7iQE76vxD9u3mjdYOvcFkaJ+GXzlnMDcsyEtKraJ
         a6TPuQRzVT0CiIMvdFJ/LQTvbjf6yCUOQo9ECNJraf8dfS+/+Gkq66sGbvSWJ6Gkkz7x
         bxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=8s7aUnvgmu63nNtaEoYd30co7d1s3ZbSelSIPJAu66g=;
        b=lTizS4SocRYwtFwTADPNAUDeRk9UV8Prh5Y3mQaX7qELtrEXz1aGSAEMuUGD/ezEbl
         nJ8W02z/AHlSyAT0IvjW9OIqaJwHBJMIkxSiQMPmmkKeMwkqdirqUqN79Gpj+lMTmwXh
         000Koi2jfogQuFDaZ+Cu0Ua7Wm0NU+p7T0hW1MHjhqluKLjw1IGjb5+zcOagYYIG2yd6
         Y7N9bKYdaq9joWfVkb0greudt09qW91iuX+zECMkpV+pHiq9/9de66TeE4sxECuzZP8g
         2nU4PuO4MUhLL3unrh1PuHRM3pegFN6HSq1VMiiGmoTsZEwpai8Ti0mtRVlPtyrUA84/
         mvkw==
X-Gm-Message-State: AOPr4FW59nFDj0/jeiEtw5WYz07/6Zi3JC9brIhy1aSkQ7KOjfSZ+Y01hY9KSUYTFafY2TniSJWoQs7aKfloIQ==
X-Received: by 10.195.17.166 with SMTP id gf6mr5230459wjd.124.1463778108969;
 Fri, 20 May 2016 14:01:48 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Fri, 20 May 2016 14:01:48 -0700 (PDT)
In-Reply-To: <xmqqk2iog16g.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295210>

On Fri, May 20, 2016 at 6:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> From: Armin Kunaschik <megabreit@googlemail.com>
> Date: Fri, 20 May 2016 16:31:30 +0200
> Subject: [PATCH] t0008: 4 tests fail with ksh88
>
> In t0008, we have
>
>         cat <<-EOF
>         ...
>         a/b/.gitignore:8:!on*   "a/b/one\"three"
>         ...
>         EOF
>
> ane expect that the backslash-dq is passed through literally.

s/ane/and/

> ksh88 eats \ and generates a wrong expect data to compare with.
>
> Using \\" works this around without breaking other POSIX shells
> (which collapse backslash-backslash to a single backslash), and
> ksh88 does so, too.
