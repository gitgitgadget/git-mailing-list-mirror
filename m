From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] documentation fix: git difftool uses diff tools, not
 merge tools.
Date: Mon, 21 Nov 2011 04:25:33 -0800
Message-ID: <CAJDDKr6vrWqZ_KcyDeGWbiy41ncRtgj9OgF9rSW+YxZZJBFK7Q@mail.gmail.com>
References: <1321311352-8950-1-git-send-email-thh@inter.net>
	<7v62imi6c7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Hochstein <thh@inter.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 21 13:25:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSSwN-0008Dj-Jn
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 13:25:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134Ab1KUMZe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Nov 2011 07:25:34 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50751 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903Ab1KUMZe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Nov 2011 07:25:34 -0500
Received: by ywt32 with SMTP id 32so4601044ywt.19
        for <git@vger.kernel.org>; Mon, 21 Nov 2011 04:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=yjzxBrcVcJkUShD/mIVIUOqmWVyn2n7RxAnAyY7a8mI=;
        b=gAXRuhsIIAlsJ0vdjfUkDi7UmY3uMyWk5V7b+l02h09CcdwF77ecfPabE7g9QLlPRQ
         usTc+RC7EnyC6fnZnSyKe/uUS468U2KevSYv6t6wEkDKvzklthRIeUnpB2MJM1viBtn6
         Nm7PDEUGSeVk8LuD3ABH9YGuMS6tGdY9dmFZk=
Received: by 10.236.173.202 with SMTP id v50mr18765001yhl.102.1321878333537;
 Mon, 21 Nov 2011 04:25:33 -0800 (PST)
Received: by 10.150.191.17 with HTTP; Mon, 21 Nov 2011 04:25:33 -0800 (PST)
In-Reply-To: <7v62imi6c7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185741>

On Mon, Nov 14, 2011 at 4:20 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Thomas Hochstein <thh@inter.net> writes:
>
>> Let the documentation for -t list valid *diff* tools,
>> not valid *merge* tools.
>>
>> Signed-off-by: Thomas Hochstein <thh@inter.net>
>> ---
>> =C2=A0Documentation/git-difftool.txt | =C2=A0 =C2=A02 +-
>> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/Documentation/git-difftool.txt b/Documentation/git-diff=
tool.txt
>> index a03515f..19d473c 100644
>> --- a/Documentation/git-difftool.txt
>> +++ b/Documentation/git-difftool.txt
>> @@ -31,7 +31,7 @@ OPTIONS
>> =C2=A0-t <tool>::
>> =C2=A0--tool=3D<tool>::
>> =C2=A0 =C2=A0 =C2=A0 Use the diff tool specified by <tool>.
>> - =C2=A0 =C2=A0 Valid merge tools are:
>> + =C2=A0 =C2=A0 Valid diff tools are:
>> =C2=A0 =C2=A0 =C2=A0 araxis, bc3, diffuse, emerge, ecmerge, gvimdiff=
, kdiff3,
>> =C2=A0 =C2=A0 =C2=A0 kompare, meld, opendiff, p4merge, tkdiff, vimdi=
ff and xxdiff.
>> =C2=A0+
>
> The patch is obviously correct, and it is so trivial that there is no=
 risk
> of breaking anything. It would even be OK for 1.7.7.X maintenance ser=
ies.
>
> But in the longer term, I suspect that we would want to drop this
> enumeration from the documentation, and instead give "--list-tools"
> option or something to the command. That way, we only need to keep
> the list of known tools in one place where it matters, namely, the
> command that knows about them.
>
> David, what do you think?
>
> The same comment applies to "git mergetool", I would think.

Exactly my thoughts.
--=20
=C2=A0 =C2=A0 David
