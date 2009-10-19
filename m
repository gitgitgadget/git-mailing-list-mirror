From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Use "--no-" prefix to switch off some of checkout 
	dwimmery
Date: Mon, 19 Oct 2009 09:17:58 +0200
Message-ID: <81b0412b0910190017o2e6dfd47v868517404d362843@mail.gmail.com>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
	 <7vzl7pyvzl.fsf@alter.siamese.dyndns.org>
	 <7v63adxh9a.fsf_-_@alter.siamese.dyndns.org>
	 <81b0412b0910180540u7030c22br7efcaf7f51df771d@mail.gmail.com>
	 <7v7huspjg0.fsf@alter.siamese.dyndns.org>
	 <20091018210222.GA5371@blimp.localdomain>
	 <7vzl7omi5z.fsf@alter.siamese.dyndns.org>
	 <81b0412b0910182307n53b4a51cvaa14829ea8b40207@mail.gmail.com>
	 <81b0412b0910182312h583e74e4v2678eb4375164c34@mail.gmail.com>
	 <7vhbtv7vsr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 09:18:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzmVK-0005Vs-T1
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 09:18:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755399AbZJSHR4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Oct 2009 03:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755383AbZJSHR4
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 03:17:56 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:36007 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755357AbZJSHRz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Oct 2009 03:17:55 -0400
Received: by fxm28 with SMTP id 28so4780365fxm.18
        for <git@vger.kernel.org>; Mon, 19 Oct 2009 00:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=W4KjbtD1lbAtHMAkLzZ9eEF3VVamDdSU0kN0BtW9y2g=;
        b=lN2dS2WAkPFnYacdhEhe3MeEs0qBWBOaVelmZzVOJPB4puDqhbSahj1ImPmCf4nEIc
         2NhDox7X9uBDiR51Pkp66n0B2S3TKk53rvR9Viq1PxmOIrS8pEmCx9mjkAEr0OhuE3b6
         qlkkMKKNr2HVeQWl6KXHYv9cIMK96nrNBkFkU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Zhz87i5m2XlLNpi37sy3adpzYisnl8pR+iaLazc6c2pAA87m3lLRVeOmetLdPW/qdY
         7HRcEoGIIv9htYeogmax84IUcEaECbNMMmG0zMT75g+9c9VOZ8Gj3FREaHCpgsbhmB4/
         WQwyl3nud0tJ6WddUdYlTnNnYiTauniIAuvJw=
Received: by 10.204.23.193 with SMTP id s1mr4502121bkb.25.1255936678851; Mon, 
	19 Oct 2009 00:17:58 -0700 (PDT)
In-Reply-To: <7vhbtv7vsr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130664>

On Mon, Oct 19, 2009 at 08:16, Junio C Hamano <gitster@pobox.com> wrote=
:
> Alex Riesen <raa.lkml@gmail.com> writes:
>
>> On Mon, Oct 19, 2009 at 08:07, Alex Riesen <raa.lkml@gmail.com> wrot=
e:
>>> On Mon, Oct 19, 2009 at 00:49, Junio C Hamano <gitster@pobox.com> w=
rote:
>>>> Alex Riesen <raa.lkml@gmail.com> writes:
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_SET_INT(0, "dwim"=
, &dwim_new_local_branch,
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 "Guess local branch from remote reference (default=
)", 0),
>>>>
>>>> Humph, how does SET_INT know to set it to 1 with --dwim and set it=
 to 0
>>>> with --no-dwim?
>>>
>>> It seems to do, though (I checked before sending).
>>>
>>
>> Right, just looked at the parse-options: it is defined for all types=
=2E
>>
>> parse-options.c +/get_value
>>
>> =C2=A0 =C2=A0 =C2=A0 const int unset =3D flags & OPT_UNSET;
>> ...
>> =C2=A0 =C2=A0 =C2=A0 case OPTION_SET_INT:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *(int *)opt->value =
=3D unset ? 0 : opt->defval;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>>
>> Very useful.
>
> Ah, did you mean to change the default value to 1 as well?
>

Err... yes. I (wrongly) assumed that the current value in the
storage is the default. Now, having looked at struct option
I see that It isn't (and the default is in defval).

BTW, why is the option an ...INT? Where a future extension planned?
