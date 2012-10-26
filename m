From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: git push tags
Date: Fri, 26 Oct 2012 15:08:41 -0400
Message-ID: <CAM9Z-n=qzakFsKbJbUsK_2Ypjg93wbdX+3LGk6NxoOKgv3DipA@mail.gmail.com>
References: <CAB9Jk9DMOwhDf3SvMzTmTZiyZg_4pgXx-evrfWkB3U4w-KqtVw@mail.gmail.com>
	<CAM9Z-nkxCOyrtJ8vCF=00vrA_1eFr2-Fk7PXjYEx0HbVt0GPkQ@mail.gmail.com>
	<CAB9Jk9A95YrrtH8ue-CJ6Mqe9Z+3nfo=tjurLZjmecfiMFijvg@mail.gmail.com>
	<CAM9Z-nkosbe1NXYnu7x6v4seLqCnMBWg-jrdH2eJ9RetaZBTyQ@mail.gmail.com>
	<20121026174255.GE10560@camk.edu.pl>
	<CAM9Z-nkBO1dbF-sBFLuxM_S_MT79Cx=gLEL+83XKB7ys8VTqNQ@mail.gmail.com>
	<20121026182020.GF10560@camk.edu.pl>
	<CAB9Jk9AR7vFBH6E7-hFabyD9XgRrF5PVZU-HtABS85wkwVTt+Q@mail.gmail.com>
	<20121026190029.GB15328@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>,
	git <git@vger.kernel.org>
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Fri Oct 26 21:08:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRpH6-0007Qs-GI
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 21:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966093Ab2JZTIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 15:08:44 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:42607 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966075Ab2JZTIn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 15:08:43 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1379171bkc.19
        for <git@vger.kernel.org>; Fri, 26 Oct 2012 12:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EdwKGZiKUsQPXX5ZoeeCn0tJ0ag/l5W09tuSswbyDBw=;
        b=lNgtKB/n3NxiXtGjFvW7ROKRjwp9lX3UlBoIODDbsOMhK0lWuHNjVmFI2Me6GDr1dj
         RPlqa6e9agaltFT1R9GCvjycpXGojsa/atPiB7W1hxkeUHlNM7Tnv15IIb8DGbgkjHD/
         s/ysOR1hYIabXpGzO6VpEyqvbVlZytf+9DWuFICX++I/oU3cyAitdmVFa+mA4bb9VfhZ
         Cj+csiZ/QHKTUslP/OSE87yBNXO3jNlvOq6+mPQ+a65aDTlNq7+HPhSnkB8x7cGvxUdd
         5GQLFltuwHbfw6tICP+uyr3qW/WA3yr1/rhD2Mdys0XYWh5zLIQhA1Ma14X8vdVBDGTe
         B2kw==
Received: by 10.204.131.87 with SMTP id w23mr7245202bks.73.1351278521827; Fri,
 26 Oct 2012 12:08:41 -0700 (PDT)
Received: by 10.205.122.144 with HTTP; Fri, 26 Oct 2012 12:08:41 -0700 (PDT)
In-Reply-To: <20121026190029.GB15328@camk.edu.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208480>

On Fri, Oct 26, 2012 at 3:00 PM, Kacper Kornet <draenog@pld-linux.org> wrote:
> On Fri, Oct 26, 2012 at 08:35:50PM +0200, Angelo Borsotti wrote:
>> Hello
>
>> Drew,
....
>> Kacper
>
>> thank you for the patch. To keep downward compatibility, the denial to
>> update tags should perhaps be enabled with some option.
>
> You are probably right. The proper submission should also contain a
> test. I have sent a crude patch to show that the behaviour asked by you
> is possible to obtain.
>
> I will try to prepare a formal submission patch, but I can't say how
> long it will take me. So if you want to do it by yourself feel free.

Kacper,
I have been rebuilding my local so that generating a proper patch for
the manpage change part of the set won't make a horrible mess over
here.

It looks to me like the changeset requires the following:
Kacper's patch, some manpage changes, a test.

Angelo, may we use your original mail as the source for the cover page?

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
