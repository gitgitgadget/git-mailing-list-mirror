From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: git-contacts questions
Date: Tue, 29 Oct 2013 10:59:56 -0600
Message-ID: <CAMP44s0Ou4S5Bbf9sHwnXFJazu12uHvjuTOTT4YK_8bg4MG2UQ@mail.gmail.com>
References: <CAHGBnuPW3dtiL-=6BgvaOB4VvOAPyZhrVS3WGreVH_Pt81=wyg@mail.gmail.com>
	<CAMP44s1+npNnR8-exARL8kamQ81JwyLhhQnnkv6DvK8e3qOfHA@mail.gmail.com>
	<CAHGBnuP6nyTCGGNntvWVYAtxNX9xgt6=F3HheiEUcPU_9TP-1g@mail.gmail.com>
	<CAMP44s2KdHPH-UaSwdiJtT8WNo7uT9K_ArXwqHhCryPRsX1qjA@mail.gmail.com>
	<CAHGBnuNWtgH_aYxv0gX44AkGTRo6vsKdd4w1cViLGD9O9RLaNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 29 18:00:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbCeA-0002qf-Oe
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 18:00:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757879Ab3J2Q76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 12:59:58 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:42535 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757837Ab3J2Q75 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 12:59:57 -0400
Received: by mail-la0-f49.google.com with SMTP id eh20so117226lab.22
        for <git@vger.kernel.org>; Tue, 29 Oct 2013 09:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XKF7nNIzRAchVkZaDINNWEGc+4JADJ/h0OPHF6OIKiY=;
        b=x5cDcPswW3R/3bmoHuYwUks1GKgpWc080xDxu7jwyCXkY0AbYr3XLz2et4OMb6gb+b
         xG+PtoSPYC+TA0JANuv4TaGFe2igHi/JcfLUgmPTEFsaNYnib7F/KrYN/S5k8CcVP7VP
         7E/XQfkbHSu4okmm58ej3sHhq6NQ8e/RCJJmvMOt6zuXRS4NQFrUwxeSpamtThqF3isK
         svRqX+a4qBe7SFaowhONPBkmSnlsTa4ctAhA++Q+XMVLPR6+cixm20POCvos0q2QLHd7
         l8i8L3f6IduzOOqPOjh84MOvsJ86QzwWdsoXXvRYOS0hD2uzLy8tz4dRV6Y/hwNv6Nqc
         csXg==
X-Received: by 10.152.116.109 with SMTP id jv13mr340032lab.30.1383065996350;
 Tue, 29 Oct 2013 09:59:56 -0700 (PDT)
Received: by 10.114.201.69 with HTTP; Tue, 29 Oct 2013 09:59:56 -0700 (PDT)
In-Reply-To: <CAHGBnuNWtgH_aYxv0gX44AkGTRo6vsKdd4w1cViLGD9O9RLaNQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236936>

On Tue, Oct 29, 2013 at 8:17 AM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:
> On Tue, Oct 29, 2013 at 11:35 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Tue, Oct 29, 2013 at 3:12 AM, Sebastian Schuberth
>> <sschuberth@gmail.com> wrote:

>>> $ git related b0783baacd20be7007df40cf274985c4863d63fb
>>> C:/Program Files (x86)/Git/libexec/git-core/git-related:309:in
>>> `popen': can't convert Array into String (TypeError)
>>>         from C:/Program Files
>>> (x86)/Git/libexec/git-core/git-related:309:in `from_rev_args'
>>>         from C:/Program Files (x86)/Git/libexec/git-core/git-related:345
>>
>> Fixed.
>
> Thanks, but now I'm getting
>
> $ git related b0783baacd20be7007df40cf274985c4863d63fb
> fatal: ambiguous argument '\^b0783baacd20be7007df40cf274985c4863d63fb': unknown
> revision or path not in the working tree.
> Use '--' to separate paths from revisions, like this:
> 'git <command> [<revision>...] -- [<file>...]'
>
> I've checked of course that the commit exists.

I've pushed a fix, it's not complete, but should work for most cases.

-- 
Felipe Contreras
