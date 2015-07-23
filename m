From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 9/9] tag.c: implement '--merged' and '--no-merged' options
Date: Thu, 23 Jul 2015 21:50:52 +0530
Message-ID: <CAOLa=ZS5=S_vyCKOFTQbb+0-9WYnwrOyU917GLjfHEr-GYwybw@mail.gmail.com>
References: <1437246749-14423-1-git-send-email-Karthik.188@gmail.com>
 <1437256837-13378-1-git-send-email-Karthik.188@gmail.com> <1437256837-13378-3-git-send-email-Karthik.188@gmail.com>
 <vpqy4i8m14v.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 23 18:21:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIJFP-0000sA-3w
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 18:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414AbbGWQVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 12:21:24 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:33315 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577AbbGWQVW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 12:21:22 -0400
Received: by oige126 with SMTP id e126so168771937oig.0
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 09:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LXZp7Pz2ar+1S5baMi5DrGhX8j6L2PxE7PqU8qHtcrQ=;
        b=TuImfV+w1buPqtDr+zGVV46f1iBwZaLyaey/1/lxjgh3vZ6m+UMRqOxWeHM5moKMNV
         SfOee6bUCIThQhj+H+4pdmVRTDfagIgKOKNiYV1mbNxjgHfRazMRZ1B5/2OC1rbvW2zc
         sWv9doTipYSTUq79mBFC5yX1290EzUWeWDnLNCJw4dtFupE60ConQrYRBIQkEBoZRuOc
         2r7pi1GeXG0iUFbRm9HKoDoZJ9ya7sJgxksjMBK3j56P0dgQHaYwzmLp/RQaaldgEsvC
         saalWxeM+CSsJVMWSycyRRQ2uownphT5qoUPCaU7+6+mTTmw/0o+5WmgAoCBFGvV5Czt
         EgKw==
X-Received: by 10.182.153.161 with SMTP id vh1mr9343323obb.34.1437668481937;
 Thu, 23 Jul 2015 09:21:21 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Thu, 23 Jul 2015 09:20:52 -0700 (PDT)
In-Reply-To: <vpqy4i8m14v.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274503>

On Thu, Jul 23, 2015 at 1:10 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +--merged [<commit>]::
>> +     Only list tags whose tips are reachable from the
>> +     specified commit (HEAD if not specified).
>> +
>> +--no-merged [<commit>]::
>> +     Only list tags whose tips are not reachable from the
>> +     specified commit (HEAD if not specified).
>
> You may want to spell it `HEAD` (with backticks).
>

Will do!

-- 
Regards,
Karthik Nayak
