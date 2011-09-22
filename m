From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: [PATCH] Clarify that '--tags' fetches tags only
Date: Thu, 22 Sep 2011 13:13:03 +1000
Message-ID: <CAH5451nb=DTed2kAVNQmFBbGFJ9zvQAtBE+VCzKqZfGMgYpx5w@mail.gmail.com>
References: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com>
 <1316649176-32352-1-git-send-email-anatol.pomozov@gmail.com>
 <CAMOZ1BuSd52woX0utOQ84gbCzBkZg3ATKnE+7G_BrD5_hUQSiQ@mail.gmail.com>
 <7vwrd1z9it.fsf@alter.siamese.dyndns.org> <CAMOZ1Bvxc+vcofb_KyeLS7Gy=KOtX1SKv72cXA2NtwgYCWA31A@mail.gmail.com>
 <CAMOZ1Bt6gGVd6QuRZduZ4mJ=eoZ9d7xK-WfwZ3G-+oswT0RN_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Anatol Pomozov <anatol.pomozov@gmail.com>, git@vger.kernel.org,
	computerdruid@gmail.com
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 05:13:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6Zj8-00076t-Mu
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 05:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995Ab1IVDNZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Sep 2011 23:13:25 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62792 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887Ab1IVDNY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2011 23:13:24 -0400
Received: by fxe4 with SMTP id 4so2291454fxe.19
        for <git@vger.kernel.org>; Wed, 21 Sep 2011 20:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=akgla/R3/EIiQzAFx1tgKrXfR+/mZ9kSpQ2rpY6yK5A=;
        b=EjTm5gH76EjiO9FKb+r0waIq4bkWjWAPW9VAbbSr+j1J+YhokjMvG6hdMo/CbD72s+
         jAzKxN63uFI0MIOFwTGSlCdIW3B6chOG9pTPnQQteDneOQ56X3eJhGdwydKU4CmQQYhJ
         xGLmv/iWsRdx8tpFajB3D+4HTLzrxgdzWNIso=
Received: by 10.223.95.148 with SMTP id d20mr2193788fan.59.1316661203258; Wed,
 21 Sep 2011 20:13:23 -0700 (PDT)
Received: by 10.152.37.66 with HTTP; Wed, 21 Sep 2011 20:13:03 -0700 (PDT)
In-Reply-To: <CAMOZ1Bt6gGVd6QuRZduZ4mJ=eoZ9d7xK-WfwZ3G-+oswT0RN_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181878>

On 22 September 2011 12:07, Michael Witten <mfwitten@gmail.com> wrote:
> On Thu, Sep 22, 2011 at 02:01, Michael Witten <mfwitten@gmail.com> wr=
ote:
>> On Thu, Sep 22, 2011 at 00:49, Junio C Hamano <gitster@pobox.com> wr=
ote:
>>> --tags is merely a short-hand for "refs/tags/*:refs/tags/*")
>>> explicitly from the command line
>>
>> [Disclaimer: I don't know the code or the semantics]
>>
>> Why not just use that explanation?
>>
>> =C2=A0This option is merely a short-hand for writing
>> =C2=A0the refspec `refs/tags/*:refs/tags/*'; consequently,
>> =C2=A0using this option overrides any default refspec that
>> =C2=A0would be used if no refspec were provided on the
>> =C2=A0command line. That is,
>>
>> =C2=A0 =C2=A0git fetch --tags origin frotz
>>
>> =C2=A0is equivalent to:
>>
>> =C2=A0 =C2=A0git fetch origin frotz 'refs/tags/*:refs/tags/*'
>>
>> In fact, if the command line parsing performed by `git fetch'
>> is reasonably intelligent, then it might be worthwhile
>> to relocate `--tags' in the example:
>>
>> =C2=A0That is,
>>
>> =C2=A0 =C2=A0git fetch origin frotz --tags
>>
>> =C2=A0is equivalent to:
>>
>> =C2=A0 =C2=A0git fetch origin frotz 'refs/tags/*:refs/tags/*'
>>
>
> Maybe this is less confusing for the example:
>
> =C2=A0That is,
>
> =C2=A0 =C2=A0git fetch origin --tags
> =C2=A0 =C2=A0git fetch origin frotz --tags bar
>
> =C2=A0are equivalent to:
>
> =C2=A0 =C2=A0git fetch origin 'refs/tags/*:refs/tags/*'
> =C2=A0 =C2=A0git fetch origin frotz 'refs/tags/*:refs/tags/*' bar

This will only help people who understand that tags are just refs
stored in refs/tags, and who understand the 'ref:ref' syntax. I think
it is a good example to have, but people can understand the process
and results of 'pulling/fetching a tag' without necessarily needing to
know that tags are stored somewhere, or knowing the exact fetch
mechanism. If these need to be documented, it should be in the
appropriate place (which I don't think is here).

I think we are skirting around the real issue, and that is that
pulling tags will often grab objects that are *meant* to be on a
remote branch (from the user's perspective) but that appear to be
hanging because the remote branch ref was not updated at the same
time. Perhaps an example or explanation of why this is the case would
be more useful?

Maybe:

Note that if this option is specified, then only tags
are fetched. No other refs, such as a remote tracking
branch, will be updated, even if it has been updated
on the remote end.

extra info on how this option is merely a short-hand for writing the
refspec `refs/tags/*:refs/tags/* could go here


Regards,
Andrew
