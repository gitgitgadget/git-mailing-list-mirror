From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH 1/2] remote: Remove -v/--verbose option from git remote
 show synopsis
Date: Fri, 9 Jan 2015 01:22:13 +0600
Message-ID: <CANCZXo41D9pYEPKAXmS3kYOjniXzoWMJK55Eooa=STAna8F0AA@mail.gmail.com>
References: <1420739863-11602-1-git-send-email-kuleshovmail@gmail.com>
	<54AED7C3.8010604@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Thu Jan 08 20:23:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9Iew-0001vz-8y
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 20:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755333AbbAHTWO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jan 2015 14:22:14 -0500
Received: from mail-oi0-f50.google.com ([209.85.218.50]:41331 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856AbbAHTWN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jan 2015 14:22:13 -0500
Received: by mail-oi0-f50.google.com with SMTP id x69so8801534oia.9
        for <git@vger.kernel.org>; Thu, 08 Jan 2015 11:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=yNr1DODE95/fxx68ZY8laZBj3xKapGjHaJ/lE2R44E4=;
        b=zHN8Pa+CN5jLRTVPutNcjQ6363pUD2g1tTn1bEFLhuZ9x7v8VItUrusCruJpEdFdr3
         pvPZh9F8k020RaMXnheAEINtY7LTiNyiN7XKYHPWusovJ5MElvdMFXM/zkxN2T3u6t5z
         dLZFs7SMD1ESUdNET5RfqIJLJPYowKt5eVqm4cDWt+WJCcLysyCaWK6adZD2eB8FojsO
         UeQVo5qSWI6JK6JLBz67itbiSpKMJzPkRmkk1+6Fb+wNP03NM2Ta1dqHkNpD0sdxBYF0
         zFkUr1aCmSPnLnOyknetVx8cD2EVRMSGXdp9I2eMYNWfToEh8G8A6jeSBHdchcdaHzSH
         Ayng==
X-Received: by 10.202.185.69 with SMTP id j66mr6422340oif.86.1420744933381;
 Thu, 08 Jan 2015 11:22:13 -0800 (PST)
Received: by 10.182.26.42 with HTTP; Thu, 8 Jan 2015 11:22:13 -0800 (PST)
In-Reply-To: <54AED7C3.8010604@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262210>

Ah, yes, right. Please dismiss 1,2 patches.

Sorry for noise

2015-01-09 1:17 GMT+06:00 Ren=C3=A9 Scharfe <l.s.r@web.de>:
> Am 08.01.2015 um 18:57 schrieb Alexander Kuleshov:
>>
>> git remote show doesn't use -v/--verbose option
>
>
> Hmm, but it does?
>
>         $ git version
>         git version 2.2.1
>         $ git remote show
>         origin
>         $ git remote -v show
>         origin  git://git.kernel.org/pub/scm/git/git.git (fetch)
>         origin  git://git.kernel.org/pub/scm/git/git.git (push)
>
> Perhaps you meant the following variant?  The changed line documents =
the one
> above, though (-v before show).
>
>         $ git remote show -v
>         error: unknown switch `v'
>         usage: git remote show [<options>] <name>
>
>             -n                    do not query remotes
>
>
>> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
>> ---
>>   builtin/remote.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/builtin/remote.c b/builtin/remote.c
>> index 46ecfd9..978c645 100644
>> --- a/builtin/remote.c
>> +++ b/builtin/remote.c
>> @@ -14,7 +14,7 @@ static const char * const builtin_remote_usage[] =3D=
 {
>>         N_("git remote rename <old> <new>"),
>>         N_("git remote remove <name>"),
>>         N_("git remote set-head <name> (-a | --auto | -d | --delete
>> |<branch>)"),
>> -       N_("git remote [-v | --verbose] show [-n] <name>"),
>> +       N_("git remote show [-n] <name>"),
>>         N_("git remote prune [-n | --dry-run] <name>"),
>>         N_("git remote [-v | --verbose] update [-p | --prune] [(<gro=
up> |
>> <remote>)...]"),
>>         N_("git remote set-branches [--add] <name> <branch>..."),
>>
>



--=20
_________________________
0xAX
