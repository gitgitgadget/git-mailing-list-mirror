From: Michael Witten <mfwitten@gmail.com>
Subject: Re: In favor of "git commit --no-parent"
Date: Thu, 29 Sep 2011 22:01:02 +0000
Message-ID: <CAMOZ1BvJXmGj=vE+BGSg0ZNSo1-s6XKS48hVinRMPAMqfOoH0A@mail.gmail.com>
References: <1316960136073-6829212.post@n2.nabble.com> <1316961212.4388.5.camel@centaur.lab.cmartin.tk>
 <7vaa9r2jii.fsf@alter.siamese.dyndns.org> <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
 <vpq39fi9gf5.fsf@bauges.imag.fr> <69d6fb3199bc4f74b25dae7992a9f132-mfwitten@gmail.com>
 <vpqsjni6kkk.fsf@bauges.imag.fr> <553B5FA1A43748B1ADD759572EADA6FF@PhilipOakley>
 <e4f46b39e9ed4203bfab8a81e25eb600-mfwitten@gmail.com> <7vaa9oz9rl.fsf@alter.siamese.dyndns.org>
 <271cc2ed03774b4988bb61cb3e79750e-mfwitten@gmail.com> <7vmxdnte0j.fsf@alter.siamese.dyndns.org>
 <CABURp0q4wi5ruLmeaZtN=8QvuX2ftSFQo1uJL0_8-wtm1nYaGA@mail.gmail.com>
 <CAMOZ1Bs9kei58AVJZRJM4g+Nh3QaY8dtUBctmLL8SVL3XW=aLw@mail.gmail.com> <CABURp0qEyQB37Zx75Xa6EEocnJeWiAGdkFqO7iZw_B_hg69hRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Raible <raible@nextest.com>,
	Philip Oakley <philipoakley@iee.org>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 30 00:01:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9Ofi-0000XS-7h
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 00:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998Ab1I2WBd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Sep 2011 18:01:33 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47047 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640Ab1I2WBc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2011 18:01:32 -0400
Received: by ywb5 with SMTP id 5so964611ywb.19
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 15:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=IC5sS50JojmHapYdi5qJv/TADF6cxY+IC/+i7ok2Zto=;
        b=DIKWXsnkgh2pBqyOZg+hCfslecBGmtZcVqRQJxlg/mUBgF8XB99YLgqI+wsPnREKFE
         uKQoi7llKB2libWB8Xzn3MedTTOXXH76PS2BSobSe6Mu/IOGSp1Nfvsfs+Sv4FvPSaEI
         gA39F014MV/sPTIh4H8wopLk+ZTmeF3A6zbj4=
Received: by 10.42.18.74 with SMTP id w10mr1547050ica.164.1317333692077; Thu,
 29 Sep 2011 15:01:32 -0700 (PDT)
Received: by 10.42.171.194 with HTTP; Thu, 29 Sep 2011 15:01:02 -0700 (PDT)
In-Reply-To: <CABURp0qEyQB37Zx75Xa6EEocnJeWiAGdkFqO7iZw_B_hg69hRg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182446>

On Thu, Sep 29, 2011 at 21:50, Phil Hord <phil.hord@gmail.com> wrote:
> On Thu, Sep 29, 2011 at 5:28 PM, Michael Witten <mfwitten@gmail.com> =
wrote:
>> On Thu, Sep 29, 2011 at 21:02, Phil Hord <phil.hord@gmail.com> wrote=
:
>>> I think a user looking for this functionality -- either a new git u=
ser
>>> or a user who seldom uses the "create secondary root commit" comman=
d
>>> -- would first try 'git help init'. =C2=A0It seems logical to me th=
at I
>>> should be able to do this:
>>>
>>> =C2=A0cd my-git-repo
>>> =C2=A0git init --root=3D<newbranch> .
>>>
>>> This feels natural to me for this operation.
>>
>> That would be a good place for the "git checkout --no-parent" varian=
t,
>> especially given that I think "git checkout --no-parent" should prod=
uce
>> an empty working tree and index, which we can all note is essentiall=
y
>> what "git init" gives us.
>>
>> Your suggestion seems like a corroboration of my stance.
>
> I'm not arguing the functionality; just the command spelling.
> Consider your stance corroborated.
>
> I don't like "git checkout" for this because
> 1. git-checkout is too popular already; oddball functions like this
> should live in the shadows.
> 2. git-checkout is conceptually wrong, imho. =C2=A0git-checkout means
> "fetch me this commit" or "fetch me files from this commit".
> Technically it does the same thing that we're talking about here (it
> frobs the index, the workdir and HEAD), but conceptually it is very
> different.
>
> Conceptually, I think the functionality you're talking about is more
> akin to git-init.

Actually, I'd say that the purpose of "git checkout" is to set the
working tree and index; in that sense, "git init" could in fact be
implemented by using "git checkout".

The key to what I'm saying, though, is that 2 scenarios are involved:

  * Make a root starting with nothing.
  * Make a root based off something.

The user should be able to express that, so that commands like
"git status" make sense. Currently, the user is only able
to express the first scenario:

  * Make a root starting with nothing.

but existing stuff is automatically added in case the user
wants to do the second scenario, but that makes "git status"
essentially unusuable for the second scenario, anyway.
