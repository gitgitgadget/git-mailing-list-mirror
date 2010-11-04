From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] git-rebase--interactive.sh: Add new command "shell"
Date: Thu, 4 Nov 2010 02:25:13 -0700
Message-ID: <EE792829-6A68-44FB-8C8D-2365DB4E5A5D@sb.org>
References: <1288847836-84882-1-git-send-email-kevin@sb.org> <vpq39rhzdht.fsf@bauges.imag.fr> <914D7AE3-22D5-4069-B815-2B11A2897BE9@sb.org> <AANLkTimzTzUvoHT9bHve-qvt8V_mvJHmQtgpqY6f_H3u@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 10:25:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDw4S-0000Eq-DT
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 10:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103Ab0KDJZR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Nov 2010 05:25:17 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61781 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932096Ab0KDJZQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Nov 2010 05:25:16 -0400
Received: by gwj21 with SMTP id 21so1185808gwj.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 02:25:16 -0700 (PDT)
Received: by 10.42.213.2 with SMTP id gu2mr152526icb.75.1288862715989;
        Thu, 04 Nov 2010 02:25:15 -0700 (PDT)
Received: from [10.0.1.14] (c-24-130-32-253.hsd1.ca.comcast.net [24.130.32.253])
        by mx.google.com with ESMTPS id fw4sm2085582ibb.19.2010.11.04.02.25.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Nov 2010 02:25:15 -0700 (PDT)
In-Reply-To: <AANLkTimzTzUvoHT9bHve-qvt8V_mvJHmQtgpqY6f_H3u@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160701>

On Nov 4, 2010, at 2:23 AM, =C6var Arnfj=F6r=F0 Bjarmason wrote:

> On Thu, Nov 4, 2010 at 09:53, Kevin Ballard <kevin@sb.org> wrote:
>> On Nov 4, 2010, at 1:42 AM, Matthieu Moy wrote:
>>=20
>>> Kevin Ballard <kevin@sb.org> writes:
>>>=20
>>>> Add a new command "shell", which takes an option commit. It simply=
 exits
>>>> to the shell with the commit (if given) and a message telling the =
user how
>>>> to resume the rebase.
>>>=20
>>> "shell" sounds like you're going to execute something in a shell, n=
ot
>>> that you're going back to the shell. Looking at the commit message,=
 I
>>> thought you had missed the "exec" command and re-implemented it.
>>>=20
>>> What about "pause", abbreviated as "p" for the command name?
>>=20
>> That sounds like a reasonable suggestion, except "p" is already take=
n by "pick".
>> I suppose this command could simply omit the short version.
>=20
> I thought "shell" would do exactly what your patch does. And it has
> the "s" short version.
>=20
> So +1 for "shell" from me and -1 for "pause", which *does* confuse me=
=2E
> I'd expect that
> to just sleep for a few seconds.

"s" is actually taken by "squash". That's why my original patch used "!=
",
though a user might actually expect "!" to do what "x" does.

-Kevin Ballard