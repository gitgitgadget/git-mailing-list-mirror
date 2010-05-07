From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC] Hacky version of a glob() driven config include
Date: Fri, 7 May 2010 18:58:47 +0000
Message-ID: <AANLkTilG5OGjQcd1Vd1CdyOibFh4Po6jdfvSRNidrRzh@mail.gmail.com>
References: <u2i51dd1af81004060115t5f837840z5adcf83622fa8882@mail.gmail.com>
	 <1273180440-8641-1-git-send-email-avarab@gmail.com>
	 <AANLkTik6z4cvUzjfq-q61tgk_MhqWKc_A55i3VauPSQC@mail.gmail.com>
	 <AANLkTinhh8TXY9r9Jf394YKYXDxpU65qjg7MbPcb12Ls@mail.gmail.com>
	 <AANLkTilp0d28QMs_K7cVrfqmkzeqs8FTJbU1oeuUy7V6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Fri May 07 20:58:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OASlF-0000pr-Pw
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 20:58:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757863Ab0EGS6u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 14:58:50 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:57860 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757780Ab0EGS6t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 14:58:49 -0400
Received: by yxe1 with SMTP id 1so957983yxe.33
        for <git@vger.kernel.org>; Fri, 07 May 2010 11:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+yGIxYOHtBE7V6YYN3nI5rNwVK6I8w43Ag3+IUSsPvo=;
        b=mVTuZ+OwFeplVBkkIzhQzorSmrptrm/sj3gDmQk5Q4ohDZKdII9wmn/MZw+5oFAeBF
         TkGE5+J3vGtiAR6TjDhsNP6hUI0saLDz4EfVbphmNxKR/DUYJInj2Q8hhgNAvPPjMWge
         di4WcH9s0BEQKtkQhPhSsWggILonILPTymVCw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=k/7RLEE+V3K5d9gXpcegBu1krFgeA2WeRJtDI0rrf5OGz/EZLnLrAGHmUw7nVNAksI
         PbrZzz49fx2t/AN5cCvDBr53sGKYhhaL/VmBnpiSHZtEa2fVeuhtkcf+iu1CVHSfEWHr
         METo71/uAsxMVCe4IQszusY1quLq/db+nUaTY=
Received: by 10.231.161.75 with SMTP id q11mr196757ibx.64.1273258727965; Fri, 
	07 May 2010 11:58:47 -0700 (PDT)
Received: by 10.231.160.11 with HTTP; Fri, 7 May 2010 11:58:47 -0700 (PDT)
In-Reply-To: <AANLkTilp0d28QMs_K7cVrfqmkzeqs8FTJbU1oeuUy7V6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146552>

On Fri, May 7, 2010 at 18:29, Bert Wesarg <bert.wesarg@googlemail.com> =
wrote:
> On Fri, May 7, 2010 at 18:56, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>> On Fri, May 7, 2010 at 06:00, Bert Wesarg <bert.wesarg@googlemail.co=
m> wrote:
>>> On Thu, May 6, 2010 at 23:14, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n <avarab@gmail.com> wrote:
>>>>
>>>> Not-signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@=
gmail.com>
>>>
>>> So you don't agree to the Developer's Certificate of Origin, don't =
you?
>>
>> Signed-off-by is for "if you want your work included in git.git"
>> (according to Documentation/SubmittingPatches). I don't think this
>> patch is ready for inclusion as-is, but I wanted to solicit comments
>> on the general approach.
>>
>
> Can you please quote SubmittingPatches for your argumentation.

I already did, but here's the full paragraph I quoted from, for
reference:

	- if you want your work included in git.git, add a
	  "Signed-off-by: Your Name <you@example.com>" line to the
	  commit message (or just use the option "-s" when
	  committing) to confirm that you agree to the Developer's
	  Certificate of Origin

I'm not seeking to include this work as-is in Git, so I added a
Not-signed-off-by line to make that clear (as if all the bugs didn't
do that already).

I do agree to the Developer's Certificate of Origin, but just read the
"Not-signed-off-by" as "you really don't want to apply this in its
current state". I'm asking for comments so that I can produce an
appliable patch, that one will have a Signed-off-by line.
