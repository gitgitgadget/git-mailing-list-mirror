From: Eric Frederich <eric.frederich@gmail.com>
Subject: Re: [BUG] gitk
Date: Wed, 8 Jun 2016 08:31:15 -0400
Message-ID: <CAAoZyYNMq2+JzrJ0Vm+kbqF0oNFr5kwyczuQSvUi_oxVen-E=Q@mail.gmail.com>
References: <CAAoZyYNnWk-yE9TG_Fpxxs-oRN-yEsm_YFs+Ej7muQ+5YCW43w@mail.gmail.com>
 <4c22a048-ad42-c831-e167-5be5540bdb49@atlas-elektronik.com> <2103a5a2-6936-0d2c-9a07-bb0713153d82@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: stefan.naewe@atlas-elektronik.com
X-From: git-owner@vger.kernel.org Wed Jun 08 14:31:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAcdq-0002oY-Ty
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 14:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425126AbcFHMbS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2016 08:31:18 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:36290 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425118AbcFHMbQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2016 08:31:16 -0400
Received: by mail-vk0-f65.google.com with SMTP id x7so1023644vkf.3
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 05:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qUnxTDdgWhnKVoVsGToXcHoq85NukNgesboPx8WQ9KU=;
        b=vDZ9QaY505pdwhy5sxS3KS0/sGuampl5+4KjrbmzkpfitFa/hWfZ0O7a2Fq6L5Q4Rd
         S040W0D3f8G2VcKup/FoKTJBAiVaEuTTDiEQhjbRQph3QavupgTdmPm+y0p+cVRPT/k8
         TdKSWfvYpIeYlrlBOH0rzQzlZ7POVCrjoz9+StAummYlGSTnseZNfkfuAV4Bbs+f7Jok
         DsSYn4keM6Cdcb/aBdQG1L8hNZCndie2UwjGVCPxKliijsuDUGQjBBPk34b9w82XLFmx
         ecftplR6GmvxokLUAuWYn2AV5CiTRELU0GC9XD05li0WwbCZcKdLbk+Fev+7bPvykF/4
         QzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qUnxTDdgWhnKVoVsGToXcHoq85NukNgesboPx8WQ9KU=;
        b=Ui5aCjm4xg4WYBXoxpZWk/ZHzxiwFRC8NTEeEgMXK0oUVHqXJUpwPRQeC9mEBlgfkz
         qX/xx4HS6vjvCzBQuBeJJ+RIaM+OnR0VAZi+ilapNXTfzGb3QgVrEGn/RMP9ry9RlEiL
         1IDsvEintu6gQAUOazweA0Ecpc52bYsiMgPKSEkiEOSXLZK+Es+70uHWzh0qeGwZxrDB
         caPg+zKuo7L69j8dIojWwV5T9c8TCQpWBe4/Zxg6UtR0c+WZD6Uq3e5iKjiXipyDRZId
         8ByDmCLKunSOFr//4UQuq0wTDcIdjLVcLkXyrutrP0yNjvFhJsq4TVVu9pKLD6iMJrHV
         +Lcg==
X-Gm-Message-State: ALyK8tL/MTp2m9xeANeI8zcK7YC03BvaAlUdO/eHsFN9WJrq1jKjMFGFXRrOjDV4PlesUNy2B7UEQFUH42tWow==
X-Received: by 10.31.72.66 with SMTP id v63mr2077197vka.29.1465389075537; Wed,
 08 Jun 2016 05:31:15 -0700 (PDT)
Received: by 10.159.37.230 with HTTP; Wed, 8 Jun 2016 05:31:15 -0700 (PDT)
In-Reply-To: <2103a5a2-6936-0d2c-9a07-bb0713153d82@atlas-elektronik.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296785>

Thanks for confirming.  I do a similar workaround too.
The issue is when new Git users don't even have a ~/.config/git/gitk to=
 modify.
They first have to run it natively where lime exists, then they can
edit it and use it over VNC.

I cannot find any instructions for submitting patches to the gitk subpr=
oject.
Does anyone know the process for this?

After looking at the original commit which caused this
(66db14c94c95f911f55575c7fdf74c026443d482)...
=2E.. reverting may not be the right thing to do.
Instead, lime should be replaced with "#32cd32", a trivial fix.

Again, I'd do this myself if I had instructions for submitting patches
for to gitk.

Thanks,
~Eric

On Wed, Jun 8, 2016 at 5:58 AM,  <stefan.naewe@atlas-elektronik.com> wr=
ote:
> Am 08.06.2016 um 11:40 schrieb stefan.naewe@atlas-elektronik.com:
>> Am 07.06.2016 um 21:20 schrieb Eric Frederich:
>>> Hello,
>>>
>>> I couldn=E2=80=99t find any documentation on submitting patches for=
 gitk.
>>> I saw in Documentation/SubmittingPatches that gitk is maintained in
>>> its own repo.
>>> I can=E2=80=99t clone repo=E2=80=99s unless they=E2=80=99re http wh=
ile on my corporate proxy.
>>> I=E2=80=99m hoping someone can help me out or just do it for me ;-)
>>> I=E2=80=99d like to revert 66db14c94c95f911f55575c7fdf74c026443d482=
=2E
>>>
>>> That commit just renamed =E2=80=9Cgreen=E2=80=9D to =E2=80=9Clime=E2=
=80=9D
>>> It causes gitk to not start up on when ran through VNC.
>>> It works fine on that same system natively or over X11 forwarding b=
ut not VNC.
>>
>> FWIW, I can confirm that.
>>
>> git version 2.8.3
>>
>> My $HOME/.config/git/gitk contains:
>>
>> set mergecolors {red blue green purple brown "#009090" magenta "#808=
000" "#009000" "#ff0080" cyan "#b07070" "#70b0f0" "#70f0b0" "#f0b070" "=
#ff70b0"}
>>
>> With that file gitk runs without problems.
>> If I move that file away, gitk stops working over VNC and also forwa=
rded X11 for me.
>
> More Info:
>
> The forwarded X11 (which is from a Windows machine running Exceed to =
a Linux machine) works
> without the gitk file mentioned above, if I edit the 'rgb.txt' used b=
y Exceed to contain something like:
>
>  50 205  50             lime
>
> Before the editing the file only contained the following:
>
>  50 205  50             lime green
>  50 205  50             LimeGreen
>
> I couldn't do the same for the VNC connection though (Xvnc seems to u=
se a hardcoded 'rgb.txt' file).
>
> It seems that using 'lime' was not the best choice...
>
>
> HTH
>
> Stefan
> --
> ----------------------------------------------------------------
> /dev/random says: I used to be schizophrenic, but we're all right now=
=2E
> python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726=
f6e696b2e636f6d'.decode('hex')"
> GPG Key fingerprint =3D 2DF5 E01B 09C3 7501 BCA9  9666 829B 49C5 9221=
 27AF
>
