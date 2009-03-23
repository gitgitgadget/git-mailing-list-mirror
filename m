From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 8/8] user-manual: simplify the user configuration
Date: Mon, 23 Mar 2009 13:07:18 +0200
Message-ID: <94a0d4530903230407i2c858a5dk2c2e0703608e42d3@mail.gmail.com>
References: <1237745121-6325-1-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-4-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-5-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-6-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-7-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-8-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-9-git-send-email-felipe.contreras@gmail.com>
	 <0A3F8ECD-EEFA-4DB0-AFED-AEE7DAFE8DB3@wincent.com>
	 <94a0d4530903221601hb3bf8aelf98b22ee560dfb7b@mail.gmail.com>
	 <984D312E-12B8-4A8C-B567-EF5AF1DDD3D6@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 12:09:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lli1U-0006k6-Qk
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 12:08:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755381AbZCWLHY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2009 07:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754633AbZCWLHX
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 07:07:23 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:35425 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210AbZCWLHV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 07:07:21 -0400
Received: by fxm2 with SMTP id 2so1735577fxm.37
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 04:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=leKPRny+ZwuieqwXoEz2qHOciYADmlFZHZDdxDvhI4A=;
        b=bnli3DjkomXkgYJLVLqWm2x/blgTkfbSvU3C8KKt/VxPLUXkOFztmOdbSIfDDWwCMb
         VAZWzKOvQzqjmKQkQjZYe0Gi0+7RFDAeqIx1H7iv6PrMDJd0djJJO5JP/VZflFKRhnn0
         m1QUAsts/YD4yTpLjPHVuwI12YYG/UvblRCb8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=c45D+luVWhl8KC1qAnBjCFczlKDaniOwcA0od/r/jYdWtW+qHoJkelWowAKgDpoy61
         aqgY2eBqs1OKjWmiV/AjjVwBXJ3ZoIre8pd+qpKDYwrRHMt+mTxLWPMHQfVTQqhr++D4
         Nlv7KQZKZhftLfuPmVgtLfxAS3rckBg7T7abc=
Received: by 10.86.82.6 with SMTP id f6mr3526193fgb.42.1237806439009; Mon, 23 
	Mar 2009 04:07:19 -0700 (PDT)
In-Reply-To: <984D312E-12B8-4A8C-B567-EF5AF1DDD3D6@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114290>

On Mon, Mar 23, 2009 at 2:07 AM, Wincent Colaiuta <win@wincent.com> wro=
te:
>
> El 23/3/2009, a las 0:01, Felipe Contreras escribi=C3=B3:
>
>> On Mon, Mar 23, 2009 at 12:42 AM, Wincent Colaiuta <win@wincent.com>
>> wrote:
>>>
>>> El 22/3/2009, a las 19:05, Felipe Contreras escribi=C3=B3:
>>>
>>>> This is shorter, avoids the burder to think about the format of th=
e
>>>> configuration file, and git config is already used in other places=
 in
>>>> the manual.
>>>>
>>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>>> ---
>>>> Documentation/user-manual.txt | =C2=A0 =C2=A08 +++-----
>>>> 1 files changed, 3 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/Documentation/user-manual.txt
>>>> b/Documentation/user-manual.txt
>>>> index b7678aa..c6ed940 100644
>>>> --- a/Documentation/user-manual.txt
>>>> +++ b/Documentation/user-manual.txt
>>>> @@ -1015,13 +1015,11 @@ Telling git your name
>>>> ---------------------
>>>>
>>>> Before creating any commits, you should introduce yourself to git.=
 =C2=A0The
>>>> -easiest way to do so is to make sure the following lines appear i=
n a
>>>> -file named `.gitconfig` in your home directory:
>>>> +easiest way is to use the linkgit:git-config[1] command:
>>>>
>>>> ------------------------------------------------
>>>> -[user]
>>>> - =C2=A0 =C2=A0 =C2=A0 name =3D Your Name Comes Here
>>>> - =C2=A0 =C2=A0 =C2=A0 email =3D you@yourdomain.example.com
>>>> +$ git config --global user.name "Your Name Comes Here"
>>>> +$ git config --global user.email you@yourdomain.example.com
>>>> ------------------------------------------------
>>>>
>>>> (See the '"CONFIGURATION FILE"' section of linkgit:git-config[1] f=
or
>>>> --
>>>> 1.6.2.1.352.gae594
>>>
>>> See this lengthy thread:
>>>
>>> http://article.gmane.org/gmane.comp.version-control.git/106634
>>
>> I've obviously seen that thread because I started it.
>
> Yeah, I noticed that only after sending my message. I hadn't realised=
 at
> first because the patch really looked like it was written by someone =
who
> hadn't ever seen the thread, as it doesn't address the points raised =
in the
> thread at all.

I am addressing the points.

>> Can you write more than one line to explain your point?
>
> I was thinking mostly of Junio's comments:
>
> http://article.gmane.org/gmane.comp.version-control.git/106667
>
> 'I am moderately against changing this part to use "git config". We
> traditionally introduced how to set configuration variables first by =
editing
> it in an editor, and this was quite deliberate, in order to show how =
the
> configuration file looks like, to demonstrate that there is no deep m=
agic in
> the file format, and to explain that it is perfectly Ok to edit it wi=
thout
> using "git config" command. I actually wish this section appeared a l=
ot
> earlier in the document, but
> that is a separate issue.'

Like patch 7/8 patch does?
http://article.gmane.org/gmane.comp.version-control.git/114163

The 'git config' howto section is the very first chapter.

> If you expect him to apply your patch, you'll probably want to addres=
s those
> concerns (and possibly others raised in referenced thread) in the com=
mit
> message.

Yeah, I probably need to update the commit message to make that extra
clear, I just cherry-picked the old patch. This is still RFC anyway.

--=20
=46elipe Contreras
