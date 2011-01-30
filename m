From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH] git-p4: Corrected typo.
Date: Sun, 30 Jan 2011 23:21:50 +0000
Message-ID: <AANLkTi=PPN69uuJmUBDHKtmn59DzUbdk=Qu4Ug-kok89@mail.gmail.com>
References: <1290130693-30855-2-git-send-email-vitor.hda@gmail.com>
 <1290648419-6107-1-git-send-email-vitor.hda@gmail.com> <AANLkTimQhFzEXr=T9F8TJzTeWwKroTt_BG87RtQCLivv@mail.gmail.com>
 <AANLkTikeB724f_vE6qvu1h1o5JG150mcmaHVBjLkOEWP@mail.gmail.com> <AANLkTimLQxiB=dnd6=iB5uEpzOSfqks=FDJ=xORehuw8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Berg <merlin66b@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 31 00:22:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjgbD-000120-5O
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 00:22:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755153Ab1A3XWW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Jan 2011 18:22:22 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59373 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755060Ab1A3XWV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jan 2011 18:22:21 -0500
Received: by vws16 with SMTP id 16so1793844vws.19
        for <git@vger.kernel.org>; Sun, 30 Jan 2011 15:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=uOPxr4xla3Cfmf1W8uS5xbmQcPeYpDSfkD174/lk1gc=;
        b=WV6YDr9LDf5XaVMwqNTuzWStYlLgeQ7SCZrQxcYJzHAQjgF970m6JK0NVc7c2eLhpq
         X2fR5kGnwuKMBqHH+u5V9WO/AmJxWzpD30nHIzskt6JfGNIvU5gJ63N2/HBaVglNj8Et
         f3da02UZBj3KtWlpsNqoFPzL0mEt4ylZ141FU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=mJvVb3qiIpvc5fK8zDh4YxK0B9qo9/pMq9m+dTB/1CD4Srk46VqOMsw/QTweoh2KBV
         ykEdkyotCmBrwnJ4x+Hh23lYjQ4YWOOvjYExxdjvKi701CwmW7HEsOfuPRJf3Gd1MYGI
         EaKMCfCZPZ/zfSPCy2gZX3tfIknMZLJt3j+HA=
Received: by 10.220.191.199 with SMTP id dn7mr1471482vcb.239.1296429740365;
 Sun, 30 Jan 2011 15:22:20 -0800 (PST)
Received: by 10.220.192.8 with HTTP; Sun, 30 Jan 2011 15:21:50 -0800 (PST)
In-Reply-To: <AANLkTimLQxiB=dnd6=iB5uEpzOSfqks=FDJ=xORehuw8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165710>

Hi Thomas,

I've just sent out the patches to the mailing list. I'm looking
forward to receive some feedback from you :)

I also have some branch detection related patch prepared. Do you use
this feature often?

Thanks,
Vitor

On Sat, Jan 29, 2011 at 2:41 AM, Vitor Antunes <vitor.hda@gmail.com> wr=
ote:
> Hi Thomas,
>
> First of all I'd like to thank you on your feedback. It's my first tr=
y
> on creating submitting a patch, so having someone's guidance helps a
> lot :)
>
> I'll rebase my patches against the head of the tree and squash the fi=
x
> to avoid multiple commits. While I do that I'll also review my commit
> message and sign-off the patches according to what you said. Hopefull=
y
> I will be able to do this during this weekend.
>
> From git-diff-tree man page:
>
> """
> -M[<n>]
> =A0 =A0Detect renames. If n is specified, it is a is a threshold on t=
he
> similarity index (i.e. amount of addition/deletions compared to the
> file=92s
> =A0 =A0size). For example, -M90% means git should consider a delete/a=
dd
> pair to be a rename if more than 90% of the file hasn=92t changed.
> """
>
> But from my latest tests I think that this option is ignored in
> diff-tree (I think it's only used in git log). With this in mind I'll
> need to add some code to implement the check of the score value of
> diff-tree output string. Again from its man page:
>
> """
> Status letters C and R are always followed by a score (denoting the
> percentage of similarity between the source and target of the move or
> copy), and are the only ones to be so.
> """
>
> Thanks,
> Vitor
>
> On Fri, Jan 28, 2011 at 3:19 PM, Thomas Berg <merlin66b@gmail.com> wr=
ote:
>> Hi,
>>
>> On Fri, Jan 28, 2011 at 12:35 AM, Vitor Antunes <vitor.hda@gmail.com=
> wrote:
>>> Hi everyone,
>>>
>>> Could anyone comment the 3 patches I sent (being this the last one)=
?
>>>
>> [...]
>>> On Thu, Nov 25, 2010 at 1:26 AM, Vitor Antunes <vitor.hda@gmail.com=
> wrote:
>>>> ---
>>>> =A0contrib/fast-import/git-p4 | =A0 =A02 +-
>>>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-=
p4
>>>> index 0ea3a44..a466847 100755
>>>> --- a/contrib/fast-import/git-p4
>>>> +++ b/contrib/fast-import/git-p4
>>>> @@ -618,7 +618,7 @@ class P4Submit(Command):
>>>> =A0 =A0 =A0 =A0 if len(detectRenames) > 0:
>>>> =A0 =A0 =A0 =A0 =A0 =A0 diffOpts =3D "-M%s" % detectRenames
>>>> =A0 =A0 =A0 =A0 else:
>>>> - =A0 =A0 =A0 =A0 =A0 =A0diffOpts =3D ("", "-M")[self.detectRename=
s]
>>>> + =A0 =A0 =A0 =A0 =A0 =A0diffOpts =3D ("", "-M")[self.detectRename=
]
>>>>
>>
>> This appears to me to be a bugfix for one of the other patches you
>> sent, is that right?
>>
>> If so, maybe you could squash it with the previous patch and re-send
>> it all to the list?
>>
>> My other comments for now are:
>> - you have forgotten to sign off on the patches
>> - commit messages are normally in imperative rather than past tense
>> (see Documentation/SubmittingPatches in git)
>>
>> - In your first patch you wrote:
>>> The detectRenames option should be set to the desired threshold val=
ue.
>> I'm not sure what threshold value you refer to here, and what values
>> you can set it to. Am I missing something?
>> (I'm not very familiar with git rename detection options)
>>
>> I'm a git-p4 user, so I can test your changes and look a bit more at
>> your code. Someone verifying it could help getting the patches
>> applied.
>>
>> Thanks for improving git-p4!
>>
>> Cheers,
>> Thomas Berg
>>
>
>
>
> --
> Vitor Antunes
>



--=20
Vitor Antunes
