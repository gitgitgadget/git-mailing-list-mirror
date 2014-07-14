From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 28/32] gc: style change -- no SP before closing bracket
Date: Sun, 13 Jul 2014 21:40:17 -0700
Message-ID: <CAPc5daVnE4P4f9vC0r=jrzxU9exs1f1R8hVJyzqTNrpzW5MVGg@mail.gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
 <1404891197-18067-29-git-send-email-pclouds@gmail.com> <CAPig+cSfbs3NuyfbrUrJ5BGP9J7GvGCSda2E7ZjA2k4ZXotNRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 06:40:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6Y4C-0006eh-Be
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 06:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbaGNEkk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jul 2014 00:40:40 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:37181 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbaGNEkj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jul 2014 00:40:39 -0400
Received: by mail-lb0-f180.google.com with SMTP id w7so2467610lbi.11
        for <git@vger.kernel.org>; Sun, 13 Jul 2014 21:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=4NZalR3C1qrrtY/ezV+Wb/+zzfzIIQJ3NP/+nrWKfWQ=;
        b=bm0Yndmnkw83626Ds7lCpJouVpc6UM+1UuZsc91KKyxJtk93z9dbSRi+kl2S0PyDbr
         0z8sQATp/KXlwEJr/tWA17YXMtvwLsWLtHJlYFPxOumQpVRlj1qu+uukHdQ8EpbpLCht
         iA/lIY5CVvLy5XtT+J7t771Ss6+P1Id2Hi4j8VE99MQ5ez3vY8rNW/O8dq3BYks4xR8Z
         NqiPz18UpG3bxPzPoWuu+ieonDmOScKmEdRS3sgH9HNBGzj0o9rtRzFzao4Wsyf0MJhJ
         HGOkQ0xQfqRmeROOlUTNE1eaekQkO3EXYg24ShZf3S4LIp6sSO6L3pQq7VFogL6Bv6wE
         zHXQ==
X-Received: by 10.152.29.72 with SMTP id i8mr9130265lah.38.1405312837753; Sun,
 13 Jul 2014 21:40:37 -0700 (PDT)
Received: by 10.112.26.212 with HTTP; Sun, 13 Jul 2014 21:40:17 -0700 (PDT)
In-Reply-To: <CAPig+cSfbs3NuyfbrUrJ5BGP9J7GvGCSda2E7ZjA2k4ZXotNRQ@mail.gmail.com>
X-Google-Sender-Auth: vFS62EsoYAiCGmAhfTEnlO96rgM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253468>

On Wed, Jul 9, 2014 at 2:47 AM, Eric Sunshine <sunshine@sunshineco.com>=
 wrote:
> On Wed, Jul 9, 2014 at 3:33 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy <pclouds@gmail.com> wrote:
>
> Yet, there is a space after the opening '{'. So, this is now
> inconsistently formatted as:
>
>     { foo, bar}
>

So, if we drop the other hunk and keep only the one below,
the patch needs to be retitled with s/bracket/parenthesis/...

>> @@ -298,7 +298,7 @@ int cmd_gc(int argc, const char **argv, const ch=
ar *prefix)
>>         argv_array_pushl(&pack_refs_cmd, "pack-refs", "--all", "--pr=
une", NULL);
>>         argv_array_pushl(&reflog, "reflog", "expire", "--all", NULL)=
;
>>         argv_array_pushl(&repack, "repack", "-d", "-l", NULL);
>> -       argv_array_pushl(&prune, "prune", "--expire", NULL );
>> +       argv_array_pushl(&prune, "prune", "--expire", NULL);
>>         argv_array_pushl(&rerere, "rerere", "gc", NULL);
>>
>>         git_config(gc_config, NULL);
>> --
>> 1.9.1.346.ga2b5940
