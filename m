From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 01/10] ref-filter: introduce 'ref_formatting_state'
Date: Wed, 29 Jul 2015 21:26:55 +0530
Message-ID: <CAOLa=ZS=bMnVDjGL0vb08t2XCTqH7tG9+QuPyz3D9wb7hCbpaA@mail.gmail.com>
References: <CAOLa=ZR6_2NBB4v0Ynq391=8Jk2RZON6R0YG=HKUNwKx249b7Q@mail.gmail.com>
 <1438065211-3777-1-git-send-email-Karthik.188@gmail.com> <vpqwpxk215y.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 29 17:57:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKTjV-0005jI-BD
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 17:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185AbbG2P5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 11:57:25 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:33225 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbbG2P5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 11:57:24 -0400
Received: by obdeg2 with SMTP id eg2so10442318obd.0
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 08:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OcAJnA0noKj8Noatt185hoeGX2rPmSZrBa/uXklg68s=;
        b=qEcotFIwcyfYtHRsLBZhnn0cIOnXX+PBt4blVZ325R2qM3onqFCOvvldFxa6J1OXDB
         YO163KDGldCCp49OkGv5A0WAB64EFsTvzMnLlOBRXRBZ+TvyIcIU0MGte/xyydQ73o7f
         zwFzCSbnUtN9DW6HNCLI67158EwBB3GcUk5j0HOKATACJpyWwUG1JpKoi/OpBOiWVeRI
         BrhENYiGagpTG7VV0fRPXnglDxo3kHz/Vt2wKaw+EwaxsyQyCbF995NN2Kjsc8t9Q/a0
         TLRc0LPiH3tUVmU9z2n0TLVj7mIwc8L8hqNM4b1YGoPKmdrS21rcZ8dVwYJ41fV8J/L+
         TgAg==
X-Received: by 10.60.62.105 with SMTP id x9mr40033093oer.1.1438185444478; Wed,
 29 Jul 2015 08:57:24 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Wed, 29 Jul 2015 08:56:55 -0700 (PDT)
In-Reply-To: <vpqwpxk215y.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274911>

On Tue, Jul 28, 2015 at 12:56 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> -static void print_value(struct atom_value *v, int quote_style)
>> +static void apply_formatting_state(struct ref_formatting_state *state,
>> +                                struct atom_value *v, struct strbuf *value)
>>  {
>> -     struct strbuf sb = STRBUF_INIT;
>> -     switch (quote_style) {
>> +     /*  Eventually we'll formatt based on the ref_formatting_state */
>
> s/formatt/format/
>
> Also, we usually use a single space after /*.
>
> (Neither is very important since it disapears in the next commit)
>
>> +     /*
>> +      * Some (pesudo) atoms have no immediate side effect, but only
>
> s/pesudo/pseudo/. But if you are to rename these atoms to "modifier
> atoms", you should get rid of this "pseudo" here.
>

Ah, I hate making grammatical errors, Even though I check it always gets away.
Anyways waiting for Junio and others to reply on this version. Could do a resend
for this series if needed.


-- 
Regards,
Karthik Nayak
