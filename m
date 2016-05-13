From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: bug report
Date: Fri, 13 May 2016 12:07:57 +0530
Message-ID: <CAFZEwPP32vWrCA9H+JbFineodDtGx2_bTjGy-nZ9KW2v8bP5vQ@mail.gmail.com>
References: <CABKuJ_SN+Ynsi9-48-iKgC1n9ARZe3ZjQR9Y2q3=tYC=QGgfZQ@mail.gmail.com>
	<CAFZEwPNCEAU-sexn-dFr8dDg=_w02hLOhfQhKu_yRYtY3LeJHw@mail.gmail.com>
	<CABKuJ_QZHTRcPWbwv1FSXEijxOpXameo-JJuZREGyA5daLbKLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?5p2O5pys6LaF?= <libenchao@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 08:38:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b16jb-0003S1-PT
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 08:38:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbcEMGh7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 May 2016 02:37:59 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:36395 "EHLO
	mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961AbcEMGh6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2016 02:37:58 -0400
Received: by mail-yw0-f170.google.com with SMTP id o66so106733174ywc.3
        for <git@vger.kernel.org>; Thu, 12 May 2016 23:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=Lk8bPM7WRVUd88k93eTG79l1PTEtMXmOw1HZGICNP3w=;
        b=YN1ZvLOJ53DJdgPYaxU8GsFxXThEtqczidqIpR8FW5dGjAC6ll/kuZl2D2c6SZpAdh
         vhmj71Z6+VorxAIuwP6Q5spswPd0w+Nl9uOubtIjIEPBAdIWBbNxSCz+Ypc0O3ACSPhZ
         CzScHGeLFJjTi1qGDDpS7RUzVrLUn3iRmfQY3Wn9PhVsugL3Y0an/hxkjhCH8/xxYtPo
         JBpqo5QvVUpaugLC19Ya7o4khHsZ68v6iJdo+5v4hLd2igBTg2TndRvFXfReEINc1DwI
         KEM4yWuzQfRvxXnekd4bXsz53dWufc3X0CEGdKK8FNSM21TLbeEpdF/gtmr7eudgVPuU
         zfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=Lk8bPM7WRVUd88k93eTG79l1PTEtMXmOw1HZGICNP3w=;
        b=bsuIK+pEcxAP65PA6qm9Mcccxv3jHZFqvnyf70zfp5JtHumzcDCv3huknF0vmV5jIL
         1APPn81cirSzJbxnKi7YrE5AJGbfVrg+3859JwZBePZR6osVQlW/kmHjPEZbR+Yqd5Em
         2yYtXPfzBrdVR7nj1V0FvZHvdlo8sB+LEaKPJ8pmcqQ22oRgw9VebS7PoptAETW/AMju
         YxxQO51RwOFnMsMGUbG6/THZcMQgG3Qzs25RCLW+QidId/V3Ro8n25FJpqtftOz7qZgv
         iyiDvBDAbbidKEGrjXQBhyqZxpzvDIWIrWVJ2rYI1k62CDvHIs5uZA7P3pRBIL3pR4oF
         R0Qg==
X-Gm-Message-State: AOPr4FXJFgTT9uS31NX6o3w+Jd7RVFJpsjn7KWb+Gbz+3m3duGorsFO+Aywl/Z+HDsmfU8FA1j3zPETZm40lVA==
X-Received: by 10.37.56.71 with SMTP id f68mr6527093yba.21.1463121477270; Thu,
 12 May 2016 23:37:57 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Thu, 12 May 2016 23:37:57 -0700 (PDT)
In-Reply-To: <CABKuJ_QZHTRcPWbwv1FSXEijxOpXameo-JJuZREGyA5daLbKLQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294509>

On Fri, May 13, 2016 at 11:28 AM, =E6=9D=8E=E6=9C=AC=E8=B6=85 <libencha=
o@gmail.com> wrote:
> git version 2.6.4 (Apple Git-63)
> system version: OS X EI Capitan 10.11.4
>
> below is the steps:
> $ mkdir test_repo
> $ cd test_repo
> $ git init
> $ echo "hello" > README.md
> $ git commit -a -m 'Add README.md'

It was my mistake. git-commit -a adds files which are tracked.
Currently README.md is not tracked. So you will have to first use
git-add to add them for tracking. Though while trying out your steps I
used git-add. For further commits one can use -a with git-commit.

> $ git checkout -b A
> $ echo "world" > README.md
> $ git commit -a -m 'Add one line'

You are technically not adding a line. You are modifying the previous
line to the updated line. So the contents of the file will be:
"world"
It seems from the further part that you actually wanted to add the
line rather than modifying it. Better to use ">>" instead of ">". ">>"
is used for appending.

> $ git checkout master
> $ git checkout -b B
> $ echo "world" > README.md
> $ git commit -a -m 'Add one line too'
> $ [midify 'world' line to other things like 'git' using vi]

I think you mean modify.

> $ git commit -a -m 'Modify one line'
>
> $ git checkout master
> $ git merge A
>
> $ git checkout B
> $ git rebase master [problem is here, cat README.rd we will get :
> hello and git instead of hello world git]

The git behavior is quite correct.
When you are on the B branch and you choose to rebase it on the
master, it will apply commits as patches. So it first sees that the
commit on the A branch which is now merged with master ie. "Add one
line" and the commit on the B branch "Add one line too" are doing the
same thing which is removing the line "hello" and adding the line
"world". Then it applies the commit "modify one line" on top of this
which removes the line "world" and adds the line "git". So finally,
README.md will contain only "git".

Regards,
Pranit Bauva
