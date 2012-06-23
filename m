From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Fix formatting in git-config(1)
Date: Sat, 23 Jun 2012 10:01:48 +0200
Message-ID: <m2y5neqwwj.fsf@linux-m68k.org>
References: <m2vcil4n0w.fsf@igel.home>
	<7v4nq5twwg.fsf@alter.siamese.dyndns.org>
	<7v62ainbub.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 23 10:02:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiLIN-00011q-8H
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jun 2012 10:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753737Ab2FWICK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Jun 2012 04:02:10 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:47565 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667Ab2FWIB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2012 04:01:57 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3WK8Hh5TKLz4KK7f;
	Sat, 23 Jun 2012 10:01:51 +0200 (CEST)
Received: from linux.local (ppp-88-217-109-173.dynamic.mnet-online.de [88.217.109.173])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3WK8Hf6hTgz4KKBG;
	Sat, 23 Jun 2012 10:01:50 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
	id 72BAE1E5329; Sat, 23 Jun 2012 10:01:48 +0200 (CEST)
X-Yow: I joined scientology at a garage sale!!
In-Reply-To: <7v62ainbub.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 22 Jun 2012 16:52:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200495>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Andreas Schwab <schwab@linux-m68k.org> writes:
>>
>>> Remove the open block markers from the status.showUntrackedFiles en=
try
>>> as they cause all remaining entries to be indented one level too mu=
ch.
>>
>> Hrm...
>>
>> I looked at http://git-htmldocs.googlecode.com/git/git-config.html
>> and am unsure what "one level too much" you are referring to.  Also
>> looking at the output from
>>
>> $ git config --help
>>
>> I see (RHS end truncated to avoid line wrapping in MUA):
>>
>>     status.showUntrackedFiles
>>         By default, git-status(1) and git-commit(1) show files whi
>>         tracked by Git. Directories which contain only untracked f
>>         the directory name only. Showing untracked files means tha
>>         lstat() all all the files in the whole repository, which m
>>         systems. So, this variable controls how the commands displ
>>         files. Possible values are:
>>
>>         =C2=B7    no - Show no untracked files.
>>
>>         =C2=B7    normal - Show untracked files and directories.
>>
>>         =C2=B7    all - Show also individual files in untracked dire=
cto
>>
>>         If this variable is not specified, it defaults to normal.=20
>>         overridden with the -u|--untracked-files option of git-sta
>>         commit(1).
>
> Worse yet, with AsciiDoc 8.5.2, here is what I see with your patch
> (again, RHS end truncated to avoid line wrapping in MUA):
>
>     status.showUntrackedFiles
>
>             By default, git-status(1) and git-commit(1) show files w
>             Directories which contain only untracked files, are show
>             Showing untracked files means that Git needs to lstat()=20
>             repository, which might be slow on some systems. So, thi
>             displays the untracked files. Possible values are:
>
>                * no - Show no untracked files.
>
>                * normal - Show untracked files and directories.
>
>                * all - Show also individual files in untracked direc
>
>                  If this variable is not specified, it defaults to n
>                  with the -u|--untracked-files option of git-status(
>
> So...

I get this layout no matter what, with and without the block markers,
both with version 8.4.5 and 8.6.6.  But with the block markers the
remaining entries are indented too much.

So...

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
