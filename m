From: =?UTF-8?B?5p2O5pys6LaF?= <libenchao@gmail.com>
Subject: Re: bug report
Date: Fri, 13 May 2016 14:57:25 +0800
Message-ID: <CABKuJ_SEK-t93sCmj6aFSAbk8muX_ocQx6ZQZV3ZrNmvVmvDQA@mail.gmail.com>
References: <CABKuJ_SN+Ynsi9-48-iKgC1n9ARZe3ZjQR9Y2q3=tYC=QGgfZQ@mail.gmail.com>
	<CAFZEwPNCEAU-sexn-dFr8dDg=_w02hLOhfQhKu_yRYtY3LeJHw@mail.gmail.com>
	<CABKuJ_QZHTRcPWbwv1FSXEijxOpXameo-JJuZREGyA5daLbKLQ@mail.gmail.com>
	<CAFZEwPP32vWrCA9H+JbFineodDtGx2_bTjGy-nZ9KW2v8bP5vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 08:57:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b172W-0005i8-0z
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 08:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbcEMG51 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 May 2016 02:57:27 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33494 "EHLO
	mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbcEMG50 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2016 02:57:26 -0400
Received: by mail-oi0-f67.google.com with SMTP id t140so2658914oie.0
        for <git@vger.kernel.org>; Thu, 12 May 2016 23:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=yQiFHTc2UIMk9qRnaFwEACTx7YL56RhkdG63S7/WRD8=;
        b=itrg/qk1wAaAdWZ0ES6ASEHYcFH8K1bZOyszXX/7pq2FzxZgRb46ArC4q0Q6qmfiMY
         gZxKex39YrSbupXNCCmCpmvXThbCtmh95OTDAaWabTiue+QfmFjSHKYquHQQgVnga8tK
         cYbI8Vaf7Lfp9rreYQVCAMx9s/wapLqQwAnxBpN5mEGyKgK+VZ3zRm13CYzQ5zkV0LJ+
         cqfXGpbWNA78MUWPazlADSClx8hKn3TG3SYg3fZnm4iCKCZdphsWxOL8d3BSu8vGTsMN
         BOH0RNo7M86iXuVwpDr30S8m4vhJZc4wvJCFK9H9qC9bKFGpDhi1F+OHYpWTs3cLw5Pl
         cftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=yQiFHTc2UIMk9qRnaFwEACTx7YL56RhkdG63S7/WRD8=;
        b=KezJ89BI4B+DxXZk6hfupBE8jDyYN/TtkwpFbDVAPXBAxxeTFnR+Ax10MtwGy+4SAA
         UXeArQIavFqK2XLNg/opkkCtOLfj1YR7wb/dFt+AtPbJkFXwgn0vRvZvZGwKVCMF3gco
         ORomfsFRN1D0YZ8yDi2YXvSZcm++vXj5AjVGlYyfo1R5dmoQSxc9aHXK8KB7boy8S5H3
         1T5Fg+Aokg82qnaY3G6OSqlxvHerP7py7pFudh6o/5CFtDiHfVy/eqP8BMI94NXgqqjC
         xiaYRfs75Jz/Q0c/8zdRTlHOW3EpwOmgUt1Ax/GLviZ4BeAZ9lo/9iyeQ1tgNRqe2W8A
         2Xbw==
X-Gm-Message-State: AOPr4FXsMsD4miP9Jm/vsN+FAeZlAzKBQWpMJ4kPxQ73MUDUwt4ePIXBK9CTGZLtisgaSQ/oFmvLnEcvBwS0xQ==
X-Received: by 10.202.71.134 with SMTP id u128mr8138124oia.189.1463122645883;
 Thu, 12 May 2016 23:57:25 -0700 (PDT)
Received: by 10.202.46.8 with HTTP; Thu, 12 May 2016 23:57:25 -0700 (PDT)
In-Reply-To: <CAFZEwPP32vWrCA9H+JbFineodDtGx2_bTjGy-nZ9KW2v8bP5vQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294511>

Yes, you got the right understanding of my problem.

You are right, the git behavior is quite correct. But I met this
problem in my practical work:

My colleague added a method but I didn't know. I also added the same me=
thod.
Then I found that I didn't need the method actually, so I deleted it.
My colleague merged to the master before me. When I wanted to merge, I =
found
conflicts with master. And I rebased to current master. And That method=
 was
deleted finally without any warning or information.

Do you think Git should output something to warn the user or I just
use Git in a wrong way ?

Thanks.

2016-05-13 14:37 GMT+08:00 Pranit Bauva <pranit.bauva@gmail.com>:
> On Fri, May 13, 2016 at 11:28 AM, =E6=9D=8E=E6=9C=AC=E8=B6=85 <libenc=
hao@gmail.com> wrote:
>> git version 2.6.4 (Apple Git-63)
>> system version: OS X EI Capitan 10.11.4
>>
>> below is the steps:
>> $ mkdir test_repo
>> $ cd test_repo
>> $ git init
>> $ echo "hello" > README.md
>> $ git commit -a -m 'Add README.md'
>
> It was my mistake. git-commit -a adds files which are tracked.
> Currently README.md is not tracked. So you will have to first use
> git-add to add them for tracking. Though while trying out your steps =
I
> used git-add. For further commits one can use -a with git-commit.
>
>> $ git checkout -b A
>> $ echo "world" > README.md
>> $ git commit -a -m 'Add one line'
>
> You are technically not adding a line. You are modifying the previous
> line to the updated line. So the contents of the file will be:
> "world"
> It seems from the further part that you actually wanted to add the
> line rather than modifying it. Better to use ">>" instead of ">". ">>=
"
> is used for appending.
>
>> $ git checkout master
>> $ git checkout -b B
>> $ echo "world" > README.md
>> $ git commit -a -m 'Add one line too'
>> $ [midify 'world' line to other things like 'git' using vi]
>
> I think you mean modify.
>
>> $ git commit -a -m 'Modify one line'
>>
>> $ git checkout master
>> $ git merge A
>>
>> $ git checkout B
>> $ git rebase master [problem is here, cat README.rd we will get :
>> hello and git instead of hello world git]
>
> The git behavior is quite correct.
> When you are on the B branch and you choose to rebase it on the
> master, it will apply commits as patches. So it first sees that the
> commit on the A branch which is now merged with master ie. "Add one
> line" and the commit on the B branch "Add one line too" are doing the
> same thing which is removing the line "hello" and adding the line
> "world". Then it applies the commit "modify one line" on top of this
> which removes the line "world" and adds the line "git". So finally,
> README.md will contain only "git".
>
> Regards,
> Pranit Bauva



--=20
Benchao Li
School of Electronics Engineering and Computer Science, Peking Universi=
ty
Tel:+86-15650713730
Email: libenchao@gmail.com; libenchao@pku.edu.cn
