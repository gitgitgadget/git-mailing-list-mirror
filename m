From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v12 5/5] commit: add a commit.verbose config variable
Date: Mon, 4 Apr 2016 19:29:50 -0400
Message-ID: <CAPig+cQdAbweFF7NWJhNjALXN5cdpE-gtvZ_LB0tVmLJ2XGLiA@mail.gmail.com>
References: <01020153d952bd99-d3812bd6-d189-4780-ab48-f015696e9cf0-000000@eu-west-1.amazonses.com>
	<01020153d952be81-1859e6e4-81e4-473f-a2fa-7e27305b4e3e-000000@eu-west-1.amazonses.com>
	<CAPig+cTYHFyDXJ2ZECtje2OG-ObT04gnQw+0+LbMMVO51bx2fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 01:30:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anDwl-0002bm-8i
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 01:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571AbcDDX3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 19:29:54 -0400
Received: from mail-ig0-f194.google.com ([209.85.213.194]:33155 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932567AbcDDX3v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 19:29:51 -0400
Received: by mail-ig0-f194.google.com with SMTP id nt3so19625582igb.0
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 16:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=u8hyb/xunDgujlnCSwkCTfMqaM9EINGyJ5L44gCZ0s4=;
        b=w/GDPuUeXxJ0oGCST/PyU+ZbbQegxxiQanidHKpsRDtfuXHZurnQr/2Cn3x0WwMGng
         iV3A/g0bj6AChelSRM+AexQYm0r8GYWJrI7B3RLxQK2G6qXbHMAa79oF/owSVrmavm52
         e8vVy4xbiLIr6JBdyiytpSzLCNcPJ3YyH+EQCICmbyYkBsP8kpdNwomSZNkQtez9BSz1
         QCe9hmOr0BVjmJlJQUt2UPw6eyPnxSbgRI4TVdVeDzX2T2MjgfubE16rc6QpayyW+ol7
         ZVvx+mZXb7gKgJcXcFJubxVzf3XKQBLuGizZ5hD36lDUQRvqtOkk5x/XPSJRi5xt9BDF
         eXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=u8hyb/xunDgujlnCSwkCTfMqaM9EINGyJ5L44gCZ0s4=;
        b=Mb+om5TBPpoTgmh5mVq9FzzVWR+Bx2rn8q57XX4FtbcFDCC5bRJXBYHk1Jr2Ok3vqq
         zZzyz6oBA/V4d2K2RxD00MhuHzsGjTVeQPi4YUWgK3IjcV4KoUoTkHKll4nhbIPesyfi
         3W1+sPygDfNc1z3qM0xo8d4HgyQhs1MJ+e2igzpdR6fZ8e+G8U4tK8WMhEFEPkXizp3e
         a+Khel2g34VDmNUouULmtrVLvSpsS52g+R+a7quEoO6UiLo3CzsTqgLykJg0k5DFIqlx
         T1lg4Oa8Tfv3V52ZLWURyrwBqRYMTQ0nrQ9ILMVbKVqiunjw5TJum7lnwkg3ANzHZ7Xm
         WOXg==
X-Gm-Message-State: AD7BkJKGMweJK4GCBH1bz/gyBRmFJFMvRwLk3Fnez3A1JUeGr7AgPXzjBYLj4pt6vEJtEju044DaZ6HUYPh5Ow==
X-Received: by 10.50.40.101 with SMTP id w5mr13769430igk.17.1459812590394;
 Mon, 04 Apr 2016 16:29:50 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Mon, 4 Apr 2016 16:29:50 -0700 (PDT)
In-Reply-To: <CAPig+cTYHFyDXJ2ZECtje2OG-ObT04gnQw+0+LbMMVO51bx2fg@mail.gmail.com>
X-Google-Sender-Auth: krEGiJhpKkhP-96APihU7ZqSAdA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290738>

On Sun, Apr 3, 2016 at 8:58 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> The fact that the 32 new tests are nearly identical suggests strongly
> that the testing should instead either be table-driven or be done via
> for-loops to systematically cover all cases. Not only would either of
> these approaches be easier to digest, but they would make it easy to
> tell at a glance if any cases were missing. See [2] for an example of
> how the tests can be table-driven, and see the bottom of [3] for an
> example of using for-loops to test systematically (though you'd need
> to use nested for-loops rather than just the one in the example).
>
> I'm leaning toward systematic testing via nested for-loops as the more
> suitable of the two approach for this particular application.

By the way, while this would be a nice change, it doesn't necessarily
have to be part of this series, and could be done as a follow-up by
you or someone else.

(The other changes suggested in the same review, however, ought to be
fixed in this series; in particular, simplifying the "setup" test and
making the first test after "setup" consistent with the remaining
tests.)
