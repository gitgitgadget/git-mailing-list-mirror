From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 05/21] i18n: sequencer: mark entire sentences for translation
Date: Sun, 22 May 2016 21:00:37 -0400
Message-ID: <CAPig+cSoq=+jsKPrqOG5khgK64VvyuJ1_EeumFBFYiaLnL27UA@mail.gmail.com>
References: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
	<1463585274-9027-6-git-send-email-vascomalmeida@sapo.pt>
	<CAPig+cQzsxMMv1XSdStFDs08C3qvb_Ttb4oVeN3T1si85v=f7w@mail.gmail.com>
	<573CD84F.7000207@sapo.pt>
	<CACBZZX790=CtGnryUNrc7S1rpV7D75MOnWnXqd=Smdkojx=ymw@mail.gmail.com>
	<xmqqk2ilbo2o.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Vasco Almeida <vascomalmeida@sapo.pt>,
	Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 23 03:00:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4eEd-0007Rt-1D
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 03:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735AbcEWBAj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 May 2016 21:00:39 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:34011 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752706AbcEWBAi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 May 2016 21:00:38 -0400
Received: by mail-io0-f180.google.com with SMTP id 190so183700904iow.1
        for <git@vger.kernel.org>; Sun, 22 May 2016 18:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=fzGJBh3FIWXmYCYaUHdD4GYDrT7xJdfFoVXyRwzH9nE=;
        b=DnfNzDP1Ga1ClX1nhyLvbJjBRRTaNk7aRjZSh3QH5VoURl6v9raiH0lcL+FzsICy32
         nRkmzmruewYactm6dQupoXY9uoNsvDU+RciKRf6nJ9/DgIjfAQaDwPqJM6Yw6xOrBg3s
         7zq7HgtiTKV3ggyKTvQJDHusOPj31l27caRgQFHCcHBaiMHI4ds5yRRa5OYkh4wkGAfx
         6v0cZhINtXUlEMig8IzCDKDLz7IS0ChY3zu7uhGvr0mkcwfCP9dur9yK/4P6exkH5dLg
         cOpV33gAjTT1K13xorgjOCxyEaQewPJEgF78gnyl/qZmur0BWBAP1d9UpKFAlUpz/mfb
         +AdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=fzGJBh3FIWXmYCYaUHdD4GYDrT7xJdfFoVXyRwzH9nE=;
        b=mlNWiH7qijMLt5uufWyCTzy90oFZE4YY9rMeI6eooUttq5jifgGdB2mOJjN69eSnT3
         iMXEVNjFdpFCK0wVxutGFLrS4TuFUPEvWm7cH3Q8SYTZesmcL0fZOXshuC20Mf3N+hkd
         49ZTHDmASbiQ6n8AbC5beykPkw+91mP+Ij3u3GCncisnlWHkoVWt39Ye3eDRYrunOW/H
         Ru9E6tt7iGFXWW1N55iXgF8Mn3RrsQGyKuwgbLcrB7EylV84Elg+Hlj7WST9wRdUo/Cn
         /REC/kNYsD8RrGgNVl+c9hDnssyA6rcqcCQim0MRVxxgT7JJ9uhaT5yZw3WQl7VnvSrn
         Pcng==
X-Gm-Message-State: ALyK8tK7fLal+AqXSZnOjwLXU0qEA9ZHS54LGvNq3pXp9WAop4IWiXk6xo2Km5sTaLEZwWz3tf7hGaIHEYE0CQ==
X-Received: by 10.36.31.3 with SMTP id d3mr1908990itd.84.1463965237237; Sun,
 22 May 2016 18:00:37 -0700 (PDT)
Received: by 10.79.110.21 with HTTP; Sun, 22 May 2016 18:00:37 -0700 (PDT)
In-Reply-To: <xmqqk2ilbo2o.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: rYopRgQJmCwGQTqigxgYylnh2G0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295297>

On Sun, May 22, 2016 at 8:44 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>> For what it's worth I agree with you and disagree with Eric here and
>> Junio in the "[PATCH 03/21] i18n: advice: internationalize message f=
or
>> conflicts" thread.
>>
>> Of course there's a trade-off in source code verbosity when you have
>> to change every occurance of (pseudocode):
>>
>>     "our %s failed" # %s can be revert or merge
>>
>> to:
>>
>>     if (action =3D=3D "merge")
>>         gettext("our merge failed")
>>     elsif (action =3D=3D "revert")
>>         gettext("our revert failed")
>>
>> But forcing the translator to turn every such occurrence that flows
>> naturally in English into "the '%s' command failed" leads to a worse
>> translation.
>>
>> For example, if I ever get around to doing the Icelandic translation
>> which I've had on my backlog I might translate something like this:
>> ...
>> I.e. even though you might be running "git merge" or "git revert" th=
e
>> UI is talking about those terms in the translated using native terms
>> for the action of merging or reverting, but referring to the literal
>> command names in English.
>> ...
>> It just doesn't flow as well, and leads to a more verbose translatio=
n.
>
> OK.  I couldn't judge your example in Icelandic, but I have enough
> trust in you to believe your conclusion ;-).

I have no problem viewing the issue from either side (the sentence
referencing a *literal* command or the *action* of the command), and
understood that it could go either way when I wrote the review. What
threw me was that 3/21 seemed to be using the literal command in the
strings rather than the action, despite the commit message. For
instance:

    error(_("commit is not possible because ..."));
    error(_("merge is not possible because ..."));
    error(_("pull is not possible because ..."));
    error(_("revert is not possible because ..."));

In each case, the first word looks like a git command; it's not
particularly grammatically correct. Had Vasco instead changed them to:

    committing is not possible...
    merging is not possible...
    pulling is not possible...
    reverting is not posible...

then the issue likely would never have come up.
