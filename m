From: Guilherme <guibufolo@gmail.com>
Subject: Re: Copyright on wildmatch.c
Date: Tue, 24 Feb 2015 13:54:43 +0100
Message-ID: <CAMDzUtyWF6oRV7-h45P8x=tWOK2kwdg2ELhR+ugjZLWTbF_feQ@mail.gmail.com>
References: <CAMDzUtyitrK__iE9ykfTuP+Ooq0FwMPp_NVgBfBGbSV52+OPoQ@mail.gmail.com>
 <CAMDzUtymj21ckMrA87q1TATeWuH6kS_TBrsJ_jVjfeH50CaniA@mail.gmail.com>
 <CACsJy8Do77QSKSERPE26bKJ0gANB0XmPVBLwb1QKAW4qe0ouAQ@mail.gmail.com>
 <CAMDzUtz_BhW_tuQLy+AiNY7hz_HXCmHOtUNDgMBc=Taeon_Dwg@mail.gmail.com>
 <CACsJy8APLtweaf-q8+nCzJC-8J_vNZp-Y=AtNkX4NPuYr1jb=Q@mail.gmail.com>
 <CAMDzUtxf0gF=JDgEk9EU3W2VWuP-Qy8-Kz-fTx_Y16UeFRGiYA@mail.gmail.com>
 <CAMDzUtw8ySWwHvx4G+0R=L5JpxKqeFFNQ8Rb6bo5FRGwArzJcA@mail.gmail.com> <CAMDzUtzPxrtwdJN7cRmaMC_Sezmr9zSge=K_pc1OztEA8FVc=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: n.oxyde@gmail.com
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 24 13:56:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQF1v-0000rv-2d
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 13:56:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716AbbBXMz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 07:55:29 -0500
Received: from mail-we0-f169.google.com ([74.125.82.169]:32889 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646AbbBXMzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 07:55:25 -0500
Received: by wevk48 with SMTP id k48so25010328wev.0
        for <git@vger.kernel.org>; Tue, 24 Feb 2015 04:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=deAjVNi1NHXAfmq1zd74yA1TUR+Xh+pCG05k57qBd9s=;
        b=BYX0DT4rWPpcl0k6htn+sBNdTwzg2M2wiPRD9NiVb/H+hryRzoFhtmEQvhJPcXUHb7
         UiEGcHdarD5BwAC/u7xDEHMTAX9vhT/i4xCQis9d4fIM/YjBfEbFcmlJ/amD8OFmxyN4
         LEos17lv18OjR8L3KtyHEGjT8x0hPj+Vq8MCN644ZbJw8VgWu1/Q2SDFlWuWxk9LUljy
         5hmmtW7qmAZnnUi2JwppkRZYMa/4tqpE/89cXwoLtWAkeXH9B7Yz65XVdFMsPz27JiOe
         v94ZAJgNLHZj9zxen3CgtEtDIrm2NBxBFSqefQU5hQwHgIjVB0xbGPYR+4Tp1Yqt0VpT
         6RgQ==
X-Received: by 10.195.13.104 with SMTP id ex8mr31887607wjd.12.1424782523884;
 Tue, 24 Feb 2015 04:55:23 -0800 (PST)
Received: by 10.27.95.230 with HTTP; Tue, 24 Feb 2015 04:54:43 -0800 (PST)
In-Reply-To: <CAMDzUtzPxrtwdJN7cRmaMC_Sezmr9zSge=K_pc1OztEA8FVc=g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264327>

This is CC to Anthony Ramine.

On Tue, Feb 24, 2015 at 1:34 PM, Guilherme <guibufolo@gmail.com> wrote:
> This is just an email to all the people i have written in private
> about relicensing the files in need in TSS so they can reply to this
> email and it be recorded in the mailing list.
>
> The files are part of ctypes.c hex.c git-compat-util.h.
>
> On Tue, Feb 24, 2015 at 1:22 PM, Guilherme <guibufolo@gmail.com> wrote:
>> Hello,
>>
>> I'm writing to you in regards to the files ctypes.c
>> which you have modified part of in the git project.
>>
>> I'm currently working on integrating gitignore pattern matching into
>> the_sivler_searcher(http://github.com/ggreer/the_silver_searcher). PR
>> https://github.com/ggreer/the_silver_searcher/pull/614
>>
>> For that i needed wildmatch.c and it's dependencies. That is parts of
>> ctypes.c lines 8 to 31.
>>
>> Unfortunately TSS is Apache licensed wheras git is GPL, those licenses
>> are incompatible and thus i ask if you agree that your portion if the
>> code is also licensed under Apache2 for the use in TSS.
>>
>> You can follow the discussion under
>> http://article.gmane.org/gmane.comp.version-control.git/264312
>>
>> Thank you very much,
>> Bufolo
