From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv2] Warnings before rebasing -i published history
Date: Mon, 11 Jun 2012 13:39:13 +0200
Message-ID: <vpqehpm5b8e.fsf@bauges.imag.fr>
References: <1339104053-7782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1339409091-28150-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<vpq1ulm86dh.fsf@bauges.imag.fr>
	<20120611133618.Horde.ife5dHwdC4BP1dgywnBALiA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Mon Jun 11 13:39:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se2xx-0005BO-Bq
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 13:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753600Ab2FKLjV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 07:39:21 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42387 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751412Ab2FKLjU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 07:39:20 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5BBUB2X001304
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 11 Jun 2012 13:30:11 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Se2xn-0001DO-8P; Mon, 11 Jun 2012 13:39:15 +0200
In-Reply-To: <20120611133618.Horde.ife5dHwdC4BP1dgywnBALiA@webmail.minatec.grenoble-inp.fr>
	(konglu@minatec.inpg.fr's message of "Mon, 11 Jun 2012 13:36:18
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 11 Jun 2012 13:30:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5BBUB2X001304
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1340019013.66097@qj9tnpWytali26Ux7lvl1A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199645>

konglu@minatec.inpg.fr writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> a =C3=A9crit=C2=A0:
>
>> Lucien Kong <Lucien.Kong@ensimag.imag.fr> writes:
>>
>>> "git rebase -i" can be very dangerous if used on an already publish=
ed
>>> history. This code detects that one is rewriting a commit that is a=
n
>>> ancestor of a remote-tracking branch, and warns the user through th=
e
>>> editor. This feature is controlled by a new config key
>>> rebase.checkremoterefs.
>>
>> For the lazy, you could provide an example of result in the commit
>> message. People don't want to review how the patch is written if the=
y
>> disagree with the result.
>
> Right, but wouldn't it be better to put the example in the doc
> git-rebase.txt ?

Why not. In any case, it should be easy to find for reviewers (I had to
dig a little to find the expected value in the tests).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
