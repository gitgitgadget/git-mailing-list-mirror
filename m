From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] completion: Add PS1 configuration for submodules
Date: Tue, 7 Dec 2010 12:41:43 -0800
Message-ID: <4F33DA75-D095-415D-99F8-5236D6F93EE1@sb.org>
References: <1291677763-55385-1-git-send-email-scott@appden.com> <AANLkTin8JstkjEWaCGZuqpEXZnLMyudFm24K7Y3iCgX6@mail.gmail.com> <AANLkTinuD2ze_mn5QMLqFaoftwZvTsz-DKv1ojAizg7P@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Scott Kyle <scott@appden.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 21:42:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ4MF-0001dY-CQ
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 21:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754953Ab0LGUlu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Dec 2010 15:41:50 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:45652 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754816Ab0LGUlu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Dec 2010 15:41:50 -0500
Received: by pva4 with SMTP id 4so93484pva.19
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 12:41:49 -0800 (PST)
Received: by 10.142.139.8 with SMTP id m8mr1468816wfd.208.1291754509617;
        Tue, 07 Dec 2010 12:41:49 -0800 (PST)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id v19sm9422511wfh.0.2010.12.07.12.41.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Dec 2010 12:41:48 -0800 (PST)
In-Reply-To: <AANLkTinuD2ze_mn5QMLqFaoftwZvTsz-DKv1ojAizg7P@mail.gmail.com>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163129>

On Dec 7, 2010, at 12:37 PM, Scott Kyle wrote:

> On Tue, Dec 7, 2010 at 4:15 AM, =C6var Arnfj=F6r=F0 Bjarmason
> <avarab@gmail.com> wrote:
>>=20
>> On Tue, Dec 7, 2010 at 00:22, Scott Kyle <scott@appden.com> wrote:
>>> For those who often work on repositories with submodules, the dirty
>>> indicator for unstaged changes will almost always show because deve=
lopment
>>> is simultaneously happening on those submodules. The config option
>>> diff.ignoreSubmodules is not appropriate for this use because it ha=
s larger
>>> implications.
>>=20
>> Wouldn't it be a lot better to instead add support for showing
>> submodule dirtyness as distinct from the main tree's dirtyness? Then
>> you could easily spot if you had either your tree / submodule tree
>> changes, without just ignoring them.
>=20
> I considered that, but thought it to be a rather disruptive change,
> and one that conceptually didn't work.  The way I see it, either
> somebody thinks of their repo as dirty when the submodules are dirty,
> or not. And I think since this behavior has perpetuated for so long,
> most users are content with how it currently works.  I, however, was
> not, and so that is why I added an option for people like me.

The big win for such a change, from my perspective, is it tells me if I=
 need
to do a `git submodule update --recursive`, or if I actually have dirty=
 changes.
Because of that, if nobody else picks this up, I'll probably write a pa=
tch
to introduce such a config at some point in the future. But as I said b=
efore,
that's something that can be done later and doesn't need to affect this=
 patch.

-Kevin Ballard