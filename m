From: jean-luc malet <jeanluc.malet@gmail.com>
Subject: Re: [PATCH 3/3] builtin-merge: add support for default merge options
Date: Fri, 2 Apr 2010 19:19:44 +0200
Message-ID: <h2m1de9d39c1004021019sd8e8bf79ide3f0516353c069c@mail.gmail.com>
References: <cover.1236377358.git.jaysoffian@gmail.com>
	 <9f755b5bae0b02c5cb3e01680acf71fe7153be04.1236377358.git.jaysoffian@gmail.com>
	 <7vr61aqngu.fsf@gitster.siamese.dyndns.org>
	 <76718490903061516l62869424q4bd4cfa64fe2195e@mail.gmail.com>
	 <7v63imqhcz.fsf@gitster.siamese.dyndns.org>
	 <76718490903061756g4ca88c21h8bf786048d4ad05@mail.gmail.com>
	 <7vzlfxpzqq.fsf@gitster.siamese.dyndns.org>
	 <1de9d39c0903071131pdb2b125hce7c49642843c9f8@mail.gmail.com>
	 <1de9d39c1003190719q10b2f019u3d4f148b9feb587d@mail.gmail.com>
	 <76718491003190754l217e1247t16b7f1b9f39c6182@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 02 19:19:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxkXD-00076d-4T
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 19:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755701Ab0DBRTu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Apr 2010 13:19:50 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:64410 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754918Ab0DBRTt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Apr 2010 13:19:49 -0400
Received: by fxm27 with SMTP id 27so557938fxm.28
        for <git@vger.kernel.org>; Fri, 02 Apr 2010 10:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=K0Y5jO/rJn3SNPQdmPRixRaIdaXl/d4p2BbtJ1UrgKU=;
        b=H36HSi0+V0lwfUFP846KrGGYEtTJdg37QZ6FOMrsFM0i5dpzjpBYT4vN5m6JA4B6gR
         wUJFsadVpYiYr6aQcL5Pw83EsHuogGCSOGSHeAZ87ou4oRzDGrJLX9eBep/NZaSLSE6x
         NW4zDKdhZLnKmZHCgGZbCdSfs7yDLnf1Frj9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VQoSaqJpNrCzM/sh/5R27gEWsb9Xpg5DTA8bIg4bysuTgQMLywlkOM1WKGOkVSciJd
         IekKlZMtCj4n505MlEafaiX0yVrRe9us2DQ+4hw/mRguyT42BdW1N2js1QesPp1GbS8w
         jPcQMvmp8F56ebL9yphIcwUMN69Ip766bVGTo=
Received: by 10.239.169.145 with HTTP; Fri, 2 Apr 2010 10:19:44 -0700 (PDT)
In-Reply-To: <76718491003190754l217e1247t16b7f1b9f39c6182@mail.gmail.com>
Received: by 10.239.135.131 with SMTP id d3mr185862hbd.212.1270228784361; Fri, 
	02 Apr 2010 10:19:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143828>

Is there someone that can review this patch and maybe include it into
next GIT release?
I think it is really usefull especially when used in company
environment where default policies have to be set
thanks and regards
JLM

On Fri, Mar 19, 2010 at 3:54 PM, Jay Soffian <jaysoffian@gmail.com> wro=
te:
> On Fri, Mar 19, 2010 at 10:19 AM, jean-luc malet
> <jeanluc.malet@gmail.com> wrote:
>> Hi!
>> I would like to know the status about this patch...
>> I think this is a useful feature to have a default configuration
>> settable for all branch.<name>.* options
>> thanks and regards
>
> I lost interest in it apparently. I see it's still marked in my TODO,
> but I haven't had any personal time to spend on git lately.
>
> j.
>
>> On Sat, Mar 7, 2009 at 8:31 PM, jean-luc malet <jeanluc.malet@gmail.=
com> wrote:
>>> as a user,
>>> 1) I looked how to override defaults, since merge seems to use --ff=
 as
>>> default, I looked if there was any global config to override that.
>>> nothing found... so go back to google
>>> 2) I found on the web that we can set it using
>>> branch.branchname.mergeoptions so I said "what if I use a branch na=
med
>>> *, the config file was correct and git didn't insult me so.... but =
not
>>> the expected result...
>>>
>>> since the commands have allready defaults builtin, why not storing
>>> thoses defaults in the config file? like this it's easier to update
>>> them or change the way git behave....
>>> JLM
>>>
>>> On Sat, Mar 7, 2009 at 8:18 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>>> Jay Soffian <jaysoffian@gmail.com> writes:
>>>>
>>>>> On Fri, Mar 6, 2009 at 7:58 PM, Junio C Hamano <gitster@pobox.com=
> wrote:
>>>>>> I think it would be much better if you did not introduce a new
>>>>>> configuration merge.options which is not consistent with everyth=
ing else
>>>>>> to begin with.
>>>>>>
>>>>>> Instead, if your addition was literally to allow saying things l=
ike this,
>>>>>> it would be much easier to understand.
>>>>>>
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0[branch "*"]
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mergeopti=
ons =3D ...
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0remote =3D=
 origin
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rebase =3D=
 true
>>>>>
>>>>> Okay. That's probably a more invasive patch, because a lot more c=
ode
>>>>> paths look at [branch ...], but I'll look into it.
>>>>
>>>> Note that you do not have to cover branch.*.remote and other thing=
s in the
>>>> same patch. =C2=A0The first one could just handle branch.*.mergeop=
tions and you
>>>> can let later patches to implement the fallbacks for other variabl=
es.
>>>>
>>>>
>>>
>>>
>>>
>>> --
>>> KISS! (Keep It Simple, Stupid!)
>>> (garde le simple, imb=C3=A9cile!)
>>> "mais qu'est-ce que tu m'as pondu comme usine =C3=A0 gaz? fait des =
choses
>>> simples et qui marchent, esp=C3=A8ce d'imb=C3=A9cile!"
>>> -----------------------------
>>> "Si vous pensez que vous =C3=AAtes trop petit pour changer quoique =
ce soit,
>>> essayez donc de dormir avec un moustique dans votre chambre." Betty
>>> Reese
>>> http://www.grainesdechangement.com/citations.htm
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



--=20
KISS! (Keep It Simple, Stupid!)
(garde le simple, imb=C3=A9cile!)
"mais qu'est-ce que tu m'as pondu comme usine =C3=A0 gaz? fait des chos=
es
simples et qui marchent, esp=C3=A8ce d'imb=C3=A9cile!"
-----------------------------
"Si vous pensez que vous =C3=AAtes trop petit pour changer quoique ce s=
oit,
essayez donc de dormir avec un moustique dans votre chambre." Betty
Reese
http://www.grainesdechangement.com/citations.htm
