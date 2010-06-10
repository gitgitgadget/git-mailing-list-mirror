From: Dario Rodriguez <soft.d4rio@gmail.com>
Subject: Re: [PATCH/RFC] Fix for default pager
Date: Thu, 10 Jun 2010 08:31:38 -0300
Message-ID: <AANLkTimI0DAHWzAPYRcui3h7KDvf1NFQBx0p4LdlYHTJ@mail.gmail.com>
References: <4C0E5103.7030501@viscovery.net>
	<AANLkTilWg8hw5j20o-xGsVO-q_OeSmtKEKAO6O416qvH@mail.gmail.com>
	<4C0E6810.3070301@viscovery.net>
	<AANLkTinZSuXJEXzpvEavYNLSyqUlx8qzWlrbtIH6q6fx@mail.gmail.com>
	<4C0E932B.3010702@viscovery.net>
	<AANLkTinB_SBilMOfgnHtDrQS-NBOLF4yY5NaP7ZvN9rK@mail.gmail.com>
	<4C0EB741.9020905@op5.se>
	<AANLkTinAO5empFix9W_rbtU3Vv4O73OsJBtA1stb66DS@mail.gmail.com>
	<20100610082916.GA5559@coredump.intra.peff.net>
	<AANLkTinLt3p0q-q5oDFk5CWzdhqQ2lwkWuvpdPzKZvYe@mail.gmail.com>
	<20100610085952.GA8269@coredump.intra.peff.net>
	<4C10AF43.5050708@spacetec.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	git <git@vger.kernel.org>
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Thu Jun 10 13:31:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMfzB-0005a4-7S
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 13:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755799Ab0FJLbn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jun 2010 07:31:43 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62921 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823Ab0FJLbn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jun 2010 07:31:43 -0400
Received: by bwz7 with SMTP id 7so36536bwz.19
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 04:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=F0dwsP3e3rqCE7Q05QBDG99u79L93zhFJ6+syGuu+v0=;
        b=UE4yUrgfXRvNvV3PiWENBPcIF7o5PNzqbASZtBtZ749YAz3YZyVUBzClZpZGmo+Hmd
         8aB5TzXUj35Zk6czPlC/707iRsf+6nfN9jVfJQ46l5qPmXtsX2zBr3Iq9DUnCfTngCNU
         3WV6xXMNhJT40MaDX5QYkj+z1EdQ4Qw51B22g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=M+LcqF77o8MSTOJ0sBR8YDgAhLI49gDKpM6+Ducu6z0ua7vjX2IruN7sS4B9qshAMk
         EuLp89Hvib2XJ5mhngAvRZ781f71V4ohqfmMCOQeEhCKCfLV9G/6scRoeC+rb5DqvUEz
         1vw2uYIhjMP0/vfnUvjaaN3hQFfvepZ7MwrT4=
Received: by 10.204.74.25 with SMTP id s25mr43876bkj.76.1276169499053; Thu, 10 
	Jun 2010 04:31:39 -0700 (PDT)
Received: by 10.204.82.142 with HTTP; Thu, 10 Jun 2010 04:31:38 -0700 (PDT)
In-Reply-To: <4C10AF43.5050708@spacetec.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148856>

On Thu, Jun 10, 2010 at 6:24 AM, Tor Arntsen <tor@spacetec.no> wrote:
> On 06/10/10 10:59, Jeff King wrote:
>> On Thu, Jun 10, 2010 at 10:48:31AM +0200, Tor Arntsen wrote:
>>
>>> That looks good to me.
>>
>> OK, here it is with a commit message. Other systems might want the s=
ame,
>> I guess (Solaris, IRIX?). I'm cc'ing Brandon, who might have some in=
put.
>>
>> Note that this is completely untested by me, as all of my AIX boxen =
have
>> gone away in the past few months (yay!).
>
> I did a re-build and test. Everything works fine.
>
> Tested-by: Tor Arntsen <tor@spacetec.no>
>
> -Tor
>
> -- >8 --
> Subject: [PATCH] Makefile: default pager on AIX to "more"
>
> AIX doesn't ship with "less" by default, and their "more" is
> more featureful than average, so the latter is a more
> sensible choice. =A0People who really want less can set the
> compile-time option themselves, or users can set $PAGER.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> =A0Makefile | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 34b7dd5..6ad0aca 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -930,6 +930,7 @@ ifeq ($(uname_S),NetBSD)
> =A0 =A0 =A0 =A0HAVE_PATHS_H =3D YesPlease
> =A0endif
> =A0ifeq ($(uname_S),AIX)
> + =A0 =A0 =A0 DEFAULT_PAGER =3D more
> =A0 =A0 =A0 =A0NO_STRCASESTR=3DYesPlease
> =A0 =A0 =A0 =A0NO_MEMMEM =3D YesPlease
> =A0 =A0 =A0 =A0NO_MKDTEMP =3D YesPlease
> -- 1.7.1.514.g71ed8
>

It's ok for me, I will test it on AIX today, if I've some time.

Cheers,
Dario
