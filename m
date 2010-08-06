From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Back-dating commits--way back--for constitution.git
Date: Fri, 6 Aug 2010 15:19:57 +0000
Message-ID: <AANLkTinXtjn7=9jRNmv4zhhPiy3NVOca0gY9dkYCUhY7@mail.gmail.com>
References: <i372v0$3np$1@dough.gmane.org>
	<AANLkTik2B8pGo8uR4yxV3nz-Nx6dcU+fiO8GWgv9-VtW@mail.gmail.com>
	<4C599781.2020603@gmail.com>
	<4C5B2F2E.4050709@gmail.com>
	<AANLkTikWc0rKV9rQsLfmZvhdqAuvATmbur2ZqQ4Xu7uo@mail.gmail.com>
	<AANLkTikJP2d5_pA+RcQeToE+RGW0oBhcZyghLfqDoJ8E@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Joel C. Salomon" <joelcsalomon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 17:20:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhOiN-0004f6-1a
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 17:20:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757480Ab0HFPUA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 11:20:00 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54882 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755157Ab0HFPT6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Aug 2010 11:19:58 -0400
Received: by iwn33 with SMTP id 33so1395686iwn.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 08:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5tFl8G9Yg/vqZTR5uR3a9i8akh0rCz2Oefv5b7Q17Mk=;
        b=LwgI17qFLIy/gwRLC9m9O4XQ3X/f4MVOBEc5CyObotmRIShVjN+h+rra2ZHzbYORHd
         jK8VAflUNxlCG6VCdCXfZGFvS//YAcUT2U8SW7QbR35rIaFxkZyFm8vPLQk+0Z5tuo3D
         DXKNzI/wPmKGiAed8mlLoQUTplpmmNeZ8x2m0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xFPa3+RnhFE03daO6enVOYn55M/kTYomqVIG2IEy9dRQ/Vo3gla395vrggH5Zsl3JR
         NdffFfbXoUxSL0f3fEdGlvVx/I252lAeMiEyriA11/enqdJZh1ukDYj1ysWf3mtm8BtF
         7uUd/IDykCz6WjbfeY4zQBSCSD2ufJJHplOgA=
Received: by 10.231.59.15 with SMTP id j15mr14052536ibh.172.1281107997761; 
	Fri, 06 Aug 2010 08:19:57 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Fri, 6 Aug 2010 08:19:57 -0700 (PDT)
In-Reply-To: <AANLkTikJP2d5_pA+RcQeToE+RGW0oBhcZyghLfqDoJ8E@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152789>

On Fri, Aug 6, 2010 at 15:18, Joel C. Salomon <joelcsalomon@gmail.com> =
wrote:
> On Thu, Aug 5, 2010 at 5:58 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n
> <avarab@gmail.com> wrote:
>> On Thu, Aug 5, 2010 at 21:37, Joel C. Salomon <joelcsalomon@gmail.co=
m> wrote:
>>> It's up, at <http://github.com/jcsalomon/constitution>, with one co=
mmit.
>>>
>>> I'm curious to find out if folks with 64-bit time_t get the correct
>>> author and commit times.
>>
>> On 32bit:
>>
>> commit 826a4f7721fe1c3963a733ecbc5422f05925af5d
>> Author: The Philadelphia Convention <>
>> Date: =C2=A0 Wed Dec 31 19:59:59 1969 -0400
>>
>> On 64bit:
>>
>> commit 826a4f7721fe1c3963a733ecbc5422f05925af5d
>> Author: The Philadelphia Convention <>
>> Date: =C2=A0 Mon Sep 17 13:00:00 1787 -0400
>
> Cool, it works! =C2=A0(The 13:00 should have been 12:00, but there's =
some
> DST weirdness at work.)
>
> Can you check what git-fsck has to say about the repos, on 32- &
> 64-bit machines?

32bit says:

    error in commit 826a4f7721fe1c3963a733ecbc5422f05925af5d: invalid
author/committer line

64 bit doesn't give any warning at all.
