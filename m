From: =?UTF-8?Q?erik_elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: Re: Git 2.8.1 fails test 32 of t7300-clean.sh, breaks profile build
Date: Tue, 3 May 2016 23:28:09 +0200
Message-ID: <CAMpP7NbeELYQvZ1A1acA-V6jZVRvNzjbAqD6zd2YoJvGT5Dxxw@mail.gmail.com>
References: <CAA6PgK7b=ithSYREV5axaE3fmRG5Vp06UtWiZXD-aJuZKfEVYA@mail.gmail.com>
	<CAA6PgK4of46eEJOJstnVvPvDFqU_OC5QVz9LWxyKgqHt9V5ySQ@mail.gmail.com>
	<CAGZ79kYy=+xz5k0pN+MZTRBALd-sqbQ0TePNjkx6itjQpbRUvA@mail.gmail.com>
	<CAA6PgK4M2Ag6anEFYakW9NJe0ehTtS1UEQmDWe387W_uV-MCXA@mail.gmail.com>
	<CAGZ79kav27h+_eswTd3hRWjYhH5aApVcERa1bSxKD8p2R50HTw@mail.gmail.com>
	<CAPc5daX4noqHaOZCrZ78s0ytFBkeU7znXs0QY1LXEw8w3RnQ1A@mail.gmail.com>
	<20160503184841.GA30530@sigill.intra.peff.net>
	<CAGZ79kYxSCsXGLBoBTAOLfe_pOu7YNBQoccs_fA0btEzpnU=-w@mail.gmail.com>
	<20160503190053.GC30530@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jan Keromnes <janx@linux.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 03 23:28:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axhrc-0004Q5-4t
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 23:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756505AbcECV2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 17:28:11 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33612 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756177AbcECV2K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 17:28:10 -0400
Received: by mail-qk0-f172.google.com with SMTP id n63so15497785qkf.0
        for <git@vger.kernel.org>; Tue, 03 May 2016 14:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=sZ2HrjFgSulWtsbz+XP0hdzrAPwMlcVM7WDEZ3STfeM=;
        b=irCqMbCxRCxLi2L5J9snUBksM6yPU3/qi6cYfFKGgucmwK2XtQWIq2tfqZ0BWtkwik
         OVtzvi9BajqMvm2GyTFEc0PJtmLj5nHY42/6mgDGVrosFPJXy6vfVSwh11I7qIp+b7zn
         xez+ehrYWBe+rachnnyoPiyHx+Kjdj2t/35r5gaFWJNwoig1wPMTLyRzFzxTo+Kzljlt
         i2qKl+jY03rehQPVaDpToswyYv5pF8uGdieTmc1yTfA8yNhG0x+KbWVvXnwaXIxQqgfr
         NR2H1MdgMpKGcv9taE9szZYxoNZ9fkLgsY+WRa0gUL0/64DMOnjwO4h0vIJBeTKHyJ94
         0qLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=sZ2HrjFgSulWtsbz+XP0hdzrAPwMlcVM7WDEZ3STfeM=;
        b=Zz0ZVABp63atA1oFlYTUGj/XYq7060gr+C5lmyDKiInb3ogqLLIcRJK+CYBdWm4Aj3
         50B7gCGec4xVjzV1vxUkaBYRE4CKxPX4QfCPu4f/DiLOZUda0TuPAC8rABeiocISYwC7
         Ufi4B3psabuXbOdvIzthz9q8iKes2LbBZEVOM0vyUoT3xNgesetHvgnCoeN/PeEzvCce
         rmK2ZvWnSrm2ZJlsbms3stsLODRtIehKuHvH7jYY6b/UNNHBHKYoL2npO4bOgHht28ol
         w46MbkGVLQcFgSC9bQiakyZEQhY3fHP+mLj3PBVO5jPmBuue+VcI/o+G6ySbl4KEeMWJ
         8iUQ==
X-Gm-Message-State: AOPr4FXJoVjer8uUn9runmdFAD5C+kteSIOp8sPyDVnvhiGEVwiiUZhw1QdfSD7Kd4HTLaQj/CQYUPv9Khqcew==
X-Received: by 10.55.215.85 with SMTP id m82mr5379020qki.154.1462310889483;
 Tue, 03 May 2016 14:28:09 -0700 (PDT)
Received: by 10.55.161.144 with HTTP; Tue, 3 May 2016 14:28:09 -0700 (PDT)
In-Reply-To: <20160503190053.GC30530@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293459>

Thanks for fixing the missing SANITY prerequisite Stefan.

As for the error handling logic in setup.c: is_nonbare_repository_dir
(was clean.c: is_git_repository) my reasoning is as follows:

READ_GITFILE_ERR_STAT_FAILED
READ_GITFILE_ERR_NOT_A_FILE:

When checking random paths for .git files these are the common error
modes, file is not there or it is a directory. This should not be
interpreted as a valid .git file.


READ_GITFILE_ERR_OPEN_FAILED
READ_GITFILE_ERR_READ_FAILED:

Here we found a .git file but could not open and read it to verify
that it is valid. Treating it as valid is the safest option for clean.
For resolve_gitlink_ref I think it maybe leads to the creation of a
redundant ref cache entries but I don't think this is a problem unless
someone has a huge amount of unreadable .git files lying around.


READ_GITFILE_ERR_TOO_LARGE:

File is absurdly large (1MB), very unlikely to be a valid .git file.


READ_GITFILE_ERR_INVALID_FORMAT
READ_GITFILE_ERR_NO_PATH:

File is malformed in some way, either the "gitdir:" prefix is missing
or the path is missing. Could theoretically be a corrupted .git file
but seems unlikely.


READ_GITFILE_ERR_NOT_A_REPO:

This is maybe a bit more suspicious. Here we have found a .git file,
it has the format "gitdir: some/path" but
is_git_directory("some/path") returned false, meaning that "some/path"
does not fulfill:

/*
 * Test if it looks like we're at a git directory.
 * We want to see:
 *
 *  - either an objects/ directory _or_ the proper
 *    GIT_OBJECT_DIRECTORY environment variable
 *  - a refs/ directory
 *  - either a HEAD symlink or a HEAD file that is formatted as
 *    a proper "ref:", or a regular file HEAD that has a properly
 *    formatted sha1 object name.
*/

Technically we don't have a valid .git file here but we have something
that really tries to be. I guess it is debatable what the correct
conservative choice is here and if it is the same for all callers.

/Erik
