From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH] Clarify that '--tags' fetches tags only
Date: Thu, 22 Sep 2011 03:24:42 +0000
Message-ID: <CAMOZ1BtPJ_Ddxo1UG2cxJMnGv9y8sR0rAyk3d_5JEz4kLsUQJQ@mail.gmail.com>
References: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com>
 <1316649176-32352-1-git-send-email-anatol.pomozov@gmail.com>
 <CAMOZ1BuSd52woX0utOQ84gbCzBkZg3ATKnE+7G_BrD5_hUQSiQ@mail.gmail.com>
 <7vwrd1z9it.fsf@alter.siamese.dyndns.org> <CAMOZ1Bvxc+vcofb_KyeLS7Gy=KOtX1SKv72cXA2NtwgYCWA31A@mail.gmail.com>
 <CAMOZ1Bt6gGVd6QuRZduZ4mJ=eoZ9d7xK-WfwZ3G-+oswT0RN_Q@mail.gmail.com> <CAH5451nb=DTed2kAVNQmFBbGFJ9zvQAtBE+VCzKqZfGMgYpx5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Anatol Pomozov <anatol.pomozov@gmail.com>, git@vger.kernel.org,
	computerdruid@gmail.com
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 05:25:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6Zua-0001vo-DE
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 05:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049Ab1IVDZP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Sep 2011 23:25:15 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:51274 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600Ab1IVDZN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2011 23:25:13 -0400
Received: by qyk30 with SMTP id 30so5738812qyk.19
        for <git@vger.kernel.org>; Wed, 21 Sep 2011 20:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=XFpZt5VKKyPslJX18wPsJtFMQy1WI5jD7vlDf6vikyA=;
        b=Y16Nyj31n8quqImWyj8aF4Sw/l7vHhsrUssve64q+qEzOEzsz7f41Udf1ifj26towx
         K5PRcFap5N/WeLPv91FqLoFMw9qM9J088y7VJGD0sdYzbpu3mOn4Lz7qGhTBvATbLDAp
         eWwyfqDtroLVr0F4E9uZWJ3/Q/dvf6RlU1zss=
Received: by 10.229.83.143 with SMTP id f15mr1241107qcl.241.1316661912119;
 Wed, 21 Sep 2011 20:25:12 -0700 (PDT)
Received: by 10.229.233.6 with HTTP; Wed, 21 Sep 2011 20:24:42 -0700 (PDT)
In-Reply-To: <CAH5451nb=DTed2kAVNQmFBbGFJ9zvQAtBE+VCzKqZfGMgYpx5w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181879>

On Thu, Sep 22, 2011 at 03:13, Andrew Ardill <andrew.ardill@gmail.com> =
wrote:
> On 22 September 2011 12:07, Michael Witten <mfwitten@gmail.com> wrote=
:
>> On Thu, Sep 22, 2011 at 02:01, Michael Witten <mfwitten@gmail.com> w=
rote:
>>> On Thu, Sep 22, 2011 at 00:49, Junio C Hamano <gitster@pobox.com> w=
rote:
>>>> --tags is merely a short-hand for "refs/tags/*:refs/tags/*")
>>>> explicitly from the command line
>>>
>>> [Disclaimer: I don't know the code or the semantics]
>>>
>>> Why not just use that explanation?
>>>
>>> =C2=A0This option is merely a short-hand for writing
>>> =C2=A0the refspec `refs/tags/*:refs/tags/*'; consequently,
>>> =C2=A0using this option overrides any default refspec that
>>> =C2=A0would be used if no refspec were provided on the
>>> =C2=A0command line. That is,
>>>
>>> =C2=A0 =C2=A0git fetch --tags origin frotz
>>>
>>> =C2=A0is equivalent to:
>>>
>>> =C2=A0 =C2=A0git fetch origin frotz 'refs/tags/*:refs/tags/*'
>>>
>>> In fact, if the command line parsing performed by `git fetch'
>>> is reasonably intelligent, then it might be worthwhile
>>> to relocate `--tags' in the example:
>>>
>>> =C2=A0That is,
>>>
>>> =C2=A0 =C2=A0git fetch origin frotz --tags
>>>
>>> =C2=A0is equivalent to:
>>>
>>> =C2=A0 =C2=A0git fetch origin frotz 'refs/tags/*:refs/tags/*'
>>>
>>
>> Maybe this is less confusing for the example:
>>
>> =C2=A0That is,
>>
>> =C2=A0 =C2=A0git fetch origin --tags
>> =C2=A0 =C2=A0git fetch origin frotz --tags bar
>>
>> =C2=A0are equivalent to:
>>
>> =C2=A0 =C2=A0git fetch origin 'refs/tags/*:refs/tags/*'
>> =C2=A0 =C2=A0git fetch origin frotz 'refs/tags/*:refs/tags/*' bar
>
> This will only help people who understand that tags are just refs
> stored in refs/tags, and who understand the 'ref:ref' syntax. I think
> it is a good example to have, but people can understand the process
> and results of 'pulling/fetching a tag' without necessarily needing t=
o
> know that tags are stored somewhere, or knowing the exact fetch
> mechanism. If these need to be documented, it should be in the
> appropriate place (which I don't think is here).
>
> I think we are skirting around the real issue, and that is that
> pulling tags will often grab objects that are *meant* to be on a
> remote branch (from the user's perspective) but that appear to be
> hanging because the remote branch ref was not updated at the same
> time. Perhaps an example or explanation of why this is the case would
> be more useful?
>
> Maybe:
>
> Note that if this option is specified, then only tags
> are fetched. No other refs, such as a remote tracking
> branch, will be updated, even if it has been updated
> on the remote end.
>
> extra info on how this option is merely a short-hand for writing the
> refspec `refs/tags/*:refs/tags/* could go here

Junio just explained why your description is inadequate and confusing.

There's so much confusion around git exactly because people are always
trying to hide just WTF is going on (especially by using TERRIBLE
terms like `branch'; see my numerous discussions).

If I were a newbie and were to read the text that I just proferred as
a clarification of --tags, then I would next look up just WTF a
refspec is, and then a branch, and then...

You see? That's exactly how it should work. People should be given
descriptions that arm them with the terms necessary to look up more
information. We need to stop writing documentation for that
hypothetical idiot who doesn't know his ass from his own face. We need
to cater to those people who intend to read documentation for the
purpose of understanding the system---not for the purpose of gettin'
shit dun with any half-baked notion that is good enough for the most
simplistic situation.

I'm sending in a patch presently.
