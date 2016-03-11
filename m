From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v4] commit: add a commit.verbose config variable
Date: Fri, 11 Mar 2016 13:30:32 +0530
Message-ID: <CAFZEwPPbF30fr97WdZdbHwrF-b2VGkYiyTr3dDfdOAXd2SGFkQ@mail.gmail.com>
References: <0102015362963f6a-626ad27e-e705-4a75-93a6-55a5f75d0226-000000@eu-west-1.amazonses.com>
	<CAPig+cT+dmD2Nxw7z+x0Q2z_aJQFMwRwnb=dn1uH-_Nt9tnk4Q@mail.gmail.com>
	<CAFZEwPMznAUBhgJgZ7aRvtH1W8hDYLci6khbw9EsWS9WGhSh=Q@mail.gmail.com>
	<20160311054412.GA10841@flurp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Roberto Tyley <robertotyley@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 09:00:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeI07-0001g6-1q
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 09:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934558AbcCKIAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 03:00:37 -0500
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35478 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934516AbcCKIAd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 03:00:33 -0500
Received: by mail-yw0-f196.google.com with SMTP id s188so5704641ywe.2
        for <git@vger.kernel.org>; Fri, 11 Mar 2016 00:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=hq5uCRoWumT40mOdqA9OIxhryrdvD15t+oeyYANzo9Q=;
        b=k8FN2Hn0D/3GP6oOposKFx3KeAi0KLdgfhU66PBpaK6h9gfuZyHcBWYUv8JbuqMuHG
         XMrmdYz0GGh+G83Tv2lIkj056RoX8Ps6B0mSAP+JDtqsO1vm8XCB6z8bSOIEeERNhH3K
         AF74V2DnMLPhyqIuGmktKos+L5OnyWXnJZluH3dn1Byaim56MloAaHChE+W9Lg4El5S6
         mfb75p3tUxVmxp8KZyDY0OGpHfTeApF+QutRUTSQuWQeC80M1Z4DZZ/jfH3tWxJR8aIP
         /VPdWIKhkExH7TCDzZPlRu2valM/OmIvVyKGRtjZ/WrWpKgLSfekYo3wt8Woa20qbjyf
         USKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=hq5uCRoWumT40mOdqA9OIxhryrdvD15t+oeyYANzo9Q=;
        b=D8ZlEVH6WpGAa+atAwRQ4Rq718Ja1i0IMt16daVJCdVLNiaSOOl6DaIupgYlQjTDhF
         w0qfLR1WKt8LD9x70Q6WlOQKfmYtZkzZMWO9zC/5n1u6Xvppblvm3ttuyM2vsJsy2JyQ
         rLTrEovQYt8XoN+TSCKK/EWpZ553A4jeez8na/HgzL7ID3RuPteXkdhjhVqxMtzMQ650
         4JcdWb/NikDy795ow2tlPpFEBMhYTdymVws9hwO3jqhLSh0MrB0s3YGKLKU01K94fFSa
         aKbVJu8S4zMrRyYOarOE9HPF8+GAzzGVxtMX+xN9t6S+C8YLyGrWJveohuybw4lQTYzR
         dskw==
X-Gm-Message-State: AD7BkJKlboH2gCAM1+ZqbArLiVi6IgEfrkoBFeyTDoBVZ5IAl9KSqLAQUtn0Cd2cnwm40+NPSlVqdWbSCZv83w==
X-Received: by 10.129.94.7 with SMTP id s7mr4553736ywb.93.1457683232811; Fri,
 11 Mar 2016 00:00:32 -0800 (PST)
Received: by 10.13.203.137 with HTTP; Fri, 11 Mar 2016 00:00:32 -0800 (PST)
In-Reply-To: <20160311054412.GA10841@flurp.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288676>

On Fri, Mar 11, 2016 at 11:14 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:

> It's a bit tricky if you're not used to it, but check-for-diff
> actually does what you want, and does so in a more direct way. While
> it's true that it's not an "editor" per se, it does get access to the
> entire block of text that would normally appear in your editor during
> an interactive commit. And, this is happening before the commit has
> been written to history. So, check-for-diff gets a chance to look at
> the full text that would appear in your editor, and can therefore
> check if it contains the expected "diff --git" string.

Yes, this was new to me. Thanks for explaining it in an elaborate
manner. It took me some time to actually understand the behavior of
check-for-diff (a tricky one). And it does the task pretty nicely!

> 'test_i18ngrep' is intended for strings which may be translated,
> however, since the expected "diff --git" string should never be
> translated, check-for-diff's use of 'grep' is correct, whereas
> 'test_i18ngrep' would be misleading (if not actively wrong).

I should have read the docs before using this method and not just
blindly using it. I will definitely take care of that next time.

> As an experiment, I rewrote the four new tests in terms of
> check-for-diff (with "test_set_editor check-for-diff" already in
> effect). Here's what they look like, and they function as expected:
>
>     test_expect_success 'commit.verbose true and --verbose omitted' '
>         git -c commit.verbose=true commit --amend
>     '
>
>     test_expect_success 'commit.verbose true and --no-verbose' '
>         test_must_fail git -c commit.verbose=true commit --amend --no-verbose
>     '
>
>     test_expect_success 'commit.verbose false and --verbose' '
>         git -c commit.verbose=false commit --amend --verbose
>     '
>
>     test_expect_success 'commit.verbose false and --verbose omitted' '
>         test_must_fail git -c commit.verbose=false commit --amend
>     '
>
> These are modeled after the "initial commit shows verbose diff" test
> earlier in the script.

Thanks a lot for helping me with the tests. I will add the status
tests and then resend the patch. This was a nice exercise!
