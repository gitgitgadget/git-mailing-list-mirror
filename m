From: jean-luc malet <jeanluc.malet@gmail.com>
Subject: Re: [PATCH 3/3] builtin-merge: add support for default merge options
Date: Fri, 19 Mar 2010 15:19:51 +0100
Message-ID: <1de9d39c1003190719q10b2f019u3d4f148b9feb587d@mail.gmail.com>
References: <cover.1236377358.git.jaysoffian@gmail.com>
	 <12addb53ef5c0e62ee22847591c8e7b884dc0bd2.1236377358.git.jaysoffian@gmail.com>
	 <13f0016028b195541b8b5d9149292150cbb13ab7.1236377358.git.jaysoffian@gmail.com>
	 <9f755b5bae0b02c5cb3e01680acf71fe7153be04.1236377358.git.jaysoffian@gmail.com>
	 <7vr61aqngu.fsf@gitster.siamese.dyndns.org>
	 <76718490903061516l62869424q4bd4cfa64fe2195e@mail.gmail.com>
	 <7v63imqhcz.fsf@gitster.siamese.dyndns.org>
	 <76718490903061756g4ca88c21h8bf786048d4ad05@mail.gmail.com>
	 <7vzlfxpzqq.fsf@gitster.siamese.dyndns.org>
	 <1de9d39c0903071131pdb2b125hce7c49642843c9f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 15:19:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsd3P-0005qO-24
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 15:19:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751Ab0CSOTy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Mar 2010 10:19:54 -0400
Received: from mail-fx0-f219.google.com ([209.85.220.219]:44766 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716Ab0CSOTx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 10:19:53 -0400
Received: by fxm19 with SMTP id 19so635953fxm.21
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 07:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=b3eXJ4HRvYvM7QZIsSu2QRmh8LuJkmq/xsXlLJIpiKI=;
        b=lbEdp86TMzAcGIm9qhgYhSBZpmYd2AA3gxQvDrnQDpeU2y74TwmBu8sB3/QueWC2w0
         ixZJ3wu/g7B4118X18FRJ3hBV17GH4k+uGSZQaSxD33zao53aA3WkFykZJylYnqA/Dv+
         83V8tm4iWNxZoYP8s/LRPqLdjzaH9ca+IrxeA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aaYLAktnxF2zyabJTF73RDy+wm5J6sZBle7cmI50BkGfJqlqAOlrtMatNifWCF7/8a
         8ljMi+BjooO67vcUKhw3bv2+y87SYXdKi7ie9yYFobazHctGmixbdNqV7iz23HVNVx8O
         NUn3dlFatDhPUKp553Z51iHnw9F5z3pxHejg4=
Received: by 10.239.165.73 with SMTP id w9mr1259584hbd.144.1269008391214; Fri, 
	19 Mar 2010 07:19:51 -0700 (PDT)
In-Reply-To: <1de9d39c0903071131pdb2b125hce7c49642843c9f8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142601>

Hi!
I would like to know the status about this patch...
I think this is a useful feature to have a default configuration
settable for all branch.<name>.* options
thanks and regards
JLM

On Sat, Mar 7, 2009 at 8:31 PM, jean-luc malet <jeanluc.malet@gmail.com=
> wrote:
> as a user,
> 1) I looked how to override defaults, since merge seems to use --ff a=
s
> default, I looked if there was any global config to override that.
> nothing found... so go back to google
> 2) I found on the web that we can set it using
> branch.branchname.mergeoptions so I said "what if I use a branch name=
d
> *, the config file was correct and git didn't insult me so.... but no=
t
> the expected result...
>
> since the commands have allready defaults builtin, why not storing
> thoses defaults in the config file? like this it's easier to update
> them or change the way git behave....
> JLM
>
> On Sat, Mar 7, 2009 at 8:18 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> Jay Soffian <jaysoffian@gmail.com> writes:
>>
>>> On Fri, Mar 6, 2009 at 7:58 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>>> I think it would be much better if you did not introduce a new
>>>> configuration merge.options which is not consistent with everythin=
g else
>>>> to begin with.
>>>>
>>>> Instead, if your addition was literally to allow saying things lik=
e this,
>>>> it would be much easier to understand.
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0[branch "*"]
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mergeoption=
s =3D ...
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0remote =3D =
origin
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rebase =3D =
true
>>>
>>> Okay. That's probably a more invasive patch, because a lot more cod=
e
>>> paths look at [branch ...], but I'll look into it.
>>
>> Note that you do not have to cover branch.*.remote and other things =
in the
>> same patch. =C2=A0The first one could just handle branch.*.mergeopti=
ons and you
>> can let later patches to implement the fallbacks for other variables=
=2E
>>
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
