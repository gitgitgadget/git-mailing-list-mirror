From: Reynald Borer <reynald.borer@gmail.com>
Subject: Re: git-svn checksum mismatch
Date: Wed, 8 Dec 2010 17:13:48 +0100
Message-ID: <AANLkTimJ63=iHD2NOGMsrDTnd9yeu6Zc9daJEuUekAgC@mail.gmail.com>
References: <AANLkTik0NBkjrPTzLp9ozMnnV+bng_u5Br1v+H4y6ed0@mail.gmail.com>
 <AANLkTimVyCndGZQLUnVM9CCQmDfOHYywcfzBAL2w0gbC@mail.gmail.com> <AANLkTinZocHeu3ho6U9oL=Q608NBJaUf-nKehppWaDYp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 08 17:14:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQMfG-0006qK-38
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 17:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753898Ab0LHQON convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Dec 2010 11:14:13 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:57237 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753804Ab0LHQOK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Dec 2010 11:14:10 -0500
Received: by yxt3 with SMTP id 3so742314yxt.19
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 08:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=qYCOFUXwNPoDFkuXCG9FMJPNi72hKcCtcGu2vUKFDmA=;
        b=Smw4PlfvrrweEBSjWMCB5txARECV8vIvHrIQ4AwzmdZY1kqEp/A3KZkUKxTpAwnmm8
         1IpL9XxbbLx8iFwEnUBcnbuO4GDo+zw5l19rpPY8NbIw9VudVdViDG2a04YmAUyaybCK
         UG6tFL4l30c5NqIYtH4iIJ6BKInDFqHxiqizo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=EWGUCtk3SPq+4nXQXYNUvtNZf5D6TkmeHTqFscqVD4/d15OJ64L4gXohMQMkNs+Yok
         08/CsShBvOlzyfc1o4OU85IlmlpDnGQJFtVEk+5ls2VBST9iCX8Wpb/8k8FKb4s/SWTY
         BnKM4e+WCITnZUZDwMWfBGSv7THpPM5GkhvXE=
Received: by 10.231.16.205 with SMTP id p13mr9386601iba.108.1291824849202;
 Wed, 08 Dec 2010 08:14:09 -0800 (PST)
Received: by 10.231.17.2 with HTTP; Wed, 8 Dec 2010 08:13:48 -0800 (PST)
In-Reply-To: <AANLkTinZocHeu3ho6U9oL=Q608NBJaUf-nKehppWaDYp@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163203>

Hello Patrick,

Thanks for your quick answer. I'm doing a checkout on a Linux box, so
there is no problem with the case of files. Thanks for the tip anyway.

Apparently it seems that SVN commits causing issues are the ones where
the svn property "eol-style" has been changed to native (because the
repositories are shared between Windows and Linux clients). I tried to
reproduce this in a clean repository but I did not succeed at
exhibiting the problem.

Cheers,
Reynald


On Wed, Dec 8, 2010 at 4:36 PM, Patrick Doyle <wpdster@gmail.com> wrote=
:
> On Wed, Dec 8, 2010 at 10:17 AM, Reynald Borer <reynald.borer@gmail.c=
om> wrote:
>> Hi again,
>>
>> Sorry to bother you again but I am still experiencing this problem. =
I
>> tried with a more up to date version of Git (version 1.7.3.2), and
>> this is still happening. I also tried to diagnose this issue but I a=
m
>> completely lost.
>>
>> I am very annoyed because this is preventing me using Git on all my
>> SVN repos (2 are failing on 30...)
>>
>> Does anyone know how I could try to solve this issue?
>
> Tossing out a random theory with nothing to back it up...
>
> I don't know anything about the "well known checksum mismatch
> problem", but are you trying to check out the SVN repository onto a
> file system that is case insensitive, such as on a Windows or (defaul=
t
> setup) Mac host?
>
> If so, the repository might have files with different spellings such
> as README and Readme in the same directory, which will get clobbered
> on such a host. =A0I've run into that issue in the past in a differen=
t
> context.
>
> --wpd
>
