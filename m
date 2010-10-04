From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH 4/6] tg-prev/tg-next: commands to explore dependencies
Date: Mon, 4 Oct 2010 08:48:26 +0200
Message-ID: <AANLkTi=EcKuUUaGvEPk+DQ-S5q4CvKh6MN0O8Aup1V-a@mail.gmail.com>
References: <AANLkTim3gnU+_krD2QM0BAMf9DZi2_4hva6dq4WXcatH@mail.gmail.com>
	<1286141157-30422-1-git-send-email-bert.wesarg@googlemail.com>
	<1286141157-30422-2-git-send-email-bert.wesarg@googlemail.com>
	<1286141157-30422-3-git-send-email-bert.wesarg@googlemail.com>
	<1286141157-30422-4-git-send-email-bert.wesarg@googlemail.com>
	<20101003215520.GC28679@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Per Cederqvist <ceder@lysator.liu.se>, git@vger.kernel.org,
	Peter Simons <simons@cryp.to>, pasky@suse.cz,
	Olaf Dabrunz <odabrunz@gmx.net>,
	Thomas Moschny <thomas.moschny@gmx.de>,
	martin f krafft <madduck@madduck.net>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Mon Oct 04 08:48:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2eqh-00054M-Mc
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 08:48:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674Ab0JDGs1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 02:48:27 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58624 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596Ab0JDGs1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 02:48:27 -0400
Received: by iwn5 with SMTP id 5so6531637iwn.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 23:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IqZdoY4VEFaW9zFOmBJIPtXLJ+UBbTDZllQz8Bp64XY=;
        b=mgnQ/6ZuRNkfKmthFe5isu1mrWp/vIRuEd6WAD5oaTuHgxK3/UZuZbbPrmJzItGJTO
         MBj4HqHhgX0Gx/AdOtEH8qQwdLhrT6rE2w581XFy+1+UROlS2miViLAcC+uXLmSAckkZ
         0I6VwJmLExq49GxI3g4VxhtqVtd0NFGtKZZ+4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tqVmDhXDy8EdEIxLDDTLI1L3567wvvAk+d/lVD+j5fGuroj9hd7x/KSPQHVSJIc2AZ
         MPajyQNk4kMwucieKihenUZOnBCA3+u+DME3tX2dguNKUDQ+Zl1LMzeufsZWYx6rXpuQ
         zaCxzymaRkvT9W73Rx2XGESqzgXKiLcY+dWs0=
Received: by 10.231.172.83 with SMTP id k19mr9683364ibz.114.1286174906091;
 Sun, 03 Oct 2010 23:48:26 -0700 (PDT)
Received: by 10.231.171.149 with HTTP; Sun, 3 Oct 2010 23:48:26 -0700 (PDT)
In-Reply-To: <20101003215520.GC28679@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157989>

2010/10/3 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
> Hi,
>
> On Sun, Oct 03, 2010 at 11:25:55PM +0200, Bert Wesarg wrote:
>> Two new commands to explore the dependencies of TopGit branches:
>>
>> =C2=A0 a) tg prev [-i | -w] [NAME]
>> =C2=A0 =C2=A0 =C2=A0outputs the dependencies of NAME
>>
>> =C2=A0 b) tg next [-i | -w] [NAME]
>> =C2=A0 =C2=A0 =C2=A0outputs branches which depends on NAME
> I wonder if this is somehow mergable with Per's checkout [next|prev].
> (contained in git://repo.or.cz/topgit/tsort.git, t/checkout)
>
> What do you think?

While this is obviously possible. I'm more a friend of many small
commands like quilt has it.

Also, I have a follow-up patch that prints all offending branches, not
only the directly one (--all option).

Bert

>
> Best regards
> Uwe
