From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH] Docs: git checkout --orphan: `root commit' and `branch head'
Date: Wed, 28 Sep 2011 13:50:00 +0000
Message-ID: <CAMOZ1Bu8UiV+Z0+0CLjxSv5Zic8i4=aGxnzmLc+H7c2T-P4avw@mail.gmail.com>
References: <7vaa9r2jii.fsf@alter.siamese.dyndns.org> <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
 <e88b6e560cab4ed1937dd191b4180387-mfwitten@gmail.com> <4E81F080.7010905@drmicha.warpmail.net>
 <CAMOZ1BsvnZ7PyfjOJURX+B7vCZcYheLS4pissGvPNjEivbYXtw@mail.gmail.com>
 <7v39fhyk21.fsf@alter.siamese.dyndns.org> <4E823359.7080602@nextest.com>
 <DBCBE20265964ECCA5B9724DAC74D83B@PhilipOakley> <20110927214213.GC5176@sigill.intra.peff.net>
 <CAMOZ1BvzWDPQ_e3Y5H8CX4wQwL5xf3xVvZvRL3gQPcB_kCGBbw@mail.gmail.com>
 <20110927233549.GA10434@sigill.intra.peff.net> <7vpqiltsky.fsf@alter.siamese.dyndns.org>
 <CAMOZ1BvL85xsQpZdez4VJ+dH4NoQ9RkthHY9OsmdnnaZ_tFnFg@mail.gmail.com> <vpqty7wok5a.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Philip Oakley <philipoakley@iee.org>,
	Eric Raible <raible@nextest.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 28 15:50:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8uX8-0002Ft-AE
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 15:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754409Ab1I1Nuc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Sep 2011 09:50:32 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45530 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754406Ab1I1Nub convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Sep 2011 09:50:31 -0400
Received: by vws1 with SMTP id 1so7480386vws.19
        for <git@vger.kernel.org>; Wed, 28 Sep 2011 06:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=AlQihVEHp1rXyue/NXadgmpbIb+e+kTKyFY42EuSMpc=;
        b=ebaLI5V2ewyj1/8gjjo0ipm0737dHdXOn8OG4o8C6lM6Hoc7JG+G5kANaNRYeQJhFR
         Pt8hkw2ZmotxeNIgZUgaVx3FCfvAsOw8QPepoREg9MdKF23wXCK+kThwLCB2ZQczjvD6
         FqCxUzN9mwK9CmoVc4tNiwH/56QKOb7z9dGKE=
Received: by 10.229.72.208 with SMTP id n16mr6730241qcj.165.1317217830103;
 Wed, 28 Sep 2011 06:50:30 -0700 (PDT)
Received: by 10.229.233.6 with HTTP; Wed, 28 Sep 2011 06:50:00 -0700 (PDT)
In-Reply-To: <vpqty7wok5a.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182315>

On Wed, Sep 28, 2011 at 13:45, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Michael Witten <mfwitten@gmail.com> writes:
>
>> Well, I think Jeff already proferred a solution. We could have:
>>
>> =C2=A0 git commit --no-parent
> [...]
>
> Appart from the safety objections, is the "root commit" senario commo=
n
> enough to deserve appearing in the user-interface for both "commit" a=
nd
> "checkout"?
>
> I think "git commit -h" is scary enough as it is ...

Well, as Junio mentioned, "--orphan" could be deprecated in favor of
"--no-parent"; the uncommon nature of this task works to our
advantage, in that it makes a deprecation of "--orphan" easy.
