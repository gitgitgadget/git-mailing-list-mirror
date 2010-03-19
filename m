From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 3/3] builtin-merge: add support for default merge options
Date: Fri, 19 Mar 2010 10:54:46 -0400
Message-ID: <76718491003190754l217e1247t16b7f1b9f39c6182@mail.gmail.com>
References: <cover.1236377358.git.jaysoffian@gmail.com>
	 <13f0016028b195541b8b5d9149292150cbb13ab7.1236377358.git.jaysoffian@gmail.com>
	 <9f755b5bae0b02c5cb3e01680acf71fe7153be04.1236377358.git.jaysoffian@gmail.com>
	 <7vr61aqngu.fsf@gitster.siamese.dyndns.org>
	 <76718490903061516l62869424q4bd4cfa64fe2195e@mail.gmail.com>
	 <7v63imqhcz.fsf@gitster.siamese.dyndns.org>
	 <76718490903061756g4ca88c21h8bf786048d4ad05@mail.gmail.com>
	 <7vzlfxpzqq.fsf@gitster.siamese.dyndns.org>
	 <1de9d39c0903071131pdb2b125hce7c49642843c9f8@mail.gmail.com>
	 <1de9d39c1003190719q10b2f019u3d4f148b9feb587d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: jean-luc malet <jeanluc.malet@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 15:54:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsdbB-0005Oa-FN
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 15:54:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529Ab0CSOys convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Mar 2010 10:54:48 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48170 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401Ab0CSOyr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 10:54:47 -0400
Received: by pwi5 with SMTP id 5so1271374pwi.19
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 07:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SvVCU9SCEnY9p/aDP/slKw1ureyNKccZ3D3ToKNZ5ss=;
        b=CJxesoDY7iuLIkxm9+/LR7qrnoYX++wsjI09kzpfeyx0KgKW40i29rz5N4GJo/J7UJ
         y2MKKgtyVFDJdAeNOSZKIWuzdUJBoMu51Wpt0SqOOxTQFrIP0oyF0fuwR3oRtxz2Uvfi
         ZDZoI5IYoo6QVaq8wyB7qLdcIHC+rPDnLxPZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KOFMeAXTIysNyZ3Q0NbkIuN91pVlZZZm/Ie7jzHOcDJJZzZsX8IA8Bg8OVKFFZSDDe
         JGiGO58t+8ucliN5kIi2vByShzJjyThDtyRy3El423aeWWYeMxTef08/5lRIfi7mMWiO
         8U+BZL/o/yvwHpTVflb4E5Sg4HTFH0kW9y6BI=
Received: by 10.140.247.16 with SMTP id u16mr3526250rvh.242.1269010486578; 
	Fri, 19 Mar 2010 07:54:46 -0700 (PDT)
In-Reply-To: <1de9d39c1003190719q10b2f019u3d4f148b9feb587d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142607>

On Fri, Mar 19, 2010 at 10:19 AM, jean-luc malet
<jeanluc.malet@gmail.com> wrote:
> Hi!
> I would like to know the status about this patch...
> I think this is a useful feature to have a default configuration
> settable for all branch.<name>.* options
> thanks and regards

I lost interest in it apparently. I see it's still marked in my TODO,
but I haven't had any personal time to spend on git lately.

j.

> On Sat, Mar 7, 2009 at 8:31 PM, jean-luc malet <jeanluc.malet@gmail.c=
om> wrote:
>> as a user,
>> 1) I looked how to override defaults, since merge seems to use --ff =
as
>> default, I looked if there was any global config to override that.
>> nothing found... so go back to google
>> 2) I found on the web that we can set it using
>> branch.branchname.mergeoptions so I said "what if I use a branch nam=
ed
>> *, the config file was correct and git didn't insult me so.... but n=
ot
>> the expected result...
>>
>> since the commands have allready defaults builtin, why not storing
>> thoses defaults in the config file? like this it's easier to update
>> them or change the way git behave....
>> JLM
>>
>> On Sat, Mar 7, 2009 at 8:18 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>>> Jay Soffian <jaysoffian@gmail.com> writes:
>>>
>>>> On Fri, Mar 6, 2009 at 7:58 PM, Junio C Hamano <gitster@pobox.com>=
 wrote:
>>>>> I think it would be much better if you did not introduce a new
>>>>> configuration merge.options which is not consistent with everythi=
ng else
>>>>> to begin with.
>>>>>
>>>>> Instead, if your addition was literally to allow saying things li=
ke this,
>>>>> it would be much easier to understand.
>>>>>
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0[branch "*"]
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mergeoptio=
ns =3D ...
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0remote =3D=
 origin
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rebase =3D=
 true
>>>>
>>>> Okay. That's probably a more invasive patch, because a lot more co=
de
>>>> paths look at [branch ...], but I'll look into it.
>>>
>>> Note that you do not have to cover branch.*.remote and other things=
 in the
>>> same patch. =C2=A0The first one could just handle branch.*.mergeopt=
ions and you
>>> can let later patches to implement the fallbacks for other variable=
s.
>>>
>>>
>>
>>
>>
>> --
>> KISS! (Keep It Simple, Stupid!)
>> (garde le simple, imb=C3=A9cile!)
>> "mais qu'est-ce que tu m'as pondu comme usine =C3=A0 gaz? fait des c=
hoses
>> simples et qui marchent, esp=C3=A8ce d'imb=C3=A9cile!"
>> -----------------------------
>> "Si vous pensez que vous =C3=AAtes trop petit pour changer quoique c=
e soit,
>> essayez donc de dormir avec un moustique dans votre chambre." Betty
>> Reese
>> http://www.grainesdechangement.com/citations.htm
>>
>
>
>
> --
> KISS! (Keep It Simple, Stupid!)
> (garde le simple, imb=C3=A9cile!)
> "mais qu'est-ce que tu m'as pondu comme usine =C3=A0 gaz? fait des ch=
oses
> simples et qui marchent, esp=C3=A8ce d'imb=C3=A9cile!"
> -----------------------------
> "Si vous pensez que vous =C3=AAtes trop petit pour changer quoique ce=
 soit,
> essayez donc de dormir avec un moustique dans votre chambre." Betty
> Reese
> http://www.grainesdechangement.com/citations.htm
>
