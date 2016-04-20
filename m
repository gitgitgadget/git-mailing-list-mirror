From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v2] git-p4: add P4 jobs to git commit message
Date: Wed, 20 Apr 2016 08:58:58 +0100
Message-ID: <CAE5ih7_7TeJDekoubzJ=ZPT_JUwQVyGczDt5yORZES89Qo=VjA@mail.gmail.com>
References: <0102015420a6c30a-f2da55c9-1fc4-4df6-860e-228c5305f617-000000@eu-west-1.amazonses.com>
	<xmqqshyi2yb7.fsf@gitster.mtv.corp.google.com>
	<CAE5ih7-2mefGwfXRhvQZJFPD4QYAzZ1jYG82s6cnDzWVCiDS8w@mail.gmail.com>
	<xmqqfuuh35v5.fsf@gitster.mtv.corp.google.com>
	<CABEqOBxZkYTm7_m-Eeq-acN=Nse1vLGk8Gm44BihVGi27KaGiw@mail.gmail.com>
	<xmqq7fft32y9.fsf@gitster.mtv.corp.google.com>
	<CABEqOBwqW+BO4rtOx4ax35VacE4RZhpo_1pbqzTP_EGiSWasiQ@mail.gmail.com>
	<xmqqh9ex1lsy.fsf@gitster.mtv.corp.google.com>
	<CABEqOBxkHstqRHFUYF7=eComB-HwUGwi0tpWbhvUuKiny-=Vyw@mail.gmail.com>
	<CABEqOBxY61yObr0FeUxPYxc6C+xvde1LOS7zS_dHpBqwemJ+dQ@mail.gmail.com>
	<xmqqd1plz4p5.fsf@gitster.mtv.corp.google.com>
	<CABEqOBx4vCUpYTGYM9VF6QHxGGgQSG5APSHymtbV7uVxAbU+ow@mail.gmail.com>
	<xmqqzispxoqt.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jan Durovec <jan.durovec@gmail.com>,
	Git Users <git@vger.kernel.org>,
	Roberto Tyley <roberto.tyley@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 09:59:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asn2U-0007cX-Vd
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 09:59:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932800AbcDTH7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 03:59:00 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:33155 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754188AbcDTH7A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 03:59:00 -0400
Received: by mail-oi0-f51.google.com with SMTP id r78so33284937oie.0
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 00:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=vqHe9+PjznCCwEJyKJzKq9nNE9yC2fXdkiFAAGQND/w=;
        b=XKjpN8t0u/eusDj7Ce9ahTG/7FWprfZdQMVwxRzX/JDSbht8rLUIjeeQAdxdT4zevH
         wvAKjlJLLwkdPqnAmPytk/n/T3GMXyxwCZDR0gAXjcXMkLa7LTO1lItMHfCJx2K0zP+8
         KWZgbOcOClfLR09V5f+Sv+Z9T9Ivr6R9JY8FE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=vqHe9+PjznCCwEJyKJzKq9nNE9yC2fXdkiFAAGQND/w=;
        b=YxK/Mn9pW6U0aWwfTXHc07bfk8nbi/ILlRdf00/iob3RAe5nOKRgcgOubc/0T40JiC
         waOngpzXlCnwtJYGPHcT2gQwrs58pU0izOlrM/P0vQjYOgitCANlE2iBhP7EAbA2Hw+Y
         NJSLJZX6F1If9g5RAszQnB27mWAFZg2GE1/rPyL7XS5gky5gzDcfp8C9c4V3AUzCOCCi
         tvAxmekEv+Y2ek405mE1vWXZEPSGpx5rydJmlfGR/075xpQXWgBwK43eSZtWEhGZ+i7h
         nVnQuqUrc+PjRQjbsY+r0wsM7uog3LM6m+cSG+TMZbzuFLmcsTmNPAqyp5cV7Q/hqaP9
         PKRA==
X-Gm-Message-State: AOPr4FUsVP3GJ5zzYjWzp7CKKp8sxBQ63qmKE6cNfrxRn8Iw4gUpfeudcmhSIN81jISVnY4u+s/Zuk0NH6AEvg==
X-Received: by 10.157.57.132 with SMTP id y4mr2801233otb.169.1461139139097;
 Wed, 20 Apr 2016 00:58:59 -0700 (PDT)
Received: by 10.202.75.210 with HTTP; Wed, 20 Apr 2016 00:58:58 -0700 (PDT)
In-Reply-To: <xmqqzispxoqt.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291990>

On 19 April 2016 at 22:39, Junio C Hamano <gitster@pobox.com> wrote:
> Jan Durovec <jan.durovec@gmail.com> writes:
>
>> On Tue, Apr 19, 2016 at 11:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> For a series this small it does not matter, but anything longer it
>>> would be easier to review with a cover letter (i.e. [PATCH 0/N]).  I
>>> do not know if submitGit lets us do that, though.
>>
>> There's a comment on PR itself (in addition to individual commits) so
>> theoretically it could.
>>
>> It seems that for [PATCH ... n/m] e-mails the commit messages are used,
>> so there's no reason why the PR comment couldn't be used for a cover
>> letter.
>>
>> In this case the PR comment was the same as for one of the commits.
>> Maybe submitGit tried to be smart there? Or maybe it just really
>> doesn't support it (yet?).
>
> In any case, I've queued the updated ones as they looked good.
> Thanks.

One thing I wondered about is whether this should be enabled by
default or not. Long-time users of git-p4 might be a bit surprised to
find their git commits suddenly gaining an extra Job: field.

Luke
