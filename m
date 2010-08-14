From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] completion: make compatible with zsh
Date: Sat, 14 Aug 2010 03:52:57 +0000
Message-ID: <AANLkTiku8qgBcyYuy1eJDXsUsfMtSUuS525CVexTjRi9@mail.gmail.com>
References: <AANLkTimknF-m4_TYt+-vBBW0e3A-DY1nY93k7mPybdaD@mail.gmail.com>
	<1281757237-32656-1-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, spearce@spearce.org
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 14 05:53:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok7o8-0007nM-4u
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 05:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600Ab0HNDw7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 23:52:59 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38709 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757043Ab0HNDw6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Aug 2010 23:52:58 -0400
Received: by gyg10 with SMTP id 10so1213181gyg.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 20:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zATLZ62U4Vdq5Zvizwx5hu5f+N/ufF/It36Z7kd+Qmg=;
        b=OLUV6c/2d5k0aUpusjbbZ8kYinUgrfiITNfK+S+SMwAtdjvS6Bc5aSYvMET1Cf5oow
         ma+IYugj3TvPPfdIX9uwTJPO/fZgLJ4kErMQZu8DfJYTOKHLWsYMTU3QM5zoV0P1hqqq
         sd1ANyoblD2qhIwzRTAm4DJasW/ZNzHF4uYDI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=maLIcwTrAcSR77NoqTxwpYeWCRi9Ce/MlwD/BOz0mnYFdlPhtylJujp9VdMKdG7DAz
         KeBt2hCDrFjx1+TGkPV/tD88409TQFfacgmmiGEU+rk+cNSUMynqCNnxaINF1kM7qHfs
         4bgGKkBonBvhzBXSXT8Y1lK6KtNa9gvRXy7oU=
Received: by 10.231.159.204 with SMTP id k12mr2640162ibx.42.1281757977865;
 Fri, 13 Aug 2010 20:52:57 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Fri, 13 Aug 2010 20:52:57 -0700 (PDT)
In-Reply-To: <1281757237-32656-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153546>

On Sat, Aug 14, 2010 at 03:40, Mark Lodato <lodatom@gmail.com> wrote:
> On Fri, Aug 13, 2010 at 11:23 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son <avarab@gmail.com> wrote:
>> On Sat, Aug 14, 2010 at 03:17, Mark Lodato <lodatom@gmail.com> wrote=
:
>>> On Tue, Aug 3, 2010 at 10:57 PM, Mark Lodato <lodatom@gmail.com> wr=
ote:
>>>> Modify git-completion.bash to work with both bash and zsh. =C2=A0M=
ost code
>>>> works fine, but a few things need tweaking. =C2=A0Where possible, =
code is
>>>> written in such a way that both shells interpret fine, but some ar=
eas
>>>> need special-casing.
>>>
>>> Is there any interest in this patch, or anything I could do that wo=
uld
>>> make it more likely to be accepted? =C2=A0Perhaps at least some of =
these
>>> changes could be implemented.
>>
>> What's the Message-ID for that patch? I can't find it in my mailbox =
or
>> in a public archive (via Google).
>
> Thanks for letting me know.
>
> It appears that my initial message didn't go through. =C2=A0I used th=
e --to
> argument with 'git format-patch', but 'git send-email' didn't seem to
> parse it properly. =C2=A0It stuck an empty "To:" line at the normal p=
osition,
> and then put an additional "To: git@vger.kernel.org" at the bottom of
> the headers. =C2=A0Gmail must not have liked this.
>
> So, here's another shot. =C2=A0I am not too familiar with how the com=
pletion
> works, so the changed parts ought to be tested on both zsh and bash.
> Any suggestions on how to do so - or results from doing so - would be
> greatly appreciated.
>
> I tried to make as few changes to the main part of the script as
> possible, so that zsh compatibility does not get in the way of normal
> development. =C2=A0If anyone has any suggestions for improvement, ple=
ase let
> me know.
>
> If this should be split into separate patches, I can do that. =C2=A0E=
ach
> change is so small, I thought it would make more sense to roll them a=
ll
> into one.

It makes more sense as one patch.

It could use something in the comments at the top mentioning that this
is supposed to work on zsh too, otherwise it looks good (but I'm not
familiar with this code), it's a pretty minimal change for a big win.
