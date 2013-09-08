From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/4] Re: [PATCH 3/4] t: rev-parse-parents: avoid yoda conditions
Date: Sun, 8 Sep 2013 18:18:14 -0500
Message-ID: <CAMP44s2cXnrR2WHtyFKgNxi7AtuS9dA9if1rqFaH2b_35YTfiw@mail.gmail.com>
References: <CAMP44s349-v6xtCvbDzycVj1wBwTdAgLmuGxB0pYn6CmHYkM1Q@mail.gmail.com>
	<20130903150855.GK29840@goldbirke>
	<20130903170419.GA29921@google.com>
	<xmqqli3co7ov.fsf@gitster.dls.corp.google.com>
	<20130904171356.GD2582@serenity.lan>
	<xmqq1u54o5c4.fsf@gitster.dls.corp.google.com>
	<20130904183559.GA3465@sigill.intra.peff.net>
	<CAMP44s3O=cHAtHOj41MccBDOausukb49MV-E6jib6n6czs+p3Q@mail.gmail.com>
	<20130908040615.GA14019@sigill.intra.peff.net>
	<CAMP44s16RZ9JguL=NPcD8TE-gdG7vGEa5KLHzv4bf_VLLEhPRw@mail.gmail.com>
	<20130908042649.GC14019@sigill.intra.peff.net>
	<xmqqvc2b5fkg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 01:18:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIoFI-000626-3u
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 01:18:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931Ab3IHXSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 19:18:16 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:40320 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806Ab3IHXSP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 19:18:15 -0400
Received: by mail-lb0-f177.google.com with SMTP id p5so4360514lbi.36
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 16:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=X0oMMvTqzKFR1R+n+JJ4FUG4I3hKib5nrY/OQb3u8QE=;
        b=P+cztMpjahRinyi8XrYoezLpaicQhDAyzWROBkUiWTgl7T4R8XXJ2AJUbwnFFjEEpr
         AL0/W2lXk+MPIiHUEzBL2UVzJBIsS+0zzAKtW8kVo9zWz6UdLeZyxxHfK/xn65YkqXsF
         cJwD4+J5ZpgKFXIU49rZJ8eVWjjch0ztb8gGSIjloBII9vLAOXUefMsUyXQcAele1dT5
         7R71iLB3OTLR32gw8eZbvnU7OWaiWfFMlNZNh0BIyNtYSQfMDZXy7rHVWafrhWsWqaL+
         lq3Ef1fzimC995RsbPynsO57C5W2G0cLuJpBuRTiDg030eub4H+jDXFxwPwW637AF4nU
         sb3w==
X-Received: by 10.112.0.242 with SMTP id 18mr13505327lbh.18.1378682294569;
 Sun, 08 Sep 2013 16:18:14 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sun, 8 Sep 2013 16:18:14 -0700 (PDT)
In-Reply-To: <xmqqvc2b5fkg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234282>

On Sun, Sep 8, 2013 at 1:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:

> Calling the abstraction "test_diff" might have avoided the wasted
> brain bandwidth in this thread, but I do not think renaming it in
> test-lib-functions.sh is worth the trouble, either ;-)

Yes, but then it wouldn't be clear what's the main purpose of
test_diff(). Primarily what we want is to check that they are the
same. The diff is secondary, and it's not actually *needed*.

-- 
Felipe Contreras
