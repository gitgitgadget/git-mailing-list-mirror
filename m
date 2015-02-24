From: Jim Meyering <jim@meyering.net>
Subject: Re: Copyright on wildmatch.c
Date: Tue, 24 Feb 2015 14:16:23 -0800
Message-ID: <CA+8g5KGAEVFXWSNjH8sPKNHvb3vwMn9NXTa+o04VsruyswB+FA@mail.gmail.com>
References: <CAMDzUtyitrK__iE9ykfTuP+Ooq0FwMPp_NVgBfBGbSV52+OPoQ@mail.gmail.com>
 <CAMDzUtymj21ckMrA87q1TATeWuH6kS_TBrsJ_jVjfeH50CaniA@mail.gmail.com>
 <CACsJy8Do77QSKSERPE26bKJ0gANB0XmPVBLwb1QKAW4qe0ouAQ@mail.gmail.com>
 <CAMDzUtz_BhW_tuQLy+AiNY7hz_HXCmHOtUNDgMBc=Taeon_Dwg@mail.gmail.com>
 <CACsJy8APLtweaf-q8+nCzJC-8J_vNZp-Y=AtNkX4NPuYr1jb=Q@mail.gmail.com>
 <CAMDzUtxf0gF=JDgEk9EU3W2VWuP-Qy8-Kz-fTx_Y16UeFRGiYA@mail.gmail.com>
 <CAMDzUtw8ySWwHvx4G+0R=L5JpxKqeFFNQ8Rb6bo5FRGwArzJcA@mail.gmail.com> <CAMDzUtzPxrtwdJN7cRmaMC_Sezmr9zSge=K_pc1OztEA8FVc=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Guilherme <guibufolo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 23:16:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQNma-0006l0-LA
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 23:16:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263AbbBXWQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 17:16:44 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:39900 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182AbbBXWQn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 17:16:43 -0500
Received: by iecvy18 with SMTP id vy18so36107703iec.6
        for <git@vger.kernel.org>; Tue, 24 Feb 2015 14:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=fU7BI9T8rHQOxRtTi7i2g67DtR1VufsQYlIvXdMVf+g=;
        b=wLokcinZJ073gAX9Igk6RmRJ6QUVqmhG4fVTpl6Ld01gXWF9ve8HOIHuwd6QOvB1ut
         vYpf00ioFfZC6XBqKCx2ZiEPmLpGGEbvAbZVkQ0+z5GPX84IW1CciYmH1mHu10C8WKUJ
         /HaSxQEXdD5NuUIWsRReJ3+BNXKzxXTuO+KVdSwxT4dwDTfH0rJrN65JhBl3diy6eQca
         YXIGJXSNFzWtCbXXuLW3bQ2FXZJY4FzLuIxxCh7WyFCiSFT3r3hCdhLU+xY631I0+ZTf
         Jj6/kp2ExwvCdSbqre3SOJhl5eZiK1/4C4HEVEjiNvIlJyDSZoV+JFxTMSCGy1d4zPp6
         ji2w==
X-Received: by 10.50.79.166 with SMTP id k6mr585668igx.27.1424816203223; Tue,
 24 Feb 2015 14:16:43 -0800 (PST)
Received: by 10.64.171.101 with HTTP; Tue, 24 Feb 2015 14:16:23 -0800 (PST)
In-Reply-To: <CAMDzUtzPxrtwdJN7cRmaMC_Sezmr9zSge=K_pc1OztEA8FVc=g@mail.gmail.com>
X-Google-Sender-Auth: kQ5obYJSHSAkzzzBEYeBvPy8lAI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264354>

On Tue, Feb 24, 2015 at 4:34 AM, Guilherme <guibufolo@gmail.com> wrote:
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

Fine by me.
