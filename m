From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Is there any way to make hooks part of the repository?
Date: Tue, 1 May 2012 17:18:46 -0700
Message-ID: <CAE1pOi2Gj-8fRhaUMmwhCDTLp27ETKeaExvm7iHz8HpObY8O+A@mail.gmail.com>
References: <CAE1pOi2hr7ewjo5WVDoW0ipYxDVTckr5M_sHNoOQ323=_k754Q@mail.gmail.com>
	<7vipgf8wve.fsf@alter.siamese.dyndns.org>
	<86r4v3mxf7.fsf@red.stonehenge.com>
	<7vaa1r8vhy.fsf@alter.siamese.dyndns.org>
	<CAE1pOi00Mr4dOj2ChTJU9XWypUAaVUDDa36-M7LA+9BixW0nKw@mail.gmail.com>
	<CAJsNXT=niP2Ja-pSbvj-OGi5t0x0-Zxm3CdcY0nLs9ROdCG8hg@mail.gmail.com>
	<CAE1pOi02_u9j2oHy-RJ-XbrCmDiUWd4-=50f-v+iaK1GLaLQZw@mail.gmail.com>
	<CA+7g9JzvN+5RsSF+bRFtaMafZeY+TyFkXeq-6OSAW3qJ99JqKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: PJ Weisberg <pj@irregularexpressions.net>,
	Junio C Hamano <gitster@pobox.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Git Users <git@vger.kernel.org>
To: Nathan Gray <n8gray@n8gray.org>
X-From: git-owner@vger.kernel.org Wed May 02 02:19:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPNHv-0000mN-Lb
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 02:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755254Ab2EBASs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 20:18:48 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44524 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676Ab2EBASr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2012 20:18:47 -0400
Received: by ghrr11 with SMTP id r11so84071ghr.19
        for <git@vger.kernel.org>; Tue, 01 May 2012 17:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=XJRRB3EVzPt0Z9DOrunscdPk16omQGi6pqKI9DQTjc8=;
        b=NASKU06ZPxuoYuSpHmFqPx4aZ9yT78uYUCIPblJZeNdHxTokQXxhZdRA1K7KHctOKe
         dwymi2ZwfRpxhsNZLel3zp2KCvvSe8LUE85LbP6cJtBZyFcuqcfh8DC4qZXayLV4gIYk
         ndMHID92sVxBg2csGqjxtBnjI4CntewxbfHfIOCPHE+qnnP182utOVU+nBXIoF11wTdg
         Y5i6TItGA5sNckz9crhsqORiTWH+hX/L6KCimbXwN1kujJ2dDrShyFDFIjFTTf6Xsmpp
         BVMAUmpRrobKapx4m53hm1iCWMH2WkP7DhDRqZenBvoFvUyi1UDpjXQ5wAFO+iK2Ugmy
         5xPg==
Received: by 10.236.75.234 with SMTP id z70mr28985725yhd.5.1335917926876; Tue,
 01 May 2012 17:18:46 -0700 (PDT)
Received: by 10.236.79.98 with HTTP; Tue, 1 May 2012 17:18:46 -0700 (PDT)
In-Reply-To: <CA+7g9JzvN+5RsSF+bRFtaMafZeY+TyFkXeq-6OSAW3qJ99JqKg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196773>

On 1 May 2012 17:10, Nathan Gray <n8gray@n8gray.org> wrote:
> On Tue, May 1, 2012 at 3:21 PM, Hilco Wijbenga <hilco.wijbenga@gmail.=
com> wrote:
>> On 1 May 2012 14:59, PJ Weisberg <pj@irregularexpressions.net> wrote=
:
>>> On Tue, May 1, 2012 at 2:09 PM, Hilco Wijbenga <hilco.wijbenga@gmai=
l.com> wrote:
>>>
>>>> On 1 May 2012 14:03, Junio C Hamano <gitster@pobox.com> wrote:
>>>>
>>>>> We've talked about something like that a few times in the past, b=
ut as far
>>>>> as I (am concerned / remember) the conclusion has always been tha=
t is not
>>>>> worth "standardizing", i.e. nothing a ./setup script in-tree or a=
 Makefile
>>>>> target cannot offer the same convenience.
>>>>
>>>> This would not keep things up-to-date, though, would it? It seems =
like
>>>> yet another thing developers need to remember and do. I would pref=
er
>>>> something more automatic.
>>>
>>> Once your hooks are installed, couldn't your post-checkout and
>>> post-merge hooks keep all the others up to date?
>>
>> Excellent point. Yes, that would certainly work.
>
> But beware, this has the effect of making your hooks
> version-dependent. =C2=A0Check out a different branch and you can
> potentially end up with a different hook.
>
> IMHO things like this belong in a separate "admin" repo -- policy may
> change over time, but going back to an old version of your code
> shouldn't take you back to a correspondingly old version of your
> policy.

You have a point, of course, however, checking out an older version
(that does not comply with current policy) should not break (when
interacting with Git) just because of that. So I think there is at
least some justification to version the policy as well.

This is something we will simply have to experience to see what works b=
est.
