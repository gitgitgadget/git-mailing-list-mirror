From: James Denholm <nod.helm@gmail.com>
Subject: Re: Recording the current branch on each commit?
Date: Tue, 29 Apr 2014 20:59:07 +1000
Message-ID: <752e9542-7450-4928-a9cb-79b9c3b69bcd@email.android.com>
References: <535C47BF.2070805@game-point.net> <CALKQrgfmBByMwMhxu3HkJqJGWy2Rwvij6Hi1_4npjfsxcSgpaQ@mail.gmail.com> <535D4085.4040707@game-point.net> <CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com> <535D6EB1.9080208@game-point.net> <535e18cdc7bce_338911e930c72@nysa.notmuch> <87bnvl6bdg.fsf@fencepost.gnu.org> <535e8e4253196_45651483310b3@nysa.notmuch> <152626b3-0642-4e26-9333-7d911d45c669@email.android.com> <535edfb9baa4a_4c5c11c92f0bc@nysa.notmuch> <CAHYYfeGBLXGgK-cTQLEreFXJakp1jBE829=LrhmKR3MttBiw+A@mail.gmail.com> <535f1d4d8cbbb_762310ef30c9c@nysa.notmuch> <220967ee-98a9-4731-88c0-43a9cba7220a@email.android.com> <535f62c1e740a_45e485b30887@nysa.notmuch> <87r44g33z4.fsf@fencepost.gnu.org> <535f702352d21_3aee3b2f0b9@nysa.notmuch> <87mwf431t3.fsf@fencepost.gnu.org> <535f
 76db38a34_6f23159b31099@nysa.notmuch> <87eh0g30it.fsf@fencepost.gnu.org> <535f7c35cb5b1_7c7c10e32f019@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jeremy Morton <admin@game-point.net>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>,
	David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 12:59:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf5l0-0007yV-DR
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 12:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933692AbaD2K7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 06:59:22 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:54016 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933674AbaD2K7W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 06:59:22 -0400
Received: by mail-pa0-f45.google.com with SMTP id kq14so30109pab.18
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 03:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=dFF+LTsz0jTGSCemLYpSIglAnWF/5eX5axUWRSpnfvg=;
        b=DkS3XZUAhUPC6kRdDb2yrQ7S2CQCKa8d0pGcRe/aqG5yQS6Zt2uquexjQ6dm5uzU8T
         r7Po3lTpTRVDeR+7mfcp+/4T2dc7+YIaYyjRy5Jm1PHztWnaJc1uo2IuWgfKOnMBodPf
         f5m5ZZDu+4lcm4L4RPQCzIup8lgnFeiivAKGODGGjVpyWikRwy/gjxFLAOPfW6lAIsb5
         tcEbLeywZgz1cS3HYmWTm1jNHOH3XmF4TDNHymAYfPhxa0xzD0OTI7XZAbOjYwfPJz06
         iljQ6lfyjNTTSyIYgSFA6VtDMNS36Wr4TEzpU6sFL/UrNvSxlcFQQ/H5xLnQL+a5/nVj
         uhgw==
X-Received: by 10.66.136.71 with SMTP id py7mr32508395pab.2.1398769160561;
        Tue, 29 Apr 2014 03:59:20 -0700 (PDT)
Received: from [10.86.17.135] ([101.119.29.242])
        by mx.google.com with ESMTPSA id qh2sm108300888pab.13.2014.04.29.03.59.15
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 29 Apr 2014 03:59:19 -0700 (PDT)
User-Agent: Kaiten Mail
In-Reply-To: <535f7c35cb5b1_7c7c10e32f019@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247565>

I've no right to say this, given that I've no contributions
thus far to the project, little history in open source at all,
and have only been following the list for less than a week,
but I'll say it anyway, mayhaps.

And I don't mean this to cause offence, or inspire outrage,
or any similar sort of thing. I mean this only with good
intentions.

But Felipe, if you honestly feel that git has stagnated, and
that your contributions aren't wanted because we'd
rather starve, then perhaps git isn't the right project for you.

I'm not saying that you shouldn't work on the git codebase,
you could very easily fork it and make the innovative SCMS
none of us can see, and kill git. Can be done, if hunting really
is the best choice as you say.
