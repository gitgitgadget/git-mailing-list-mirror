From: Julian Ibarz <julian.ibarz@gmail.com>
Subject: Re: Re: Updating a submodule with a compatible version from another
 submodule version using the parent meta-repository
Date: Wed, 2 Feb 2011 23:31:40 -0500
Message-ID: <AANLkTim2G0kF+omPZ1_fk0P6oGDaKDWd79XNR5GXUkWG@mail.gmail.com>
References: <AANLkTinN1XVsAZXGLqkuhysrJ8-TCtGm4pOu2RfCEVVp@mail.gmail.com>
	<AANLkTimvNaiieEw8-Y52xxDW6DQ6b16v9azCk+BDPxhe@mail.gmail.com>
	<4D407099.4010805@web.de>
	<AANLkTinMhvBNrBMJ8vQpJdYxP_NgJU2L7JEW0KhXGjhf@mail.gmail.com>
	<4D407875.7080607@web.de>
	<AANLkTik-XdgGM20kFu8KZ5k9ynfNAo8fvL9t7kL_JhQg@mail.gmail.com>
	<7v7hdrl7nw.fsf@alter.siamese.dyndns.org>
	<AANLkTik8VrhbBSLwRq9gd39hofnmifk15zSqXVTsSzAp@mail.gmail.com>
	<7v1v3zjp6w.fsf@alter.siamese.dyndns.org>
	<20110129110807.GA21864@book.hvoigt.net>
	<AANLkTimBCeSnR270eWMcrgCVj6rmiRkJizOxQPAPOAnn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Feb 03 05:33:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pkqsl-0003bI-G9
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 05:33:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755567Ab1BCEdH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Feb 2011 23:33:07 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37608 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755455Ab1BCEdF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Feb 2011 23:33:05 -0500
Received: by iyj18 with SMTP id 18so692789iyj.19
        for <git@vger.kernel.org>; Wed, 02 Feb 2011 20:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ekTExbuESYB/KvoeI4MkDzYYiYx8wW2VHTCWZeDmz9A=;
        b=djRwfTraBEdN4DdgGpnYy31CJ8kmahzDVKGRjsErupt3SvCEUV8IYcJYLVUGt4uiJR
         p6ce9XjN8kVEGulvl41IPlDwxdhg6V3XhWQx8dgLeVpmg1MByrAkjotGFRp51pllPxb9
         R69dqJTxMOV3rYAkEoQ3w7B4d3GM2ujwrrahc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=U5cjGE+0sfhxzIcVcj1TLaRypcCFpXNJJRtcESMxnvoVvz5g46thb+6mgNDHZED7Gm
         hTaHcag7MPf9sLvm8sZVmhQrv5g6+C6y+OP7cRrO3iJNaajRisYTd8RZLe/Qi6K2hmaZ
         I9GC3A32eL39e8CjGhPicFdrI3c8CNNkOM9FI=
Received: by 10.42.177.74 with SMTP id bh10mr12162525icb.148.1296707500642;
 Wed, 02 Feb 2011 20:31:40 -0800 (PST)
Received: by 10.42.213.71 with HTTP; Wed, 2 Feb 2011 20:31:40 -0800 (PST)
In-Reply-To: <AANLkTimBCeSnR270eWMcrgCVj6rmiRkJizOxQPAPOAnn@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165949>

Hi,

After a couple of hours, I have finally succeeded to go through the
entire history of a repository and I can detect the submodules in a
tree of a commit. For those interested here is the source code:

http://gitorious.org/julian_ibarz_git/julian_ibarz_git/blobs/submodule_=
checkout/builtin/submodulecheckout.c

Next time I will build the list of commits of a submodule in the
entire history. Then I will need to find the distance of each commit
in the list compared to the current  commit of a submodule and keep
the closest one (which has to be a parent so an algebric distance
would be good to have).

So now my two questions that could save me some time are:
- is there a function that gives the distance between two commits? I'm
sure there is something like this coded somewhere but I didn't find it
yet
- is the struct decorate a hash map and if yes could someone explain
me how to use it or point me to a location where it is used?

Except from that I think I have all the information I need.

Best regards,
Julian Ibarz

On Sun, Jan 30, 2011 at 4:44 AM, Julian Ibarz <julian.ibarz@gmail.com> =
wrote:
> Today I have started to implement a proof of concept in C (I know a
> script would be better but I am really not good in sh so...). I
> struggle with the manipulation of the git API. I have pushed my work
> here:
>
> http://gitorious.org/julian_ibarz_git/julian_ibarz_git
>
> in branch submodule_checkout
>
> My work is in:
>
> builtin/submodulecheckout.c
>
> And my questions are prepended by the keyword QUESTION (two questions
> for now only).
>
> Any help is welcome.
>
> Thanks,
>
> Julian Ibarz
>
> On Sat, Jan 29, 2011 at 6:08 AM, Heiko Voigt <hvoigt@hvoigt.net> wrot=
e:
>> Hi,
>>
>> On Wed, Jan 26, 2011 at 02:05:43PM -0800, Junio C Hamano wrote:
>>> If that version of submodule B is explicitly bound to a commit in t=
he
>>> superproject A, you know which version of A and C were recorded, an=
d the
>>> problem is solved.
>>>
>> [...]
>>>
>>> If you are confident that you didn't introduce different kind of
>>> dependency to other submodules while developing your "old_feature" =
branch
>>> in submodule B, one strategy may be to find an ancestor, preferrabl=
y the
>>> fork point, of your "old_feature" branch that is bound to the super=
project
>>> A. =A0Then at that point at least you know whoever made that commit=
 in A
>>> tested the combination of what was recorded in that commit, togethe=
r with
>>> the version of B and C, and you can go forward from there, replayin=
g the
>>> changes you made to the "old_feature" branch in submodule B.
>>
>> Lets extend your explanation a little further and maybe demonstrate =
the problem
>> Julian is having a little more. I think what Julian searches for is =
a tool in
>> git that does the lookup for you which is AFAIK not that easy curren=
tly. It
>> seems to be a quite useful feature. Here what I understand Julian wa=
nts:
>>
>> 1. Find the most recent superproject commit X'' in A that records a =
submodule
>> =A0 commit X' in B which contains the commit X in B you are searchin=
g for.
>>
>> =A0 For this we would need use something similar to git describe --c=
ontains
>> =A0 but instead of using the list of existing tags in B it should us=
e the list
>> =A0 of commits in B which are recorded in A.
>>
>> =A0 Here a drawing to explain (linear history for simplicity):
>>
>> =A0 superproject A:
>>
>> =A0 =A0 =A0O---O---X''---O
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> =A0 submodule B: \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> =A0 =A0 =A0O---X---O---X'---O---O
>>
>> 2. Look up the commit of C which is recorded in X'' of A and check i=
t
>> =A0 out.
>>
>> Step 2 is easy but for Step 1 the lookup of X' is missing for the co=
mmandline.
>> Is there already anything that implements git describe --contains fo=
r a defined
>> list of commits instead of refs?
>>
>> Cheers Heiko
>>
>
