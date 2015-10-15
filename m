From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 1/3] Add Travis CI support
Date: Thu, 15 Oct 2015 19:14:15 +0200
Message-ID: <vpq7fmoyryw.fsf@grenoble-inp.fr>
References: <1444586102-82557-1-git-send-email-larsxschneider@gmail.com>
	<1444586102-82557-2-git-send-email-larsxschneider@gmail.com>
	<561CDDBA.609@gmail.com>
	<14146E1E-857D-416B-9287-F20826DCB806@gmail.com>
	<vpqwpuo35zo.fsf@grenoble-inp.fr>
	<alpine.DEB.1.00.1510151247550.31610@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Schneider <larsxschneider@gmail.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= Avila <avila.jn@gmail.com>,
	git@vger.kernel.org, tboegi@web.de, pw@padd.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 15 19:14:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zmm6o-0000wk-3L
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 19:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbbJOROZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 13:14:25 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39571 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939AbbJOROZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 13:14:25 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t9FHEDRl017995
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 15 Oct 2015 19:14:13 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9FHEFxb023734;
	Thu, 15 Oct 2015 19:14:15 +0200
In-Reply-To: <alpine.DEB.1.00.1510151247550.31610@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Thu, 15 Oct 2015 12:50:35 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 15 Oct 2015 19:14:14 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9FHEDRl017995
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1445534057.80941@qPslnMvMFRtgRF7ovA11RQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279674>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 15 Oct 2015, Matthieu Moy wrote:
>
>> Since the tests are essentially IO-bound and not CPU-bound, it may even
>> make sense to use -j3 here.
>
> I would like to caution against overloading Travis. They are really nice
> to us, we should try to be nice to them, too.

Right.

Using a bit of parallelism shouldn't harm (we put a heavier load on
them, but for a shorter time), so using -j2 or -j3 seems OK to me, but I
wouldn't go higher to remain gentle with Travis CI.

Note: I'm writting this without having a real idea of what consequence
of -jN have on their infrastructure, take my writing as wild guess, not
as real arguments.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
