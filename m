From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 00/94] libify apply and use lib in am
Date: Sat, 14 May 2016 21:37:43 +0200
Message-ID: <CAP8UFD0GrSy9E5Yv9Bdbd8SK+Q8GgYW2jDC-iopzsajpA6BKsw@mail.gmail.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<alpine.DEB.2.20.1605130820160.4092@virtualbox>
	<CAP8UFD2fSW0nds7myfb_09c+EaCdn6+1OqsNEzfY2rVTeA5TAw@mail.gmail.com>
	<alpine.DEB.2.20.1605140807310.4092@virtualbox>
	<CAP8UFD376guRRPpMVjC36K0dvWy17xdaHvV1WoRjMaNpdp0bqQ@mail.gmail.com>
	<xmqqwpmw7aow.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 14 21:37:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1fNm-0004oq-Iu
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 21:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbcENThq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2016 15:37:46 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34289 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810AbcENThp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2016 15:37:45 -0400
Received: by mail-wm0-f67.google.com with SMTP id n129so10113113wmn.1
        for <git@vger.kernel.org>; Sat, 14 May 2016 12:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=96FCq+12LfHqIXIFyluamJN0ObhENtrI+9CyalnMCiE=;
        b=jnFZD9GNfClE3ulf0u4J+BnWiwvxBB+CJvW0Lmq4hlZ2a42naJhwqMgf/u8jV54M9c
         tJa/1yrsL4qNCXVVrG4b1vzOdlUn5GDidXFYdpfiU06fYkuzwWFGh0YSKiIUHRanQKG+
         901GdJJn56VHqT07OLXmucLKvxTIji5lbZCORlB/0cd5TLJYQY53HT/6R+efamNoqqXx
         Sqdbq6AsmiGGWaWDN5KJPtJPgGIh/5PFWOs3apy2cFk3VVbXM5jmHslwe5cjtMnkh8h8
         /J0G0DHORMGoRS2XHnevRN71yTAY/nPXYRZTqd8s9cR4ge2A1sSrTI6UO17ozv+sjIzJ
         a11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=96FCq+12LfHqIXIFyluamJN0ObhENtrI+9CyalnMCiE=;
        b=Zi24Z1fbgFiXAhxb0Kqe0JZtnzByLPRJ8tILrq2wW2OVVYyIyUI+FTTw/n3F6O/rhA
         0V6R8zINCgVkPHhMyVcMoDNxBsss3PT9QYKeLbEimYH4TPcqzsUkBhAE59OEKMSKe3cE
         Ofy/WgQrJEXktZGnA4gfPZmWxhW6888XEDqKdZwHMpbo0pIupME1yLL2Fsny10H60NzO
         n6e8A6tTjBEEkdxYlHML3ZynoLZ+lhFNh/xRWVnyeoEF+FacW7yKLXvPd+DX3yXZ/QIO
         UAYxE3LxSk8dg2UnMCifw/kSdJPXaiiM+0hngIJMMwF80HJt6KhV+4vWWjMmnGNwO/if
         gdvQ==
X-Gm-Message-State: AOPr4FUgaTsSzcx2poZQereIJhQB6YVnXtSc45jqPXwVQvLxurqEO2NEH0oSDjmMk+v6R9XfDvF4UEz4pHb6HA==
X-Received: by 10.195.17.166 with SMTP id gf6mr21659644wjd.124.1463254664125;
 Sat, 14 May 2016 12:37:44 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Sat, 14 May 2016 12:37:43 -0700 (PDT)
In-Reply-To: <xmqqwpmw7aow.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294626>

On Sat, May 14, 2016 at 8:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I however do not see a reason why you need to expose that feature to
> the users of "git apply".  So I am not sure if any of us care deeply
> the choice among --silent, --quiet and -q -q.

About that I wrote in initial email above:

"The last patch 94/94 adds a --silent command line option to git apply.
This is not necessary, but some scripts could perhaps use it, and it
could make it easier to test the new silent feature."

I expose the feature in the last patch exactly because, if we don't
want to expose the feature, is is easy to do by just dropping the last
patch.
And I explain the reasons why it might be a good idea to expose the
feature, but I am also ok with just dropping the patch.
