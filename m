From: =?UTF-8?B?5p2O5pys6LaF?= <libenchao@gmail.com>
Subject: Re: bug report
Date: Fri, 13 May 2016 13:58:43 +0800
Message-ID: <CABKuJ_QZHTRcPWbwv1FSXEijxOpXameo-JJuZREGyA5daLbKLQ@mail.gmail.com>
References: <CABKuJ_SN+Ynsi9-48-iKgC1n9ARZe3ZjQR9Y2q3=tYC=QGgfZQ@mail.gmail.com>
	<CAFZEwPNCEAU-sexn-dFr8dDg=_w02hLOhfQhKu_yRYtY3LeJHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 07:58:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b167d-0005oJ-OL
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 07:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbcEMF6p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 May 2016 01:58:45 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34178 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbcEMF6o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2016 01:58:44 -0400
Received: by mail-oi0-f65.google.com with SMTP id d139so15598838oig.1
        for <git@vger.kernel.org>; Thu, 12 May 2016 22:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=sGCbrSHaQibf/bxOzfTd2W6a60DEUg4YzYtffyxBxsI=;
        b=ibqfTv+SGsgPlGA65qbsYaiuFYJVHHNR8eEqAUkhM+xTwVZv3+bxuYyWeQjUsFOmh0
         iOKla7DhMwMGR9AX2ULdaxtx8kzOApTIRKp0l74G/XHSikYN3HXYnNdSe80dC4pAPPgw
         nRbzNi20Witri7D+Vh/qxn24o+asJvFE63EuuWHtp2gzQWmAktQCxGDiYKlQ3CwpxnX5
         uFVy1xvawvay2KaA0vZmbWDZyXNQg4wHA7Mn0TxgcoghaUM8mFk1m2HEh7hiPxji51uY
         ACSRR3ca3058kUT028ObF6iiUFeo63kQ+BMGRyR1XNkUXUY5rddoDFH55DB69LgzzIrN
         0n/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=sGCbrSHaQibf/bxOzfTd2W6a60DEUg4YzYtffyxBxsI=;
        b=NHp6ispMYJHfNFNdwDOr3uw1OXOlbf31A/0mAzwKcHRUdgM2hGJ3+eFyRLEXS8/FcU
         jGXRLscBTgA4xeEqV8fS2kOFt9vUPhG9eQZFEYzTXAEFZgiofCoaoCIV9W/rcuArGd45
         WYNaXrGO+Me/PInwBabTZeDZj4tSvMPoLl4IG6wo83cFVEY9cqIMv7vMZb+Bq9zBjuAU
         ea4Z/mBAjktKK5q//5KysWEpZBSApI6NosWC3vRSJLM8QrHBtAk7HOD2EOUqDvSVT7JG
         XWq10ndic3zha8hvN5vUNA7XsMBRhEO2iEfn20aS+ue/VDgq+6MJTPDJdVgkwmRjJrgE
         IjjQ==
X-Gm-Message-State: AOPr4FVD6T6jPl2dw5ineHzo1SoFgRl/R9qpIGdKH9+IrLLCs4/68wKIYyWlWgBvQKkWhAA7ZiWnosds64GuMg==
X-Received: by 10.202.104.133 with SMTP id o5mr7824812oik.148.1463119123828;
 Thu, 12 May 2016 22:58:43 -0700 (PDT)
Received: by 10.202.46.8 with HTTP; Thu, 12 May 2016 22:58:43 -0700 (PDT)
In-Reply-To: <CAFZEwPNCEAU-sexn-dFr8dDg=_w02hLOhfQhKu_yRYtY3LeJHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294505>

git version 2.6.4 (Apple Git-63)
system version: OS X EI Capitan 10.11.4

below is the steps:
$ mkdir test_repo
$ cd test_repo
$ git init
$ echo "hello" > README.md
$ git commit -a -m 'Add README.md'

$ git checkout -b A
$ echo "world" > README.md
$ git commit -a -m 'Add one line'

$ git checkout master
$ git checkout -b B
$ echo "world" > README.md
$ git commit -a -m 'Add one line too'
$ [midify 'world' line to other things like 'git' using vi]
$ git commit -a -m 'Modify one line'

$ git checkout master
$ git merge A

$ git checkout B
$ git rebase master [problem is here, cat README.rd we will get :
hello and git instead of hello world git]

2016-05-13 13:23 GMT+08:00 Pranit Bauva <pranit.bauva@gmail.com>:
> Please mention the version no of git you are using and your system.
> I am answering according to git 2.8.1 Lubuntu 15.04
>
> On Fri, May 13, 2016 at 10:34 AM, =E6=9D=8E=E6=9C=AC=E8=B6=85 <libenc=
hao@gmail.com> wrote:
>> Hi all,
>>
>>       Yestoday when I worked using Git, I found a bug. It's about
>> rebase. Or I don't know if it is a bug, maybe that is Git. Below is =
my
>> problem:
>>
>>       There is a master branch, and we develop in our own branch.
>> Let's simplify this: there are two branches created at the same comm=
it
>> point at master. Then branch A add a function X. Branch B add funcit=
on
>> X too (yes, they are very same). Then branch B modify function X to
>> function Y.
>
> What do you mean by this? Did you amend the previous commit, or
> introduced another separate commit ?
>
>>       Branch A finishes it's job first and merged to master
>> successfully and happily without any conflicts. When branch B wants =
to
>> merge to master, he finds that master has updated. So branch B must
>> rebase to the current master. Then problem happends: git rebase
>> successfully without any conflicts. But branch B cannot see function=
 X
>> from master (or branch A), only its own function Y.
>>       I think that's because Git is based on file instead of patch.
>> But I think Git can report it in this situation.
>>       How do you think ? Thank you anyway for maintaining this amazi=
ng software.
>
> Well I tried to reproduce the problem. I did the following steps:
> $ mdkir test_repo
> $ cd test_repo
> $ git init
> $ echo Hello >hi
> $ git commit -a -m "C1"
> $ git checkout -b A
> $ echo Bye >hi
> $ git commit -a -m "C2 - A"
> $ git checkout -
> $ git checkout -b B
> $ echo "Bye." >hi
> $ git commit -a -m "C3 - B"
> $ git checkout -
> $ git merge A
> $ git checkout B
> $ git rebase master
>
> This shows that some merge conflicts needs resolving. Did I follow
> your steps or I missed something? It would be better if you could
> reproduce your steps like I did so as to make things more clear to us=
=2E
>
> Regards,
> Pranit Bauva



--=20
Benchao Li
School of Electronics Engineering and Computer Science, Peking Universi=
ty
Tel:+86-15650713730
Email: libenchao@gmail.com; libenchao@pku.edu.cn
