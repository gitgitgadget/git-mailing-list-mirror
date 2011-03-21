From: Lasse Makholm <lasse.makholm@gmail.com>
Subject: Re: Is there some env variable like GIT_LANG (like LANG)?
Date: Mon, 21 Mar 2011 21:48:55 +0100
Message-ID: <AANLkTi=wwFw09QkrttvxvuEoHyuQ+61wa0YMysDQC05D@mail.gmail.com>
References: <4D879E11.6040609@dirk.my1.cc>
	<7vipvcp8e3.fsf@alter.siamese.dyndns.org>
	<4D87ABA5.1030609@dirk.my1.cc>
	<AANLkTikXsYONY5rUSF5138bQ=R4gCopOO8fu=3np+c98@mail.gmail.com>
	<4D87B6D4.3040601@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Mon Mar 21 21:49:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1m2A-0004wS-CN
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 21:49:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754441Ab1CUUs6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Mar 2011 16:48:58 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40549 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754376Ab1CUUs4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 16:48:56 -0400
Received: by bwz15 with SMTP id 15so5354295bwz.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 13:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=q51zB3ZleNNV7h2Fxw9va1rbcB26Emzxp0Rm+JSDxu0=;
        b=qRWTbTJnOj9h/WHWRIb448r0cja61L7DhksiTaxTLp6GJQYkDvZIfbxm/yIpqvwy+r
         CAmvuI9OFg15RbqaWR2fsoysKFc4Y4xeOXOezDAc8Vt5TOX2L1hYjNfIQBvAXLyMdnVQ
         f1UjCGkAmd1lldsh9RwcTWozUq6QajULM/bMc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xhYdCQiw19O61w2DuiJy3Ej/bd2NJfE0cO1IQOvz8a1JA6kZGnFt5uahAzDwvpfK4N
         2rLLulT49ddmtt6f7FPIvks0bdl/nBp1H7KaqFOR0etrms86O6Tt1+RiybtBAWfkPu0g
         mjra0cqOBrFNZN/CtK37GxUwVQFW44DzHS/9k=
Received: by 10.204.80.29 with SMTP id r29mr4137669bkk.195.1300740535348; Mon,
 21 Mar 2011 13:48:55 -0700 (PDT)
Received: by 10.204.114.207 with HTTP; Mon, 21 Mar 2011 13:48:55 -0700 (PDT)
In-Reply-To: <4D87B6D4.3040601@dirk.my1.cc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169668>

2011/3/21 Dirk S=FCsserott <newsletter@dirk.my1.cc>:
> Am 21.03.2011 21:30 schrieb Lasse Makholm:
>>
>> 2011/3/21 Dirk S=FCsserott<newsletter@dirk.my1.cc>:
>>>
>>> Am 21.03.2011 20:43 schrieb Junio C Hamano:
>>>>
>>>> Dirk S=FCsserott<newsletter@dirk.my1.cc> =A0 =A0writes:
>>>>
>>>>> What would you think of it?
>>>>
>>>> Strongly negative. =A0I don't want force people to set GIT_LANG HG=
_LANG
>>>> CVS_LANG and 47 different FROTZ_LANG environment variables.
>>>>
>>>> I would rather just set LANG=3DC LC_ALL=3DC in the terminal I use =
git in and
>>>> leave everything else in whatever locale the rest of the system is=
 in.
>>>>
>>>
>>> Ok. Accepted. Was just a question. I see your point.
>>
>> Alternatively, you might like something like the following in your
>> .bashrc:
>>
>> function git
>> {
>> =A0 =A0 LANG=3DC command git "$@"
>> }
>>
>
> Hmm. Looks interesting. I'll try it out. I'm not so shell'ish (more
> perl'ish) but I expect that to "rename"/"alias" git to the given comm=
and. If
> it works, it's great. Thank you.

Just make sure you include the "command" part or the function will
call itself indefinitely...

--=20
/Lasse
