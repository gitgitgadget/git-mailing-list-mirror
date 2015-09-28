From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH v1] Add Travis CI support
Date: Mon, 28 Sep 2015 21:07:18 +0200
Message-ID: <vpqfv1yz7kp.fsf@grenoble-inp.fr>
References: <1443131004-39284-1-git-send-email-larsxschneider@gmail.com>
	<xmqqeghnuy8t.fsf@gitster.mtv.corp.google.com>
	<1443150875.3042.3.camel@kaarsemaker.net>
	<699c08632232180166145f70c7f16645@dscho.org>
	<CAE5ih7_f8qy9WvmgRUR6-qFwB4WFhZ6Qr5iOpE0YxqJH8AsZyw@mail.gmail.com>
	<vpq7fnc83ki.fsf@grenoble-inp.fr> <vpq4mie1m3n.fsf@grenoble-inp.fr>
	<xmqqlhbqcrf7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Luke Diamand <luke@diamand.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 21:07:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zgdls-0004Co-7i
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 21:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbbI1TH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 15:07:27 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36089 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750730AbbI1TH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 15:07:27 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t8SJ7G4c017793
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 28 Sep 2015 21:07:16 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8SJ7Iut006070;
	Mon, 28 Sep 2015 21:07:18 +0200
In-Reply-To: <xmqqlhbqcrf7.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 28 Sep 2015 11:47:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 28 Sep 2015 21:07:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8SJ7G4c017793
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1444072038.99518@nTpEc8wEW4iYrvAe893n7A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278745>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> It probably makes sense to do the later in the case of Git, so that
>> Junio doesn't get spammed when pushing topic branches to
>> https://github.com/gitster/git.
>
> I won't enable it on github.com:gitster/git anyway, so I do not
> think that is a concern.  I thought what people are talking about
> was to add it on github.com:git/git, but have I been misreading the
> thread?  I do not even own the latter repository (I only can push
> into it).

You're right: github.com:gitster/git shouldn't be affected. Builds are
triggered for branches outside github.com:git/git only when a
pull-requests to git/git is submitted.

So, you'd get a "success" email only when pushing a new tag (since the
set of branches does not change).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
