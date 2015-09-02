From: Paul Tan <pyokagan@gmail.com>
Subject: Re: GSoC 2015 is over
Date: Wed, 2 Sep 2015 23:45:33 +0800
Message-ID: <CACRoPnTrvD2NFQopg2rJB_PSZv0tawRjiuVi8vK+YN0OyFh-sg@mail.gmail.com>
References: <vpq8u8qw047.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 02 17:45:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXAEF-0007hF-BD
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 17:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763AbbIBPpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 11:45:35 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:35843 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbbIBPpf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 11:45:35 -0400
Received: by lanb10 with SMTP id b10so9940918lan.3
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 08:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oQysj0od1ejeQBsI8FdCByewUrhXvOKe+O5ZH7VuMTw=;
        b=Ic2/Ks4KdFrsn3oK6ogQHVBZnSlUronq1Dyuem09Rt5mxNBW7JoeGuGBUDtc4vKjxl
         v+U7P5D9n/AeZpbUAcUJm5tMH/UkIBCziw+imHbyAdHx1G52Ntz9GkxyS+0O9vGiOdgM
         QyPdOlbld8js/PnQHhAu07QeaZMmBlXlJo2d+FFSkP4/xLQSZmHAytrZwC4iQmT8aPlp
         9ZSJ+BWoD1o33CJB884c1+HLu5GRnsyVfmQpJP6llIolfmUeclEu0uaHYr+/evX72497
         pi32O0v4aoFkdXVY35/GVE2gryrdBaU3lTcFM5vCOu4jNtuRTHshsQ0xj0iWIf7nbJxY
         Xwxg==
X-Received: by 10.112.199.133 with SMTP id jk5mr16985646lbc.32.1441208733750;
 Wed, 02 Sep 2015 08:45:33 -0700 (PDT)
Received: by 10.112.62.196 with HTTP; Wed, 2 Sep 2015 08:45:33 -0700 (PDT)
In-Reply-To: <vpq8u8qw047.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277098>

On Wed, Sep 2, 2015 at 12:55 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> I consider this GSoC as a great success and a pleasant experience.
> Congratulation to Paul and Karthik, and a warm "thank you" to everybody
> who contributed: administrators, mentors, reviewers, and obviously
> Junio! (not to mention Google, who made all this possible)
>
> Thanks all!

Thanks! The products of my project are not perfect (Jeff just fixed
another bug in the builtin am >< Thanks!), and there are still a few
leftover bits, but I hope that I've provided a good base of code for
working on.

Off the top of my head, the leftover bits are:

1. Stefan noticed that the help strings of git-am's options could be
more user-friendly:
http://thread.gmane.org/gmane.comp.version-control.git/272876/focus=273029

2. Johannes suggested that get_tracking_branch() in builtin/pull.c
could be implemented with remote_find_tracking():
http://thread.gmane.org/gmane.comp.version-control.git/269258/focus=269350

3. Junio noticed off-list that relative paths do not work with
git-fetch and git-pull

Other possible future developments:

1. git am --3way implemented on top of git apply --3way

2. builtin/mailinfo.c looks to me like a good candidate for moving
into libgit.a, so that git am can access its functionality without
spawning a separate process and writing temporary files.

On my part, I have to give a big thank you to Junio, as well as my
mentors Johannes and Stefan, for reviewing my patches. Their timely
review of my patches played a great part in getting my project into
master. Jeff, Eric and many others contributed by reporting bugs,
giving ideas and cleaning up my mess.

Above all, I would like to thank the organization admins as well as my
mentors for running the GSoC program. Thank you for this wonderful
opportunity. I've learned a lot, and had lots of fun.

I've really enjoyed my time with the Git community, and will stay
around for the foreseeable future.

Regards,
Paul
