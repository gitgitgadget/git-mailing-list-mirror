From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 4/4] builtin/am: passthrough -t and --trailer flags
Date: Thu, 7 Apr 2016 12:39:45 -0400
Message-ID: <CAP8UFD3+pTwD3qNv7A9Bcyprf523RDt9Hh05Pfsdj04aTCjPDw@mail.gmail.com>
References: <1460042563-32741-1-git-send-email-mst@redhat.com>
	<1460042563-32741-5-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 18:40:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoCyQ-00063W-6V
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 18:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756888AbcDGQjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 12:39:48 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35765 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756453AbcDGQjr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 12:39:47 -0400
Received: by mail-wm0-f46.google.com with SMTP id 191so97877221wmq.0
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 09:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=deB/tjMM5sFCQ+DNSSVlQkKsBV9W+Su3pPpBunYf2Ak=;
        b=cYF6/8gjN6Qu7iOyQ2jsnovSN2hfpolWXCaTc1qaHcSyxypwkpTL8nD+gyLCRR87Za
         gsTHTCp2YTHvMY/eQJHoXrGlnM8OzcBuP9SpGwN7EkBZG0wN15isENqOYkK0ylduTvLS
         UBsza9T1AjPrBdt6KgXXd0qGxVRPwUthVR7n1qwRqyETB/YkMusMkEzSSqicsJpv7DB4
         rubAsrX0zcsb9gztOjTp2ujZh6XkhSPvHWSP/lNLGvdJJ451RzKPvld0lDdhrdnMP9h8
         v1oboPVXpE5Tk3HZb0+eLNCXFwOKB1IaYJRdvwOJlRiVG3IBWRp2MltZC+efJezUjXvZ
         l9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=deB/tjMM5sFCQ+DNSSVlQkKsBV9W+Su3pPpBunYf2Ak=;
        b=YqwISvYwImkX2/GxJOhAGbFjnZE/L6KxSSsLAv4iTZ6GTJsAi2Fna0/etFehbOziBQ
         wcI8P9ZzTFGWlxBmo2Smdfj1onEDQOapRr30FpMcgEa/lXFWWzj2qbqzrv8SvwSgaXGT
         nCpS5+x+rbvfJy4jxHHnGEuw6NfD+nwAkz+JrD81QgZBVG8/Itus4Qg3EB5Gr75v32YP
         lxZ/n5NVSsPctk5YIpPxSuI9671t5ESLqE95jGmsfYVyQTCf1Ts8jdcOTRG8a1JL+ero
         yKiPpiAdAMapto9roqjwkQrZb26x+Mbnqoot7jo6eABDHZtFWIz2uMaUWTuFSF/a7jAb
         vhHA==
X-Gm-Message-State: AD7BkJLl1Mtngy+WYwD7Mi+SWvSaeYpjSs6aDglNsB1Jn0gin9e7cQk+9TuuFUH2LvK5+Fy6tAZ1GK669vjArA==
X-Received: by 10.194.21.102 with SMTP id u6mr4600195wje.124.1460047185348;
 Thu, 07 Apr 2016 09:39:45 -0700 (PDT)
Received: by 10.194.95.129 with HTTP; Thu, 7 Apr 2016 09:39:45 -0700 (PDT)
In-Reply-To: <1460042563-32741-5-git-send-email-mst@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290924>

On Thu, Apr 7, 2016 at 11:23 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> Pass -t and --trailer flags to git-reinterpret-trailers.

s/git-reinterpret-trailers/git-interpret-trailers/

Thanks,
Christian.
