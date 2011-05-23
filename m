From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Gate between git and mediawiki : remote-helpers
Date: Mon, 23 May 2011 11:08:34 +0200
Message-ID: <vpqk4dhzsvh.fsf@bauges.imag.fr>
References: <BANLkTikTpfpBYddfWcBfzGTuHqLyQ0sE5A@mail.gmail.com>
	<BANLkTim+2Mv7bnfsNVAsn80MUx8-fjYZow@mail.gmail.com>
	<7vfwo6y1kg.fsf@alter.siamese.dyndns.org>
	<BANLkTinvnm7NvUs4BuGpBYsYKR0D1eP+cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Claire Fousse <claire.fousse@gmail.com>,
	Sylvain Boulme <Sylvain.Boulme@imag.fr>
To: Arnaud Lacurie <arnaud.lacurie@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 11:08:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOR86-0007Xi-AU
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 11:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990Ab1EWJIn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 May 2011 05:08:43 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40624 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751776Ab1EWJIm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 05:08:42 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p4N98Yx3011776
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 23 May 2011 11:08:34 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QOR7r-0000h2-5M; Mon, 23 May 2011 11:08:35 +0200
In-Reply-To: <BANLkTinvnm7NvUs4BuGpBYsYKR0D1eP+cQ@mail.gmail.com> (Arnaud
	Lacurie's message of "Mon, 23 May 2011 10:31:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 23 May 2011 11:08:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p4N98Yx3011776
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1306746514.99422@VLx0grWCZbTVkVGnX6NX3w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174234>

Arnaud Lacurie <arnaud.lacurie@gmail.com> writes:

> Thank you for your advice.
>
> 2011/5/22 Junio C Hamano <gitster@pobox.com>:
>
>>
>> =A0 =A0 =A0 =A0git clone --vcs=3Dmediawiki http://some.where.xz/wiki=
/
>> =A0 =A0 =A0 =A0git pull
>> =A0 =A0 =A0 =A0git push
>>
>
> Is vcs a standard argument (I can't see it anywhere) or do we have to
> change something in order to implement it?

I don't know, but anyway, it could be

git clone mediawiki+http://some.where.xz/wiki

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
