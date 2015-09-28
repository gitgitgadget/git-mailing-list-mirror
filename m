From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH v1] Add Travis CI support
Date: Mon, 28 Sep 2015 19:37:32 +0200
Message-ID: <vpq4mie1m3n.fsf@grenoble-inp.fr>
References: <1443131004-39284-1-git-send-email-larsxschneider@gmail.com>
	<xmqqeghnuy8t.fsf@gitster.mtv.corp.google.com>
	<1443150875.3042.3.camel@kaarsemaker.net>
	<699c08632232180166145f70c7f16645@dscho.org>
	<CAE5ih7_f8qy9WvmgRUR6-qFwB4WFhZ6Qr5iOpE0YxqJH8AsZyw@mail.gmail.com>
	<vpq7fnc83ki.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Junio C Hamano <gitster@pobox.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Mon Sep 28 19:37:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgcMz-0002WW-GL
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 19:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934419AbbI1Rhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 13:37:41 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53491 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933540AbbI1Rhk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 13:37:40 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t8SHbU15022997
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 28 Sep 2015 19:37:30 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8SHbWBi004905;
	Mon, 28 Sep 2015 19:37:32 +0200
In-Reply-To: <vpq7fnc83ki.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Sun, 27 Sep 2015 14:11:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 28 Sep 2015 19:37:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8SHbU15022997
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1444066651.24924@c92EQPrBIR4sMJ54BDc7OQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278732>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> * If the tests always pass, nobody ever get any email from Travis-CI.

Actually, I've just been reminded that the repository owner gets one
email per new ref (tag, branch) by default.

Deactivating completely email notification is as simple as (in
.travis.yml):

notifications:
  email: false

and not getting emails when tests pass is done with

notifications:
  email:
    on_success: never

It probably makes sense to do the later in the case of Git, so that
Junio doesn't get spammed when pushing topic branches to
https://github.com/gitster/git.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
