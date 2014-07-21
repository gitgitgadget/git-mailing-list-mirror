From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: a more helpful message on "git status" output
Date: Mon, 21 Jul 2014 12:20:33 +0200
Message-ID: <vpqtx6bnhce.fsf@anie.imag.fr>
References: <CAKQhN+rK0ftwC5hX4hDhXZbcEGAfCCBXRaQXYnMFLmR=n21OLA@mail.gmail.com>
	<xmqq38dympo8.fsf@gitster.dls.corp.google.com>
	<CAKQhN+p5FpX-GEZeX0t-Y1Sq6+fdfRpE+ACqhKgdLWGFRj0ToA@mail.gmail.com>
	<xmqqy4vql6c2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?Juli=E1n?= Landerreche <maniqui@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 12:20:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9AiA-0002tw-23
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 12:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754364AbaGUKUp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jul 2014 06:20:45 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34859 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754209AbaGUKUo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 06:20:44 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6LAKXgX013197
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Jul 2014 12:20:33 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6LAKXV9022254;
	Mon, 21 Jul 2014 12:20:33 +0200
In-Reply-To: <xmqqy4vql6c2.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 18 Jul 2014 14:12:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 21 Jul 2014 12:20:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6LAKXgX013197
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406542836.98996@WIy05V4lLOkPqOlH8uApBg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253946>

Junio C Hamano <gitster@pobox.com> writes:

> Juli=E1n Landerreche <maniqui@gmail.com> writes:
>
>> OK, I'm mostly convinced.
>> A more verbose, educational output could read:
>>
>>   (use "git pull" to fetch newer commits from upstream and update yo=
ur
>> local branch)
>>   (use "git merge" to update your local branch)
>
> I actually do not like that, to be honest.
>
> These brief reminders should be just that, and if anything, we
> should aim to make them shorter and more concise, not longer and
> more verbose.

I think so too. For someone not willing to read the doc, the current
message is sufficient, and for someone willing to read it, the output o=
f
"git status" is IHMO not a good place to teach the difference between
merge and pull.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
