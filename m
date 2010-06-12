From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2] Group the default git help message by topic
Date: Sat, 12 Jun 2010 16:35:57 +0000
Message-ID: <AANLkTin3RHtU9tNHPKFyY3WJPhUZCr2AC9sLpn33Nkc4@mail.gmail.com>
References: <AANLkTiloErvcWS1hW80cIV9SiWu_7CBdNSx_iAppcGOd@mail.gmail.com>
	<422F3619-25EC-4509-8EE3-78B6C765AB2A@wincent.com>
	<4C12B20F.3080709@gmail.com>
	<AANLkTinec7_D-WHRfetVRVvmG0EGoW4ZTdiTvoGMgJvQ@mail.gmail.com>
	<AANLkTilPq8JYTodCA17Wt2G1QZZValgPlbC7sM_neHU4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitzilla@gmail.com, Wincent Colaiuta <win@wincent.com>,
	git list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 12 18:36:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONTgj-0006uT-IL
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 18:36:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951Ab0FLQf7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jun 2010 12:35:59 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53627 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895Ab0FLQf6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jun 2010 12:35:58 -0400
Received: by iwn9 with SMTP id 9so1593525iwn.19
        for <git@vger.kernel.org>; Sat, 12 Jun 2010 09:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TqPHh/ZGpf9fdRPoMhA5EkX+m/tnN6Ds3IJKXgYPJhs=;
        b=WNziMHTgT7XDV54L3cnY1Zq1zPq58v/PY4ype6+jzfoMpEXuPWQ1sFkpNNLmViz3kO
         UcMNtlzlOdGdf2LLwhVgMUwaDCC8047WBKKBTS6a0ywc930r5fWEIs294PjJ2Ytgqge9
         fPgn7/uZRHFwYakLkcHr1BIBDk6WXUoGvaGmI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lBgqoc2I6hHqToYTbv8GEB4wzJhPH3/cTDkdotbFEewgCNZ3GIj+d7ciJB9MzAvMg3
         fNeT+oy8ej6VF95FYuypyua1T4kvfcqBOq4eZpjiinVpxhlOfkf01J+f8JYFCHUuMMRu
         2AhKbohAVBGQYv4EWCdQXZ7JYwobpjjihOF54=
Received: by 10.231.140.69 with SMTP id h5mr3468226ibu.153.1276360557341; Sat, 
	12 Jun 2010 09:35:57 -0700 (PDT)
Received: by 10.231.155.144 with HTTP; Sat, 12 Jun 2010 09:35:57 -0700 (PDT)
In-Reply-To: <AANLkTilPq8JYTodCA17Wt2G1QZZValgPlbC7sM_neHU4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149018>

On Sat, Jun 12, 2010 at 16:19, Scott Chacon <schacon@gmail.com> wrote:
> Hey,
>
> On Fri, Jun 11, 2010 at 3:28 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on
> <avarab@gmail.com> wrote:
>> On Fri, Jun 11, 2010 at 22:00, A Large Angry SCM <gitzilla@gmail.com=
> wrote:
>>> Can a command be listed twice? Some of these commands _really_ belo=
ng in
>>> more than one category.
>>
>> Of course it can. But what specific commands do you mean?
>>
>
> For the sake of brevity and clarity I would prefer just choosing the
> most appropriate category rather than putting any in there twice. =C2=
=A0I'm
> trying to stay as close to 25 lines as possible, which is also why I
> now think we should remove 'show' from the list, too. =C2=A0The point=
 is
> not to be as accurate as technically possible, but instead to just be
> a bit more presentable to new users - help them parse the needed
> command set a little easier than one big list.

=46WIW `git show` is among my top 5 commands according to my bash
history.

I think it's definitely among the commands that should be listed by
`git help` by default. It's needed whenever you want to inspect a
given revision.
