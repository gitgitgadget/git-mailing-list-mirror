From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [1.8.0 RFD] Homogeneous use of short options
Date: Tue, 15 Feb 2011 08:18:25 +0100
Message-ID: <4D5A28C1.1080803@drmicha.warpmail.net>
References: <4D594460.1040206@drmicha.warpmail.net>	<AANLkTim1GUnyqkNbFPhkPEOitGG7PxsW1eeubkN69hf5@mail.gmail.com> <871v3a2k7i.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 15 08:21:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpFEA-0004yq-P3
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 08:21:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753833Ab1BOHVb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Feb 2011 02:21:31 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60534 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751912Ab1BOHVa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 02:21:30 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B24D62042C;
	Tue, 15 Feb 2011 02:21:29 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 15 Feb 2011 02:21:29 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=wcRH0xFpsnRbUWP82592Uh+aXIU=; b=nBM+cdtYy+QQCmAkwT78ivJ6iY9n0e5A3QlURK96RjUCoaEs5Xq+NqwMdeU33u3yGR8ENprrgUnIyLKh8YyEri1+EM/AgYjYlvSIjLt0rOtOKyvDPW9goOWbTEYnQETfRq/LDCx2PyogrnTFEb2ocTz8zzw76xIlomw+VPEq1zY=
X-Sasl-enc: zyhczYqGvgjkG/Cv7a6e5CzFTg7LXMQ8CUB9RB7ZRq8v 1297754489
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 26D1F404F5D;
	Tue, 15 Feb 2011 02:21:29 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <871v3a2k7i.fsf@catnip.gol.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166820>

Miles Bader venit, vidit, dixit 15.02.2011 01:52:
> Junio C Hamano <gitster@pobox.com> writes:
>>> add -A: Why capital A? Compare commit -a etc.
>>
>> IIRC, this was in anticipation for a similar interface to include
>> _new_ files in the commit in the form of "commit -A", which _is_
>> different from the existing "commit -a".
>=20
> I look up the meaning of "git commit -u":
>=20
> $ git commit --help
> ...
>        -u[<mode>], --untracked-files[=3D<mode>]
>            Show untracked files (Default: all).
>=20
>            The mode parameter is optional, and is used to specify the=
 handling
>            of untracked files.
>=20
>            The possible options are:
>=20
>            =C2=B7    no - Show no untracked files
>            =C2=B7    normal - Shows untracked files and directories
>            =C2=B7    all - Also shows individual files in untracked d=
irectories.
>=20
>                See git-config(1) for configuration variable used to c=
hange the
>                default for when the option is not specified.
>=20
> I guess it means it only affects the status-display for --dry-run, bu=
t
> it seems a little confusing to not say that explicitly...

I think it is confusing only until you have used "commit" without "-m"
for the first time - and only if you overlooked the 3 occurences of
"show" ;)

Michael
