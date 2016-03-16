From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: Re: [GSOC] Microproject "Move ~/.git-credential-cache to ~/.config/git"
Date: Wed, 16 Mar 2016 18:45:42 +0800
Message-ID: <CAKqreuxn7upMwOQH54rdA9nv1wCLNSSPjrWH3xejHP-ib+Ynuw@mail.gmail.com>
References: <CAKqreux4aYhXTE9kUHKoKCJ2-4KDWyi58ioCm-CWqXhUYCtEEw@mail.gmail.com>
	<xmqqshztawwd.fsf@gitster.mtv.corp.google.com>
	<CAKqreuwgxzVTAUdZPf9+ivXCdW8F2Ksafw7V0pbLAaRPwGX9Uw@mail.gmail.com>
	<xmqqwpp494vd.fsf@gitster.mtv.corp.google.com>
	<CAKqreuw0hafi-GwWD-UaGKwmG8xVK6ZJDcw2jpQXAAuK+XBZvQ@mail.gmail.com>
	<20160315031259.GA20508@sigill.intra.peff.net>
	<CAKqreuwv+RRziS-NcaLYZYUN0_KrfgZSe6wp0wGBza4q3_x8RA@mail.gmail.com>
	<20160315192154.GA30693@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 16 11:45:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ag8xa-0003aK-41
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 11:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966054AbcCPKpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 06:45:45 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:36124 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932085AbcCPKpo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 06:45:44 -0400
Received: by mail-ob0-f176.google.com with SMTP id m7so46401731obh.3
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 03:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=6XF1Vi5pGveY/S3ipFR1+HISU9KomNI1oD89iJC/0xg=;
        b=lygde+X5nq1icJ1yCaHPUmxy3PiffIJeP0Qj9VhDLhPp/ic8yWtX9Jirf1R0Khyn/W
         FiH4YzRHfv4az7ZxsgM3Lf8CXbIR87SAzd6sjQBKtJZioUbQuzolsj1fQIq69VIc5kxT
         CyIkjU6y7/1Yv0cOcR0yCy5cgenYk5d0bqm1JE86wHjhrNjOaRkNTpoZNAlZAhroXLHD
         CZtokTw3d4mGM448DRA6q1tWnIPAGJKWaBhbKxtWVEWBP4Pjm1p74vkV8VTwGBe0Qjft
         N8OSrPW0uJz+OJynXp5YMUOyKO+cGjCVQQ+I3DceJD2UaTW8UrGNITlqTUUY/PenHFvU
         zHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=6XF1Vi5pGveY/S3ipFR1+HISU9KomNI1oD89iJC/0xg=;
        b=N1hsLFrF13t9snJOj7uc3kHLs6Sd+PucA3VUDc+A5cr9HtVC0AibJiTFqV5oFVxW6v
         U60jA8oqF+zAK0QKg8jmhH1YvImJexRl1wE8B+QIYwA8uT34Jo/yeoQxeLMLSGvgsRK2
         BDibkq4szCCkdAW5F8FY8UM0QNr7dqWgJn/twE+eHiBRJJFGW2S9hiFIUdwv0KNcSmKN
         gzIx1z0wEeYNgiZVsHiB/015T9D2HIjH4WV0zaStzuTBllX/fWM9j+19LQrVLveC+j/6
         pdhc63IFSbwmeXL9VXGM1T8S0WHuKYjC+xHoxG+wKpf/vxSi51PQFq0ou/MO3WulJLLZ
         O/lQ==
X-Gm-Message-State: AD7BkJKne6jyCM8wIlsCxVv8QD8zn5hToLMpsM0HblgB9bVDYWc8iUDFBtTSqG2iKqSUQw8++UGYJ/xHCGA1UQ==
X-Received: by 10.60.150.163 with SMTP id uj3mr1748299oeb.67.1458125142813;
 Wed, 16 Mar 2016 03:45:42 -0700 (PDT)
Received: by 10.157.43.68 with HTTP; Wed, 16 Mar 2016 03:45:42 -0700 (PDT)
In-Reply-To: <20160315192154.GA30693@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288955>

2016-03-16 3:21 GMT+08:00 Jeff King <peff@peff.net>:
> I don't think so. I suppose one could have a script that tests for the
> existence of the socket or something.

I agree, that is what I meant by "third-party tools".

But for user who write script like that, it's easy to figure out the problem
and either update his/her scripts or explicitly declare the path of the socket
in his gitconfig.

Anyway, most users will not be affected.

> But then, I don't think "use the
> old directory if it exists" really solves that. Such a script would work
> on people who had already run the old version of credential-cache, and
> break on new ones.

If back-compatibility must be ensured, the only graceful solution I can
image is a new option entry like `xdg-style-path` being added to gitconfig
and default it to false.

I doubt whether the increasing complexity is worthy just for the
back-compatibilty
of a socket path.
