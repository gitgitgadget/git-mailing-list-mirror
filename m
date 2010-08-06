From: "Joel C. Salomon" <joelcsalomon@gmail.com>
Subject: Re: Back-dating commits--way back--for constitution.git
Date: Fri, 6 Aug 2010 11:18:25 -0400
Message-ID: <AANLkTikJP2d5_pA+RcQeToE+RGW0oBhcZyghLfqDoJ8E@mail.gmail.com>
References: <i372v0$3np$1@dough.gmane.org>
	<AANLkTik2B8pGo8uR4yxV3nz-Nx6dcU+fiO8GWgv9-VtW@mail.gmail.com>
	<4C599781.2020603@gmail.com>
	<4C5B2F2E.4050709@gmail.com>
	<AANLkTikWc0rKV9rQsLfmZvhdqAuvATmbur2ZqQ4Xu7uo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 06 17:18:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhOgq-00043L-8f
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 17:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757190Ab0HFPS2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 11:18:28 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47334 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755157Ab0HFPS0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Aug 2010 11:18:26 -0400
Received: by bwz3 with SMTP id 3so45938bwz.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 08:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lhb8yqvbW+jm+LGze+UMqvU/G5Su7QFK2aOzz4ANhoo=;
        b=vj3ozEIMgdscgTBe2tESaDHo2T9YtotekNSI28iCyHStFoWkYR9eDOUMPDMZ3AQJmI
         ZdqtlDshUEtHHcH2clPu74GwjgPLpndPI4v0/b982+eCE33aPLZtYu0aHT6B+yrCjiV/
         zCYZ3PKUKQyfjHOpvKIcjFtdC/hXpU/IlSuic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=grdCrAZsu4AbbcAVcVy0fVfc4Q0hy5Mpgd7MAAF+qsa7sRmLl5866dR+SSjwPk17hr
         /wnZdcZJ9ZNW/MZ91+DGxC6ESMRRGW7L+ig2RIeNkDgBJPlXvgskGISWifJjDtALU/Vb
         JuJ814TdhomSnBp/hSiu1iWjUIZUivLeltTaw=
Received: by 10.204.175.9 with SMTP id v9mr8094317bkz.13.1281107905274; Fri, 
	06 Aug 2010 08:18:25 -0700 (PDT)
Received: by 10.204.140.197 with HTTP; Fri, 6 Aug 2010 08:18:25 -0700 (PDT)
In-Reply-To: <AANLkTikWc0rKV9rQsLfmZvhdqAuvATmbur2ZqQ4Xu7uo@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152788>

On Thu, Aug 5, 2010 at 5:58 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Thu, Aug 5, 2010 at 21:37, Joel C. Salomon <joelcsalomon@gmail.com=
> wrote:
>> It's up, at <http://github.com/jcsalomon/constitution>, with one com=
mit.
>>
>> I'm curious to find out if folks with 64-bit time_t get the correct
>> author and commit times.
>
> On 32bit:
>
> commit 826a4f7721fe1c3963a733ecbc5422f05925af5d
> Author: The Philadelphia Convention <>
> Date: =C2=A0 Wed Dec 31 19:59:59 1969 -0400
>
> On 64bit:
>
> commit 826a4f7721fe1c3963a733ecbc5422f05925af5d
> Author: The Philadelphia Convention <>
> Date: =C2=A0 Mon Sep 17 13:00:00 1787 -0400

Cool, it works!  (The 13:00 should have been 12:00, but there's some
DST weirdness at work.)

Can you check what git-fsck has to say about the repos, on 32- &
64-bit machines?

--Joel
