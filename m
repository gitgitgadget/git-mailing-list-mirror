From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [ANNOUNCE] Git v2.7.4 (and updates to older maintenance tracks)
Date: Mon, 21 Mar 2016 00:41:57 -0400
Message-ID: <CAPig+cR7d0UF08fQy5uXW8U+7rdjGSO1drMxm6LOV-KB40mwPw@mail.gmail.com>
References: <xmqqlh5gzuc8.fsf@gitster.mtv.corp.google.com>
	<680C4CDE-233E-4603-B3F1-D68EB126620F@FreeBSD.org>
	<CAPig+cSOjFqcKGaZC1HWGdp7aCg7Dog1GvFYPYRbShARPm9ODQ@mail.gmail.com>
	<20160320194313.GB6288@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Renato Botelho <garga@freebsd.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 05:42:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahrfI-00075g-Kv
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 05:42:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbcCUEmA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Mar 2016 00:42:00 -0400
Received: from mail-vk0-f49.google.com ([209.85.213.49]:36305 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794AbcCUEl6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2016 00:41:58 -0400
Received: by mail-vk0-f49.google.com with SMTP id q138so110464735vkb.3
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 21:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=OsEb6zJ6tlj2gcCBs+zvgRlkAu+PoZNBFKrqqxOVniM=;
        b=fDtvzirDEczuDdsBHQDDIfw3zh2KahQvmejOoC20qudxMf1+KCHHBGD7QOGthj24yH
         RhP5D2U9U11jlpzHo+vpyJ89vcfy5KRuO6br90WDuHC9JH+spSpn/a+tM/1yPba6KfUG
         umTkl46UEi5A2EaPJJ0diOnLwblttp+ywMtRr7o4yraa4K3TgTzffKDoHNvcjQaHv/zF
         aOUoGJnqtDcPm5dmAmfqlzQXL0WHwo043YgdgKAd/nf6Xcdn8eNGh8kA+JgOLHbLm0Ah
         c9um0vziobDFpWwZ80w5llR2+uZnyFYOByDSkD6zYpaOwJXpZ5AlITeFcjOOqFPtoOhE
         LTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=OsEb6zJ6tlj2gcCBs+zvgRlkAu+PoZNBFKrqqxOVniM=;
        b=AQyQjPki5nUlHVHgf5TEJkQWQwp9ChlYqqq7gE9FYt2xczD/tJbDCMmjg20JdgYRJN
         +cRyo/y8Eby4G8HXXiPJ7gTonB/TMCRK/z519r/hjuy108K78Nr8UKvvEISvQYtkP6Us
         6e54hXg8zWxy4/MPVzphRpW4/uvWNe364uhtow4v2yPM2ZwAfK2vaK1IAwUkVSLmUCS9
         Fj+zJfXTBStAQYJY+8qmJERQ3Xn+57Ip+1gKJZp1cZa1HxSCZgKUSWACCP80RDK7G4PF
         0M0kEIzZKsrJ+UwuEEo+9RwlsTITRTCHrslTOqlOBr/YmcLd0o9ehRwukLJ8/l0MhiUi
         WITg==
X-Gm-Message-State: AD7BkJL4jHV+ff7CkgzBeEyZewJjwJrLnUZW3APn9tntuKqxrM5OsSJgYnYsQF6DwEf1PJJQqj77MbGHuc06Kw==
X-Received: by 10.176.7.5 with SMTP id h5mr1442082uah.66.1458535317997; Sun,
 20 Mar 2016 21:41:57 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Sun, 20 Mar 2016 21:41:57 -0700 (PDT)
In-Reply-To: <20160320194313.GB6288@sigill.intra.peff.net>
X-Google-Sender-Auth: TY9DNm1V1KPl3F7sTn4SGG2ahaM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289399>

[cc:+Torsten]

On Sun, Mar 20, 2016 at 3:43 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Mar 20, 2016 at 01:07:52PM -0400, Eric Sunshine wrote:
>> On Sun, Mar 20, 2016 at 11:32 AM, Renato Botelho <garga@freebsd.org>=
 wrote:
>> > 2.7.4 fails to build on FreeBSD 9.x, that uses by default gcc 4.2.=
1. I=E2=80=99ve fixed it adding an extra dependency to make force it to=
 require gcc 4.8+. Here is the output:
>> >
>> > combine-diff.c: In function 'diff_tree_combined':
>> > combine-diff.c:1391: internal compiler error: Segmentation fault: =
11
>>
>> Interesting. This appears to be the same bug as [1].
>>
>> [1]: http://thread.gmane.org/gmane.comp.version-control.git/287486/f=
ocus=3D287789
>
> Yes. AFAICT that version of gcc is simply buggy, and we are not doing
> anything illegal or even particularly exotic. Given how old it is, I'=
m
> not sure it's worth worrying too much about it, but I am happy to wor=
k
> around it if somebody can figure out how to do so.
>
> I spent some time trying to bisect gcc, but had trouble getting a
> working build for a gcc that old.

I installed FreeBSD 9 and managed to reproduce the compiler crash.
After a bit of experimentation, I devised a simple work-around and
submitted it as a patch[1].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/289397
