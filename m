From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 03/11] ref-filter: add option to pad atoms to the right
Date: Tue, 28 Jul 2015 00:24:33 +0530
Message-ID: <CAOLa=ZT9_0ZZQwKwObgndLezcOWOk3LBTjAM7mMU2cyXu7--MQ@mail.gmail.com>
References: <CAOLa=ZTtAepdO5U8zo62VBn_z4-LcKoguPxVGaAnNZULEwzrQQ@mail.gmail.com>
 <1437982035-6658-1-git-send-email-Karthik.188@gmail.com> <1437982035-6658-3-git-send-email-Karthik.188@gmail.com>
 <vpq3809aho9.fsf@anie.imag.fr> <xmqqr3ntioyh.fsf@gitster.dls.corp.google.com>
 <vpqk2tl4mvx.fsf@anie.imag.fr> <CAOLa=ZRVMnqxb-E29f_53igzJDTWNU0yjVACSq1CK8TCbaM-9w@mail.gmail.com>
 <vpqwpxl30aj.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jul 27 20:55:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJnYN-0006ZI-Di
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 20:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753699AbbG0SzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 14:55:05 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34558 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbbG0SzD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 14:55:03 -0400
Received: by oigd21 with SMTP id d21so56761545oig.1
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 11:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8yJPGv3+YzypHILLpN9M271mCTkVvKWsmkE2kJGAu24=;
        b=VbAnMZgILar4u6ZfFb8RFXoZieJdqcTFXEH9e7mT65kBC+EVg6r49+qIhe0Sqrcpr0
         U868gOPvoowaY3lWuzZ6ZxIP5j04q7oPVYN8Valclg/12XbUSJMQ1pKut/Gj25AS6Uw+
         gKCpVSTY2XDlsIt3GMDef6ev9+GzSqD1MUhphewj56WckSjjuHRZnXnGLXNM+mGBOfe2
         6d9bANl5bx8jKrbJqw7f64bHCHs9gHzz/TKytvbRgZueBgnkdR39pUt42VS14ryGvduc
         yCmPbqcb8oJFp7CmfzFeQownD58qv869pD4E285NUmFEhS7CxB6lfcEA26/M9vMP/WPQ
         37eA==
X-Received: by 10.202.92.6 with SMTP id q6mr28215319oib.11.1438023303290; Mon,
 27 Jul 2015 11:55:03 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Mon, 27 Jul 2015 11:54:33 -0700 (PDT)
In-Reply-To: <vpqwpxl30aj.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274698>

On Tue, Jul 28, 2015 at 12:17 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Mon, Jul 27, 2015 at 9:24 PM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> Yes, but on the other hand we already have:
>>>
>>>   git log --format='%<|(50)A very long irrevlevancy|%an|'
>>>
>>> that pads/truncate %an. So, consistancy would dictate that Karthik's
>>> version is the right one.
>>
>> Sorry but I didn't understand what you're trying to say here, Matthieu.
>
> The "git log" equivalent of %(padright:N) is %<|(N), and it behaves the
> same way as your current implementation of %(padright) (except for the
> missing reset in your v5).
>
> So, if we want to be consistant with "git log", we should keep the
> "apply to next atom, even if it's far away in the format string"
> semantics.
>
> Note that consistancy is not the only criterion for choice, so I'm not
> saying we should absolutely do this, just that there's an argument in
> favor of it.
>

I didn't know that, thanks, I think I'll let Junio make the call here :)

-- 
Regards,
Karthik Nayak
