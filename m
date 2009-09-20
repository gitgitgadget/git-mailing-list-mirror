From: Tim Visher <tim.visher@gmail.com>
Subject: Re: Pair Programming Workflow Suggestions
Date: Sun, 20 Sep 2009 11:37:34 -0400
Message-ID: <c115fd3c0909200837r2b987bdcw2d360d172611ad3d@mail.gmail.com>
References: <c115fd3c0909151043v3216a147v35e18710fbead515@mail.gmail.com> 
	<BLU0-SMTP195165E447A0C42386D083AEE30@phx.gbl> <c115fd3c0909160635x4d7368aeg4370668d765fd242@mail.gmail.com> 
	<20090916141730.GA24893@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sean Estabrooks <seanlkml@sympatico.ca>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Sun Sep 20 17:38:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpOUX-00022h-2Z
	for gcvg-git-2@lo.gmane.org; Sun, 20 Sep 2009 17:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754129AbZITPhv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Sep 2009 11:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754121AbZITPhv
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Sep 2009 11:37:51 -0400
Received: from mail-yx0-f199.google.com ([209.85.210.199]:50371 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753901AbZITPhu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Sep 2009 11:37:50 -0400
Received: by yxe37 with SMTP id 37so2356598yxe.33
        for <git@vger.kernel.org>; Sun, 20 Sep 2009 08:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=+H55MQc+fPPAVmkGWQRRUjbIL5Y1K3lUJYrGL6GV3qk=;
        b=vzGyi1Qmk+AiYGKHuvGum94a0MNQoKzYX4az3xttjllN0iBYZCUeeCiAXs2iXuSB2X
         vw60hXD83SSCSU0mMuKExybKvbseIcAVE0/Tq46Ht6m0ZtpJfOBIQ0CEIuc2V1zhyJdh
         niNH1rRNLLToS0ErcnXF16LDFwsUMzgXhV7CM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ZUynwYfGJcwc53IhoFw4LQMkr0Hmi8VNYJc0YD6VkrOIOEciVl3eOZd8oWI8+If7Un
         v1TvivHPx97cAIWzmR1iRv+OAyO2dKjLMegA4avmjWtCri7yZ7c5kNj+D3A87Wngw0BK
         lg6E8wgPHgU04GPv1CAHQPNZpyUJyR9RyUGeA=
Received: by 10.101.103.15 with SMTP id f15mr3271036anm.193.1253461074084; 
	Sun, 20 Sep 2009 08:37:54 -0700 (PDT)
In-Reply-To: <20090916141730.GA24893@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128849>

On Wed, Sep 16, 2009 at 10:17 AM, Nicolas Sebrecht <nicolas.s.dev@gmx.f=
r> wrote:
> The 16/09/09, Tim Visher wrote:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 Pairing, on the other hand, is much more
>> tightly integrated than that. =C2=A0Just like in Brian's post, it's =
really
>> a situation of Dev1 _&_ Dev2 wrote this feature, but one of them
>> happened to be typing and doing most of the nitty-gritty developing.
>> Changing the authors between committs almost seems to introduce an
>> arbitrary level of distinction where it's no longer _both_ but _one
>> then the other_. =C2=A0Does that make my question any clearer?
>
> FMPOV (and to follow the Pair Programming purpose), there isn't an "I=
"
> in "Pair". =C2=A0So having the same author name and sign-off for each=
 pair is
> what makes most sense. IMHO, "dev1_and_dev2" is actually the best
> option.

That's certainly interesting.  I guess I just assumed, not having too
much practical experience with actually pairing, that the driver would
be doing most of the coding for a given commit=E2=80=A6  It's true that=
 that's
not really the case.

Do you guys use Hudson or something similar when you're pairing?
How's your experience regarding how it interoperates with the
dev_1_and_dev_2 naming convention?

--=20

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
