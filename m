From: yun sheng <uewing@gmail.com>
Subject: Fwd: Found a "bug" in git 1.9.0 but can't reproduce it without
 copyrighted source code.
Date: Fri, 28 Mar 2014 09:40:41 +0800
Message-ID: <CA+fYBFedYBPHLgO1mf31CuqKjWN0wbFj+Rmxq2Nm23HE0z8t_Q@mail.gmail.com>
References: <CA+fYBFdzC-_B2Qfk8Hg0pLUNy4oayySs+8B3vWq7uuBeAx9eJQ@mail.gmail.com>
	<5334CA94.7070708@gmail.com>
	<CA+fYBFdsp4z5T42wEiQ-0X88eK4UhJLx+Ofum_RYEf-g8a3SbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 28 02:40:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTLmz-0006rG-CS
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 02:40:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757170AbaC1Bkv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Mar 2014 21:40:51 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:33178 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757076AbaC1Bkm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2014 21:40:42 -0400
Received: by mail-pb0-f52.google.com with SMTP id rr13so4305855pbb.11
        for <git@vger.kernel.org>; Thu, 27 Mar 2014 18:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=rKRlBozfFS2KgT1iYrnw/i4XGTlHhIldRVo4Cj0Duhk=;
        b=aiQNwHepfQRD8VIyMGEkJUK4fOX7wP6dTXlufK8D3e06GhcDhNDIblDCy9sHyNK2Td
         tQIiGcL9sgN31V+Sc03CPdcokUc8P+DkKGGxSOBwkqAa0yXHbbI0N5NfjesLly72ypj0
         kyLP40gfb4k+zXWLmlGC3SxU3CpDCUcKtDZN1hU3M3PUHldEvuu2QKO8d+qKcAGWtjRt
         IAUWaorzwtWENVbjomSIJV+xedEFvhr8cZXH2Pq846CJiP+wqfKcghK8n9Z0YYiOFuny
         rBlw5h9sC7S+d91Af4G3yMpvCbwqx65PQOMzAaUkN+BATnWy/H7oUFHxlF4j2WE2nSEw
         1tPA==
X-Received: by 10.66.142.233 with SMTP id rz9mr5299902pab.71.1395970841938;
 Thu, 27 Mar 2014 18:40:41 -0700 (PDT)
Received: by 10.70.128.208 with HTTP; Thu, 27 Mar 2014 18:40:41 -0700 (PDT)
In-Reply-To: <CA+fYBFdsp4z5T42wEiQ-0X88eK4UhJLx+Ofum_RYEf-g8a3SbA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245347>

---------- Forwarded message ----------
=46rom: yun sheng <uewing@gmail.com>
Date: Fri, Mar 28, 2014 at 9:28 AM
Subject: Re: Found a "bug" in git 1.9.0 but can't reproduce it without
copyrighted source code.
To: Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n <vnwildman@gmail.com>


The result of sha1sum is different. Following is my console log


C:\shengy\tmp\shengyun\git-test>git init
Initialized empty Git repository in C:/shengy/tmp/shengyun/git-test/.gi=
t/

C:\shengy\tmp\shengyun\git-test>copy
C:\shengy\Dropbox\tmp\git-issue\old\epmdstyp.h
        1 file(s) copied.

C:\shengy\tmp\shengyun\git-test>git add .

C:\shengy\tmp\shengyun\git-test>git commit -m 'init'
[master (root-commit) 579385e] 'init'
 1 file changed, 97 insertions(+)
 create mode 100644 epmdstyp.h

C:\shengy\tmp\shengyun\git-test>sha1sum epmdstyp.h
c2310fe32891dc7269298814475d0ad083c5483c *epmdstyp.h

C:\shengy\tmp\shengyun\git-test>copy
C:\shengy\Dropbox\tmp\git-issue\new\epmdstyp.h
Overwrite C:\shengy\tmp\shengyun\git-test\epmdstyp.h? (Yes/No/All): Y
        1 file(s) copied.

C:\shengy\tmp\shengyun\git-test>sha1sum epmdstyp.h
7a98d5161b5e5ae201997b40fa5d5cebe1d14d1c *epmdstyp.h

C:\shengy\tmp\shengyun\git-test>git status
On branch master
nothing to commit, working directory clean

C:\shengy\tmp\shengyun\git-test>

On Fri, Mar 28, 2014 at 9:04 AM, Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n <v=
nwildman@gmail.com> wrote:
> On 28/03/2014 07:45, yun sheng wrote:
>> Hi,
>>
>> I found git sometimes can't detect working trees changes. But I can
>> only reproduce this problem on several specific files, unfortunately
>> these files are copyrighted source files so I can't send them to you=
=2E
>> Is there anything I can do to narrow the problem and finally reprodu=
ce
>> the bug without these commercial files?
>>
>> I posted a question on stackoverflow which shows the process.
>>
>> http://stackoverflow.com/questions/22684163/cant-reproduce-a-bug-in-=
git-without-a-specific-file
>>
>> Actually what I'm doing is:
>>
>> git init
>> " copy the first version of file into the working tree.
>> git add .
>> git commit -m 'init'
>> " copy and replace the file into working tree.
>> git status
>>
>> and nothing is reported by git.
>>
>> these two files have the same timestamp, the same size, bug slightly
>> different contents. These files were generated by `git difftool -d` =
I
>> just manually copied them out from the temp directory just for futur=
e
>> review.
> Don't worry about copyright, please run sha1sum in order to make sure
> the content is changed!
>>
>> Git I'm using is msysgit 1.9.0 on windows 7
> Is it Ok on Linux OS, on other git version?
>>
>> Best regards,
>> Sheng Yun
>> --
>>
>
> --
> Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n.
>
