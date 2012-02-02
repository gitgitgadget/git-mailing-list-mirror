From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] i18n: po for zh_cn
Date: Thu, 2 Feb 2012 11:56:09 +0800
Message-ID: <CANYiYbF+ZqGVdpxXzBkPMUwoWO+EdSb1WHqUCdQEmj5AjR1LDw@mail.gmail.com>
References: <1328111436-58925-1-git-send-email-worldhello.net@gmail.com>
	<CACBZZX6mHQ8NLWiBjp5OtDpFAc1=s9XfzHY5HhQ-26pqLXQ3bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 02 04:56:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsnmp-0005WV-KN
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 04:56:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754941Ab2BBD4L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Feb 2012 22:56:11 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53627 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754177Ab2BBD4K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2012 22:56:10 -0500
Received: by yhoo21 with SMTP id o21so921738yho.19
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 19:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=LMEUdJbFFcTwsulViwn3vX5KHihtTNZ3jWI0yacDByo=;
        b=FXp/eGxGAL1R1jd0luS0ZQ6zC2Ndgu6518cizZXcYwCIrPvZgw0WhkCI4JLfocqlPk
         hOHTpvrbfb8bAin6hxPgZ5wUolG+Ib7roQY6awzCvj48e72u1WNGRyc5Jjdkb0iIjyGI
         r8ok8hkTccDizJlrwpJbsmQDuPVLit3mn0t3U=
Received: by 10.236.139.193 with SMTP id c41mr1453228yhj.24.1328154969459;
 Wed, 01 Feb 2012 19:56:09 -0800 (PST)
Received: by 10.236.153.195 with HTTP; Wed, 1 Feb 2012 19:56:09 -0800 (PST)
In-Reply-To: <CACBZZX6mHQ8NLWiBjp5OtDpFAc1=s9XfzHY5HhQ-26pqLXQ3bg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189579>

2012/2/2 =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>:
> On Wed, Feb 1, 2012 at 16:50, Jiang Xin <worldhello.net@gmail.com> wr=
ote:
>> Git can speak Chinese now.
>
> That's very nice, and it passes the msgfmt --check test as well, so
> all looks good.

One bug, the filename should be zh_CN.po, not zh_cn.po. On my Mac,
the filesystem is case insensitive, locale works fine, but in Linux won=
't.

I will send the patch again with correct filename and with translates
for news message from Git master branch.
(previous l10n is against git v1.7.9, i.e. the maint branch)

>
> As an aside doesn't the bug / workaround described in
> https://github.com/git/git/blob/master/gettext.c#L35 impact chinese
> especially badly? I'd expect any place where we use strerror() to sho=
w
> up as total gibberish.

The perror test program does impact chinese too.
On Linux with well translated system error messages, with the following=
 output:

    $ ./test
    test: ??????

On Mac without translated system error messages, output is all ascii.


--=20
Jiang Xin
