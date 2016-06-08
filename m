From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [BUG] gitk
Date: Wed, 8 Jun 2016 11:36:38 -0400
Message-ID: <CANoM8SXOMcyzt-ub1qnOPRN=7oKwcYzS7iY2zw1RfUiLcV-SSQ@mail.gmail.com>
References: <CAAoZyYNnWk-yE9TG_Fpxxs-oRN-yEsm_YFs+Ej7muQ+5YCW43w@mail.gmail.com>
 <4c22a048-ad42-c831-e167-5be5540bdb49@atlas-elektronik.com>
 <2103a5a2-6936-0d2c-9a07-bb0713153d82@atlas-elektronik.com> <CAAoZyYNMq2+JzrJ0Vm+kbqF0oNFr5kwyczuQSvUi_oxVen-E=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: stefan.naewe@atlas-elektronik.com,
	Git Mailing List <git@vger.kernel.org>
To: Eric Frederich <eric.frederich@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 17:41:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAfXj-00026Q-Kb
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 17:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423230AbcFHPhJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2016 11:37:09 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:34569 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1160993AbcFHPg7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2016 11:36:59 -0400
Received: by mail-vk0-f67.google.com with SMTP id a126so1947097vkb.1
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 08:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c4eLocscRK920zEq6J0gVGTjsKDNpgDHbBrycv9eLFk=;
        b=J31GKHMAKx7/wnPBJ/2OBDNkdSEiAJ5Jnz6u376DmcL6JcWfLUnwtnB4jCOSrJBqOl
         b1Hr9z7NNp0allb7TADZn/5tmHjqhl3gmeXJCghVNbFPB/AUNtjPLKMAjakaxLAuZrqk
         K50t2Gmtwen/EAfeGuCQNriRH1Ke2mxxmxdbTEFSAVt5gZgCikbB98SAnXpoIk7yKaLa
         7JfGhYcxz5CLxAef9Lg0gUSA2jr5zptoToRCk2Pv34eVFB9Sp+fujrLUtsd8WdTfJEgs
         cO/Ivya76SVhS1RubbPmExu7arnrkbSawXuS//m/h2OA/XR+ZaXRB3mZPTFEqaDmz1nA
         w+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c4eLocscRK920zEq6J0gVGTjsKDNpgDHbBrycv9eLFk=;
        b=d0sjzOoSa0ms8Z4Vcx6a+du1hb5qf5l1Esu7+MbeDs2HKUxsfBP3cL5sluD7CTN+I8
         zezQOWSMJMHqvo0KiYUXKaR4p9gSPpNtAUFLThQ3i+iRIq0HkJ4LtP8Z88iqe6fVySb2
         o/J/HcVeReAmwCl3kIwzhg40AzpaZwWVamg/9CO7Fhe5J58gtQqD93mREgAz/+LvN6cR
         gitrSzDeimi2tp1giHFByf3lyL0Xho9LZvkHxgaULn6XlSdNtdmgs0LX4JCn7lgGvbe7
         gI7QxNQGNoSk1X2ArJVt1rwzDZxEifsDgIWyZyjIXcdWhFFX+yofriN9JSQw0ZOo3DqE
         p4Lw==
X-Gm-Message-State: ALyK8tIHlmnZfztsMaG++1LvPIzm8fkLxwAajjCWTYWCfFPvkhdHDvb4xp3gMU2q+ODuHlGcjNHcsRVq57u1qQ==
X-Received: by 10.159.35.207 with SMTP id 73mr2578042uao.13.1465400218158;
 Wed, 08 Jun 2016 08:36:58 -0700 (PDT)
Received: by 10.159.38.107 with HTTP; Wed, 8 Jun 2016 08:36:38 -0700 (PDT)
In-Reply-To: <CAAoZyYNMq2+JzrJ0Vm+kbqF0oNFr5kwyczuQSvUi_oxVen-E=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296806>

On Wed, Jun 8, 2016 at 8:31 AM, Eric Frederich <eric.frederich@gmail.co=
m> wrote:
> Thanks for confirming.  I do a similar workaround too.
> The issue is when new Git users don't even have a ~/.config/git/gitk =
to modify.
> They first have to run it natively where lime exists, then they can
> edit it and use it over VNC.
>
> I cannot find any instructions for submitting patches to the gitk sub=
project.
> Does anyone know the process for this?
>
> After looking at the original commit which caused this
> (66db14c94c95f911f55575c7fdf74c026443d482)...
> ... reverting may not be the right thing to do.
> Instead, lime should be replaced with "#32cd32", a trivial fix.
>
> Again, I'd do this myself if I had instructions for submitting patche=
s
> for to gitk.

You should be able to submit patches for gitk right here.  There is
information right in
Documentation/SubmittingPatches [1]. The primary difference is that
you should clone
gitk and build your patch from that.  You would git format-patch and
git send-email in
the same way.

[1] https://github.com/git/git/blob/master/Documentation/SubmittingPatc=
hes#L319


> Thanks,
> ~Eric
>
> On Wed, Jun 8, 2016 at 5:58 AM,  <stefan.naewe@atlas-elektronik.com> =
wrote:
>> Am 08.06.2016 um 11:40 schrieb stefan.naewe@atlas-elektronik.com:
>>> Am 07.06.2016 um 21:20 schrieb Eric Frederich:
>>>> Hello,
>>>>
>>>> I couldn=E2=80=99t find any documentation on submitting patches fo=
r gitk.
>>>> I saw in Documentation/SubmittingPatches that gitk is maintained i=
n
>>>> its own repo.
>>>> I can=E2=80=99t clone repo=E2=80=99s unless they=E2=80=99re http w=
hile on my corporate proxy.
>>>> I=E2=80=99m hoping someone can help me out or just do it for me ;-=
)
>>>> I=E2=80=99d like to revert 66db14c94c95f911f55575c7fdf74c026443d48=
2.
>>>>
>>>> That commit just renamed =E2=80=9Cgreen=E2=80=9D to =E2=80=9Clime=E2=
=80=9D
>>>> It causes gitk to not start up on when ran through VNC.
>>>> It works fine on that same system natively or over X11 forwarding =
but not VNC.
>>>
>>> FWIW, I can confirm that.
>>>
>>> git version 2.8.3
>>>
>>> My $HOME/.config/git/gitk contains:
>>>
>>> set mergecolors {red blue green purple brown "#009090" magenta "#80=
8000" "#009000" "#ff0080" cyan "#b07070" "#70b0f0" "#70f0b0" "#f0b070" =
"#ff70b0"}
>>>
>>> With that file gitk runs without problems.
>>> If I move that file away, gitk stops working over VNC and also forw=
arded X11 for me.
>>
>> More Info:
>>
>> The forwarded X11 (which is from a Windows machine running Exceed to=
 a Linux machine) works
>> without the gitk file mentioned above, if I edit the 'rgb.txt' used =
by Exceed to contain something like:
>>
>>  50 205  50             lime
>>
>> Before the editing the file only contained the following:
>>
>>  50 205  50             lime green
>>  50 205  50             LimeGreen
>>
>> I couldn't do the same for the VNC connection though (Xvnc seems to =
use a hardcoded 'rgb.txt' file).
>>
>> It seems that using 'lime' was not the best choice...
>>
>>
>> HTH
>>
>> Stefan
>> --
>> ----------------------------------------------------------------
>> /dev/random says: I used to be schizophrenic, but we're all right no=
w.
>> python -c "print '73746566616e2e6e616577654061746c61732d656c656b7472=
6f6e696b2e636f6d'.decode('hex')"
>> GPG Key fingerprint =3D 2DF5 E01B 09C3 7501 BCA9  9666 829B 49C5 922=
1 27AF
>>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
