From: Guilherme <guibufolo@gmail.com>
Subject: Re: Copyright on wildmatch.c
Date: Tue, 24 Feb 2015 13:17:26 +0100
Message-ID: <CAMDzUtxf0gF=JDgEk9EU3W2VWuP-Qy8-Kz-fTx_Y16UeFRGiYA@mail.gmail.com>
References: <CAMDzUtyitrK__iE9ykfTuP+Ooq0FwMPp_NVgBfBGbSV52+OPoQ@mail.gmail.com>
 <CAMDzUtymj21ckMrA87q1TATeWuH6kS_TBrsJ_jVjfeH50CaniA@mail.gmail.com>
 <CACsJy8Do77QSKSERPE26bKJ0gANB0XmPVBLwb1QKAW4qe0ouAQ@mail.gmail.com>
 <CAMDzUtz_BhW_tuQLy+AiNY7hz_HXCmHOtUNDgMBc=Taeon_Dwg@mail.gmail.com> <CACsJy8APLtweaf-q8+nCzJC-8J_vNZp-Y=AtNkX4NPuYr1jb=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 13:18:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQERJ-0007Qg-Pm
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 13:18:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309AbbBXMSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 07:18:09 -0500
Received: from mail-we0-f179.google.com ([74.125.82.179]:41511 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbbBXMSI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 07:18:08 -0500
Received: by wevm14 with SMTP id m14so24768184wev.8
        for <git@vger.kernel.org>; Tue, 24 Feb 2015 04:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lCOgu58o7+NX5oRr3faMBAT4Liztqqjw0K9RrsNwUUQ=;
        b=Pbch+isTPS5SzMpON3axzJstN8S+TjIaVzot42NJTjt3uGCXefWeeytT+LvpgGgh6T
         MRKxGcVDDcfbuInoT6TtqyoMFuyPkeP7+CLfeXarmE7YQSiyYNLZE43pg9I1+OiBPTNE
         R2pt9UEn/NKig4sf6bs/6l25Gq88X8us1L5q4sL7LSFSvx7bFQkkKyccM+Wg6GfJyC/Q
         tUXM4zkiav04AXt1D9W+QbAi+4K4qV16RE7hJJbrkTW+gR4vNUUtfpbjxpHqCRd5jb5W
         hYWOThds+YC/aIrwbP/4CWR7SOPJa2SwLFAyUSd1CJgwfWMNlhIH7TvzO+wsfJUXWnVT
         ovvg==
X-Received: by 10.180.21.161 with SMTP id w1mr29363599wie.44.1424780286991;
 Tue, 24 Feb 2015 04:18:06 -0800 (PST)
Received: by 10.27.95.230 with HTTP; Tue, 24 Feb 2015 04:17:26 -0800 (PST)
In-Reply-To: <CACsJy8APLtweaf-q8+nCzJC-8J_vNZp-Y=AtNkX4NPuYr1jb=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264321>

I'm not sure on how i would rewrite hex.c it is just an array.

>From git-compat-util.h i only needed a subset of the file (Lines 699
to 785), as you assumed, but rewriting it also seems pointless as it
is only a few defines and 4 very short functions.

I have asked everybody who changed anything in those lines for their
approval. I hope they all agree.

On Tue, Feb 24, 2015 at 10:46 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Feb 24, 2015 at 4:29 PM, Guilherme <guibufolo@gmail.com> wrote:
>> That discussion seems to have just died off.
>>
>> Whom should i write to about making the license change effective? You
>> (Duy Nguyen) seemed to be fine with the license change. Can you, or
>> anyone else, further guide me on the process on making sure i can use
>> the file(s) in TSS?
>
> I'm not a lawyer, but I think after you double check
>
>  - what Jonathan Neider wrote about GPLv3 and Apache2 is true
>  - perhaps check with Anthony Ramine, who is the only person besides
> me that has made changes in wildmatch.c, in b79c0c3 (wildmatch:
> properly fold case everywhere - 2013-05-30)
>
> then wildmatch.c is good for reuse. You probably need to check with
> other people who made changes in hex.c and git-compat-util.h.
> git-shortlog and git-blame could be used to get the email list of
> these people. But maybe it's just easier to rewrite those, hex.c is
> not big and I suspect you don't need much of git-compat-util.h.
> --
> Duy
