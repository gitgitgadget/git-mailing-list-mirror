From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] tg-log: move note from tg base to tg log
Date: Mon, 4 Oct 2010 23:08:55 +0200
Message-ID: <AANLkTine7qKg_jCMxt-OfE5bqitr5b4NacTF5jnsBNDw@mail.gmail.com>
References: <AANLkTi=sc-FBG=CeNTv9H4Fj0KqdHkoudjQHqEYZxPuV@mail.gmail.com>
	<1286219189-22054-1-git-send-email-bert.wesarg@googlemail.com>
	<87vd5h1xei.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	git@vger.kernel.org, Peter Simons <simons@cryp.to>, pasky@suse.cz,
	Per Cederqvist <ceder@lysator.liu.se>,
	Olaf Dabrunz <odabrunz@gmx.net>,
	Thomas Moschny <thomas.moschny@gmx.de>,
	martin f krafft <madduck@madduck.net>
To: =?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 23:09:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2sHP-00068m-IG
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 23:09:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254Ab0JDVI6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 17:08:58 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:62684 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932128Ab0JDVI5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 17:08:57 -0400
Received: by gxk9 with SMTP id 9so1793759gxk.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 14:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6vYxjxKEKRiU+1IC6vToIe7xlIZCocB2e7tK7z1xfw8=;
        b=DpGGd+X2/7xNI99ICl4zTTmqahkqC/AWG/Sy17h/QCzU7JuRaaQFvE7VRm81BjXA+J
         yl/HKgLqxUJvHp2bgIkBmWO1buS+9hEFzJQY9bDJxJdbE27DRcjUCv2AMzEqgt2Bf51d
         P2RTS18+DkFC7RoAMhoWFF0rGK2IvUuGs8M+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZRlSURpp/hsHQgmhZiH1PCaN3mZIWlKzKx/iX3R4yCFMgmr4E8GOnjkiCTDMgCv6O5
         1fV8muoJ9XGatFyW1pBYXbT1WCS8ZJpLhvvt8ywybHa96ir7qvQzkUzVSezwNSPFVztC
         SMDvXyKHhGjd+s999RyNIJDV7m/uI4DE5firg=
Received: by 10.231.30.134 with SMTP id u6mr10777944ibc.121.1286226535588;
 Mon, 04 Oct 2010 14:08:55 -0700 (PDT)
Received: by 10.231.171.149 with HTTP; Mon, 4 Oct 2010 14:08:55 -0700 (PDT)
In-Reply-To: <87vd5h1xei.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158121>

On Mon, Oct 4, 2010 at 23:05, =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem=
@gmail.com> wrote:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>
> [...]
>
>> - =C2=A0 =C2=A0 (Note: if you have shared the TopGit branch, the abo=
ve command
>> - =C2=A0 =C2=A0 only lists the commits that were made in the current
>> - =C2=A0 =C2=A0 repository, so you will not see work done by your
>> - =C2=A0 =C2=A0 collaborators.)
>> + =C2=A0 =C2=A0 branch.
>>
>> =C2=A0tg log
>> =C2=A0~~~~~~
>> =C2=A0 =C2=A0 =C2=A0 Prints the git log of the named topgit branch.
>>
>> + =C2=A0 =C2=A0 Note: if you have shared the TopGit branch, this com=
mand
>> + =C2=A0 =C2=A0 only lists the commits that where made in the curren=
t
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^^^^
>
> You managed to introduce a typo while (mostly just) moving the paragr=
aph. :-)

And I thought I fixed this typo ;-)

Thanks.

Bert

>
> =C5=A0t=C4=9Bp=C3=A1n
>
