From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Hint at "checkout -p" in the "reset --patch <type>" error message
Date: Thu, 25 Nov 2010 02:56:05 -0800 (PST)
Message-ID: <m3mxox4qr3.fsf@localhost.localdomain>
References: <AANLkTimc=Dt9YSu=J=7C-f1hZ9UODU7VHu6oD8dmFX3N@mail.gmail.com>
	<AANLkTimP9zr=wQDYeBxtvYCE1mZ1aHXQ_nLOxGFfR9YD@mail.gmail.com>
	<AANLkTimQ644C-dEoJTj8bNd9y+YzpMez7D1KLZFNEe7c@mail.gmail.com>
	<AANLkTindHnjeXEGbKWiQkWgoUBwqZbdx71sQwNr_gFp0@mail.gmail.com>
	<AANLkTi=5w3YpYu0_WbmHud0BUkO2BqYNVezWDMkCaSj2@mail.gmail.com>
	<AANLkTimEOULR8_PAs5iPu7z+n4DQPSyDKYg8RghZxosz@mail.gmail.com>
	<87mxp086k5.fsf_-_@gmail.com>
	<20101123145921.GB3145@sigill.intra.peff.net>
	<87ipzo83o9.fsf@gmail.com> <4CEE2472.5020901@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-2?q?=A9t=ECp=E1n_N=ECmec?= <stepnem@gmail.com>,
	Jeff King <peff@peff.net>, Jeenu V <jeenuv@gmail.com>,
	knittl <knittl89@googlemail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Nov 25 11:57:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLZVo-0006A9-V6
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 11:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393Ab0KYK5F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Nov 2010 05:57:05 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56764 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066Ab0KYK5C convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Nov 2010 05:57:02 -0500
Received: by fxm13 with SMTP id 13so646276fxm.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 02:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=GHnBTB8+x44v09PMNyIq9I6bRAQfx8B6lGpVbnXeaF0=;
        b=FpJbDp9qX/1lGNOheyomjl64Yd+4cyvMr+LqDPlkSm4uDdpq/XdR3x00g9hPuSEI9O
         +tjf68Pt6XyACfRaRWW1k0FxjHtruO20fzAoh9kcvJP6/K7cZnKB+mUDl0r96sFUKzHc
         y5Nb/OsIObemZ8MsJ7voVfgxyhpz5KMiSHyT0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=lsGz0HOcoiwzopNG23pM77QugNRjgbUJRVIjCIKNxwPdAf0CI4OC4Ps8h1CibftJZr
         TgnRDReQWmKMEGAYm3kM5nAx0RAsN2hvnrpIhmHz321DiCTWzv+YeSUsEy9JdTH2/F32
         fAZttKmWyonxZ7aascQnZRuhP84iQNjgUAX2U=
Received: by 10.223.53.68 with SMTP id l4mr571461fag.44.1290682621551;
        Thu, 25 Nov 2010 02:57:01 -0800 (PST)
Received: from localhost.localdomain (abwg199.neoplus.adsl.tpnet.pl [83.8.230.199])
        by mx.google.com with ESMTPS id a24sm458199fak.3.2010.11.25.02.56.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 02:56:05 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oAPAtedG010435;
	Thu, 25 Nov 2010 11:55:46 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oAPAtDfu010430;
	Thu, 25 Nov 2010 11:55:13 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4CEE2472.5020901@drmicha.warpmail.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162125>

Michael J Gruber <git@drmicha.warpmail.net> writes:
> =A9t=ECp=E1n N=ECmec venit, vidit, dixit 23.11.2010 16:23:
>> Jeff King <peff@peff.net> writes:
>>> On Tue, Nov 23, 2010 at 03:20:58PM +0100, =A9t=ECp=E1n N=ECmec wrot=
e:
>>>
>>>> diff --git a/builtin/reset.c b/builtin/reset.c
>>>> index 0037be4..fc530d2 100644
>>>> --- a/builtin/reset.c
>>>> +++ b/builtin/reset.c
>>>> @@ -309,7 +309,8 @@ int cmd_reset(int argc, const char **argv, con=
st char *prefix)
>>>> =20
>>>>  	if (patch_mode) {
>>>>  		if (reset_type !=3D NONE)
>>>> -			die("--patch is incompatible with --{hard,mixed,soft}");
>>>> +			die("--patch is incompatible with --{hard,mixed,soft}\n"
>>>> +			    "(use \"git checkout -p\" to selectively discard changes i=
n working directory)");
>>>>  		return interactive_reset(rev, argv + i, prefix);
>>>>  	}

[...]
>=20
> The man page for git-reset points at git-checkout already.
>=20
> Until we have a "verbosity level" config across all commands, I don't
> favor adding a lot of hints to command error messages.

Errrr... but we do have "verbosity level" config in the form of
advice.* configuration variables.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
