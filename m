From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Warnings before rebasing -i published history
Date: Fri, 08 Jun 2012 16:25:08 +0200
Message-ID: <vpqsje5rid7.fsf@bauges.imag.fr>
References: <1339104053-7782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<vpqy5ny22z5.fsf@bauges.imag.fr>
	<20120608160341.Horde.IGByfXwdC4BP0gY9a0fV0PA@webmail.minatec.grenoble-inp.fr>
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
X-From: git-owner@vger.kernel.org Fri Jun 08 16:25:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd085-0000wq-Hw
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 16:25:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934353Ab2FHOZS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jun 2012 10:25:18 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34399 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934333Ab2FHOZP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 10:25:15 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q58EGPeX029575
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 8 Jun 2012 16:16:25 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Sd07h-0007BA-TI; Fri, 08 Jun 2012 16:25:09 +0200
In-Reply-To: <20120608160341.Horde.IGByfXwdC4BP0gY9a0fV0PA@webmail.minatec.grenoble-inp.fr>
	(konglu@minatec.inpg.fr's message of "Fri, 08 Jun 2012 16:03:41
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 08 Jun 2012 16:16:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q58EGPeX029575
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339769787.48264@SplbLFjpr8VyUAG/sJnTYQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199493>

konglu@minatec.inpg.fr writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> a =C3=A9crit=C2=A0:
>
>>>  test -s "$todo" || echo noop >> "$todo"
>>>  test -n "$autosquash" && rearrange_squash "$todo"
>>> +warn_published "$todo"
>>
>> That should be configurable.
>
> Do you mean that it should be controlled by a key config (maybe a new
> advice.*) in the config file ? Or through an option ?

That should be a config key, I don't think a user wants to type
--no-published-warnings each time he doesn't want warnings.

Current usage of advice.* is a bit different as it usually talks about
git's output on the terminal, but I think added comments in the rebase
todolist would be an acceptable use of advice.*.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
