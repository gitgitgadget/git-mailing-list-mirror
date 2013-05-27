From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH] credential-osxkeychain: support more protocols
Date: Mon, 27 May 2013 10:28:40 -0400
Message-ID: <CAEBDL5XMamYoZFgFWeRr3KTZWZATKp=prFus_44UEMV8LEEtzw@mail.gmail.com>
References: <1369641431-44504-1-git-send-email-quanxunzhen@gmail.com>
	<CAEBDL5W4sLB0R1ZOspb-yQzmyTCE7Y1HeC2KZ69F8R28fJY7_A@mail.gmail.com>
	<CAMdq6987TAj7f03mABkqu9v4wicarrZLYQypNUiOrP0fsLc4mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Xidorn Quan <quanxunzhen@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 27 16:28:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgyPl-0008Da-Vl
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 16:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758117Ab3E0O2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 10:28:41 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:51163 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758054Ab3E0O2l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 10:28:41 -0400
Received: by mail-wi0-f178.google.com with SMTP id hj6so1630792wib.11
        for <git@vger.kernel.org>; Mon, 27 May 2013 07:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=t3+KXYv8OYf50ywy56OtLQZCuz1hkYLsrIjiZ91EQDQ=;
        b=g+7EA+RJ2IE+jSEmAjKX/4+buJglUixLW/8iwm9qJfNZsTrf8RQthDYSL79lcJC/pn
         Zgfm7RBQlI1NcxGLvMwi4j5vH9WgM5K0Ccgk6TTAk4+mX1QHpydaHrmuLaYoLu+tGpyt
         PRYEAaeZgUt4428zdHeHx3gcMJCmzlt8g5TWZ9LHc7Fh8whZh4TGKVCGT8qY+/0hp5Yt
         +zLrxv59m/kDuAyfV+mfQTRFjUO5HrurbF6hqTk4G9lVHd5QEU7K0As5MtaqNZpgO0nL
         lZ54o2cDdON3fRdMa2rLt6CqSPPT4ZurguRzjdM6R428E745U5sg5fAew6fGT5WfWwfE
         8Rhg==
X-Received: by 10.194.158.102 with SMTP id wt6mr9097977wjb.5.1369664920063;
 Mon, 27 May 2013 07:28:40 -0700 (PDT)
Received: by 10.180.5.33 with HTTP; Mon, 27 May 2013 07:28:40 -0700 (PDT)
In-Reply-To: <CAMdq6987TAj7f03mABkqu9v4wicarrZLYQypNUiOrP0fsLc4mQ@mail.gmail.com>
X-Google-Sender-Auth: ruWi3vcY_6QwGL9A9scG--1ecUk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225593>

On Mon, May 27, 2013 at 9:55 AM, Xidorn Quan <quanxunzhen@gmail.com> wrote:
[snip]
> I thought that SSH password logins can benefit from it, but I just
> found that it is wrong because it seems that SSH client is responsible
> for authenticating. Consequently, supporting SSH here is useless.
> I will remove that lines and send this patch again.
>
> Since it is the first time I submit a patch to git, I am not very
> familiar with the convention here. Should I send the modified patch
> to the maintainer directly? And what information should I append to
> my patch before it can get merged?

You'll need to read Documentation/SubmittingPatches (here's a link to
a version online:
https://github.com/git/git/blob/master/Documentation/SubmittingPatches).

You should resend this patch with the fix and change "[PATCH]" to
"[PATCH v2]", so the folks involved know that this is the second
iteration.  You also need to include a "Signed-off-by" line in your
patch, which means you agree to the agreement set forth in the
"Developer's Certificate of Origin" (which is in the SubmittingPatches
documentation).  You can easily include this line when you make the
commit by using the `-s` option on `git commit`.

You can also add an "Acked-by" line for me (since I reviewed and
approve of the change):

    Acked-by: John Szakmeister <john@szakmeister.net>

HTH!

-John
