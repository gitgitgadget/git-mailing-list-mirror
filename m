From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [Request] Git reset should be able to ignore file permissions
Date: Tue, 18 Jun 2013 18:00:31 +0200
Message-ID: <vpqy5a7mmsg.fsf@anie.imag.fr>
References: <CACuz9s31OUWNxTqCmj7ukAo7=TpXK7zBv5kTFZ5obpXKOju9ng@mail.gmail.com>
	<vpqsj0fr19j.fsf@anie.imag.fr>
	<CACuz9s1KGKsL-pGftAtAWyX5gUA5c-PYyJUSstf+xw151rZLtA@mail.gmail.com>
	<vpq7ghrqzrv.fsf@anie.imag.fr>
	<CACuz9s0=7z-M1-zgRNUs2hS-4LcuXrsWbqyDaMnuvFXRnP7E-Q@mail.gmail.com>
	<vpqppvjpjz3.fsf@anie.imag.fr>
	<CACuz9s2DfN5O91ZF8QOnWuA0V3bGFuUG5RVmkmjeL7Jien+fYg@mail.gmail.com>
	<CACuz9s1H2Gi+B7=Fc3yJ+PC9oDueLQzXstSX0C9uAy3_MN4Kag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Alexander Nestorov <alexandernst@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 18:00:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoyKn-0004W1-QW
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 18:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755921Ab3FRQAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 12:00:38 -0400
Received: from mx2.imag.fr ([129.88.30.17]:39887 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755818Ab3FRQAh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 12:00:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5IG0Tdp010147
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 18 Jun 2013 18:00:31 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UoyKd-0007PV-VF; Tue, 18 Jun 2013 18:00:31 +0200
In-Reply-To: <CACuz9s1H2Gi+B7=Fc3yJ+PC9oDueLQzXstSX0C9uAy3_MN4Kag@mail.gmail.com>
	(Alexander Nestorov's message of "Tue, 18 Jun 2013 17:51:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 18 Jun 2013 18:00:32 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228258>

Alexander Nestorov <alexandernst@gmail.com> writes:

> I'm home, https://github.com/alexandernst/git/commit/61f0a7d558e3cbae308fabdff66bd87569d6aa18
> Is that good?

Please, post your patches inline, it eases review. More generally, read
Documentation/SubmittingPatches.

+Ignore file permissions::

It's not only about permissions, and it does not "ignore" them, it just
notices when there's actually no change although the mtime has changed.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
