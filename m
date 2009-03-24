From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 8/8] user-manual: simplify the user configuration
Date: Tue, 24 Mar 2009 02:22:56 +0200
Message-ID: <94a0d4530903231722t73fc85dq9cafb8a97cc2b674@mail.gmail.com>
References: <1237745121-6325-1-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-6-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-7-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-8-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-9-git-send-email-felipe.contreras@gmail.com>
	 <0A3F8ECD-EEFA-4DB0-AFED-AEE7DAFE8DB3@wincent.com>
	 <94a0d4530903221601hb3bf8aelf98b22ee560dfb7b@mail.gmail.com>
	 <984D312E-12B8-4A8C-B567-EF5AF1DDD3D6@wincent.com>
	 <94a0d4530903230407i2c858a5dk2c2e0703608e42d3@mail.gmail.com>
	 <52360AC9-EAE8-4DC3-9368-7220A034E0B5@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 01:25:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LluSd-00047n-73
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 01:25:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755941AbZCXAXG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2009 20:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755904AbZCXAXC
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 20:23:02 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:46065 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755740AbZCXAW7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 20:22:59 -0400
Received: by fxm2 with SMTP id 2so2050377fxm.37
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 17:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=W4gRuQSIuA2A87tr2KkFF1ClhOSc6uBmm7UF2fBAQ0I=;
        b=G2Dy0oJT8RUvLXYrSM8x8zO6da+E7NX8goMnq9Ktq1WwNKt6BJwCAvuY18NPC+5neV
         QepShOmoOyMZlfIwmawT0bXFnmoEr3fvLISwxw+yEe6LdtPsS70j5fKo/nHI/VjK03aF
         52IHjPfyEmTf2SrTHbenG7Pn88Vy5PW4s6xBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qIFEMonDEyQgulwOdC2qPY0LqZBLNd/HYIet7VuNXQoL1aALAATvjgLf3JYCIgJguK
         c9T332F7ckVWjbmVLVrxwjoz3nEiCGDnbC3EwQo0AcgCNYum8eUajjBNHb6j9EUsQHVX
         0lM2Vx1ADAWEk6k+vHOo0UjcAUJTIBWKRlncA=
Received: by 10.86.53.11 with SMTP id b11mr4124102fga.23.1237854176671; Mon, 
	23 Mar 2009 17:22:56 -0700 (PDT)
In-Reply-To: <52360AC9-EAE8-4DC3-9368-7220A034E0B5@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114371>

On Mon, Mar 23, 2009 at 1:09 PM, Wincent Colaiuta <win@wincent.com> wro=
te:
> El 23/3/2009, a las 12:07, Felipe Contreras escribi=C3=B3:
>
>> On Mon, Mar 23, 2009 at 2:07 AM, Wincent Colaiuta <win@wincent.com> =
wrote:
>>>
>>> El 23/3/2009, a las 0:01, Felipe Contreras escribi=C3=B3:
>>>
>>>> On Mon, Mar 23, 2009 at 12:42 AM, Wincent Colaiuta <win@wincent.co=
m>
>>>> wrote:
>>>>>
>>>>> El 22/3/2009, a las 19:05, Felipe Contreras escribi=C3=B3:
>>>>>
>>>>>> This is shorter, avoids the burder to think about the format of =
the
>>>>>> configuration file, and git config is already used in other plac=
es in
>>>>>> the manual.
>>>>>>
>>>>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>>>>> ---
>>>>>> Documentation/user-manual.txt | =C2=A0 =C2=A08 +++-----
>>>>>> 1 files changed, 3 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/Documentation/user-manual.txt
>>>>>> b/Documentation/user-manual.txt
>>>>>> index b7678aa..c6ed940 100644
>>>>>> --- a/Documentation/user-manual.txt
>>>>>> +++ b/Documentation/user-manual.txt
>>>>>> @@ -1015,13 +1015,11 @@ Telling git your name
>>>>>> ---------------------
>>>>>>
>>>>>> Before creating any commits, you should introduce yourself to gi=
t.
>>>>>> =C2=A0The
>>>>>> -easiest way to do so is to make sure the following lines appear=
 in a
>>>>>> -file named `.gitconfig` in your home directory:
>>>>>> +easiest way is to use the linkgit:git-config[1] command:
>>>>>>
>>>>>> ------------------------------------------------
>>>>>> -[user]
>>>>>> - =C2=A0 =C2=A0 =C2=A0 name =3D Your Name Comes Here
>>>>>> - =C2=A0 =C2=A0 =C2=A0 email =3D you@yourdomain.example.com
>>>>>> +$ git config --global user.name "Your Name Comes Here"
>>>>>> +$ git config --global user.email you@yourdomain.example.com
>>>>>> ------------------------------------------------
>>>>>>
>>>>>> (See the '"CONFIGURATION FILE"' section of linkgit:git-config[1]=
 for
>>>>>> --
>>>>>> 1.6.2.1.352.gae594
>>>>>
>>>>> See this lengthy thread:
>>>>>
>>>>> http://article.gmane.org/gmane.comp.version-control.git/106634
>>>>
>>>> I've obviously seen that thread because I started it.
>>>
>>> Yeah, I noticed that only after sending my message. I hadn't realis=
ed at
>>> first because the patch really looked like it was written by someon=
e who
>>> hadn't ever seen the thread, as it doesn't address the points raise=
d in
>>> the
>>> thread at all.
>>
>> I am addressing the points.
>
> Sorry for not noticing the other patch in the series. I fired off the=
 email
> because when I read 8/8 I thought, "This looks almost exactly like a =
patch
> that was previously rejected".

It's ok, thanks for the comment, I'll keep that in mind for the patch s=
eries.

--=20
=46elipe Contreras
