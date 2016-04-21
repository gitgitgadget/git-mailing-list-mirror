From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 04/12] worktree.c: mark current worktree
Date: Thu, 21 Apr 2016 10:23:09 -0400
Message-ID: <CAPig+cQkT8vb-OVdS_ALVuDii9njY6BN2FhkXt=CavAfyeO2Fg@mail.gmail.com>
References: <1460897965-486-1-git-send-email-pclouds@gmail.com>
	<1461158693-21289-1-git-send-email-pclouds@gmail.com>
	<1461158693-21289-5-git-send-email-pclouds@gmail.com>
	<CAPig+cR99Nx=dk+zT2Jgpr2ZgYM4v0q2vX7v6TXmWHU5k6ga3w@mail.gmail.com>
	<CACsJy8DwzfsPthWy6pG2t0cGVT0kcrJT7xWdyvs+0EPFDbNtSQ@mail.gmail.com>
	<CACsJy8ATaYx0Fk-7HK9Rz_o687hxCLuOJYJ6DkBd4Xk8sP+byw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 16:23:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atFVk-0000Wb-GY
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 16:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbcDUOXL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Apr 2016 10:23:11 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33419 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbcDUOXK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2016 10:23:10 -0400
Received: by mail-io0-f195.google.com with SMTP id g185so10795847ioa.0
        for <git@vger.kernel.org>; Thu, 21 Apr 2016 07:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=br4zrZuTAtmPuefOLs73d9LpjWCo+Ov5sKv2r1dEzko=;
        b=ceu0RfOjmkWXyzIV7u6s1ixBfLPL3k7JhHZDzoGjLut2hY+c4iQYJwDZ5zV+QqPyXv
         mybAJteWFqbndN8a8tmQIOkAT6XkQn9Q0zFC57a1IYOx28SHkE1IXlr9RG0EALhrM2cx
         JpRPxWmjYCKyWST9+So/s7BUtsXDd8f0dDImFFo6KTXqws9+5iR6CqtuVGgILtW2QF2k
         5hf0DCNEgA2sIuZx6NeG3SfGY8Nrq7q1Oq1XpZXFutYM65Ebnh2rjtmhEiDBm4C2yBrl
         bMg0SgGogT80TlJF3fOrg3/Iy91vWVXnoaMW/Z2ldmA6ZKL3h/QsM/uLd36dKkGAsO75
         OUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=br4zrZuTAtmPuefOLs73d9LpjWCo+Ov5sKv2r1dEzko=;
        b=X9OPQcdnp69cOuG+jkYGR26lGuVgcfCNIGwlLamJoMoL/RKWZnVNwnx+x/e5WkDjF/
         Jmp6v6MyA4XpBhjb0GPw0MCHZBT09qKawKemZWs7zCyS62AGD6nE2NHfYi7e8wWJNpg6
         n6bB00ZX7KQjTEZlI3SZzll+LpUP9ZdLsB/gK6lsbc4KfKs9pqzBZjd4gZjQylXw1jLm
         weDBRNMG34/1+JUxSvUZkfHppn43PmQv6J1Oei/gfK6SUlsLWj4jTEWZdCFAO9IXIILa
         LspkwQIRb0ri7F/GhVeWUedoiSPN/Xqc0QQUGYjNUEGxM9O1l3IX5SuKHI+RTug+dupd
         NbdQ==
X-Gm-Message-State: AOPr4FVYRwOuJKLtMJybKV+ki9a94P8JLK0V0Bcr65eOEmb0F9aKqs3c/XwueYJqRaAYyHI4r3N0FNNOQbjvhg==
X-Received: by 10.107.47.10 with SMTP id j10mr16409028ioo.168.1461248589315;
 Thu, 21 Apr 2016 07:23:09 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Thu, 21 Apr 2016 07:23:09 -0700 (PDT)
In-Reply-To: <CACsJy8ATaYx0Fk-7HK9Rz_o687hxCLuOJYJ6DkBd4Xk8sP+byw@mail.gmail.com>
X-Google-Sender-Auth: sYyJBHM9dSPy7fzWM191EESTlo8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292112>

On Thu, Apr 21, 2016 at 5:33 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Apr 21, 2016 at 3:19 PM, Duy Nguyen <pclouds@gmail.com> wrote=
:
>> On Thu, Apr 21, 2016 at 2:20 PM, Eric Sunshine <sunshine@sunshineco.=
com> wrote:
>>> On Wed, Apr 20, 2016 at 9:24 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@=
gmail.com>
>>>> +       strbuf_addstr(&git_dir, absolute_path(get_git_dir()));
>>>> +       for (i =3D 0; i < counter; i++) {
>>>> +               struct worktree *wt =3D list[i];
>>>> +               strbuf_addstr(&path, absolute_path(get_worktree_gi=
t_dir(wt)));
>>>> +               wt->is_current =3D !strcmp_icase(git_dir.buf, path=
=2Ebuf);
>>>
>>> Can you talk a bit about why this uses 'icase'? Should it be
>>> respecting cache.h:ignore_case?
>>
>> It does.That function (in dir.c) is just one-liner
>>
>>     return ignore_case ? strcasecmp(a, b) : strcmp(a, b);
>>
>> I admit though, the naming does not make that clear.

Ugh, this is only the fourth patch, yet the second stupid review
mistake I've made thus far in this series. For some reason, I kept
reading this as a call to strcasecmp() or stricmp() rather than
strcmp_icase(). Worse, I had even consulted path.c:strcmp_icase() to
see how the issue was handled there.

> While we're at it, how about renaming it to pathcmp (and its friend
> strncmp_icase to pathncmp)?

Yes, that seems like a good idea. For anyone familiar with
strcasecmp() or stricmp(), having "icase" in the name makes it seem as
though it's unconditionally case-insensitive, so dropping it from the
name would likely be beneficial.
