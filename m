From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [Request] Git reset should be able to ignore file permissions
Date: Wed, 19 Jun 2013 13:37:05 +0200
Message-ID: <vpqfvwel4bi.fsf@anie.imag.fr>
References: <CACuz9s31OUWNxTqCmj7ukAo7=TpXK7zBv5kTFZ5obpXKOju9ng@mail.gmail.com>
	<vpqsj0fr19j.fsf@anie.imag.fr>
	<CACuz9s1KGKsL-pGftAtAWyX5gUA5c-PYyJUSstf+xw151rZLtA@mail.gmail.com>
	<vpq7ghrqzrv.fsf@anie.imag.fr>
	<CACuz9s0=7z-M1-zgRNUs2hS-4LcuXrsWbqyDaMnuvFXRnP7E-Q@mail.gmail.com>
	<vpqppvjpjz3.fsf@anie.imag.fr>
	<CACuz9s2DfN5O91ZF8QOnWuA0V3bGFuUG5RVmkmjeL7Jien+fYg@mail.gmail.com>
	<CACuz9s1H2Gi+B7=Fc3yJ+PC9oDueLQzXstSX0C9uAy3_MN4Kag@mail.gmail.com>
	<vpqy5a7mmsg.fsf@anie.imag.fr>
	<CACuz9s2KEne5_PwHwmsd1X7iE=GB3pC=iUzxSo=t6TbF+ZjCxA@mail.gmail.com>
	<vpqsj0emzdu.fsf@anie.imag.fr>
	<CACuz9s0jqe9zErBLZ5+kv2OCKW5fFHq0sifc2GS=n4jFpDiQZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Alexander Nestorov <alexandernst@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 13:37:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpGhP-0006oK-Up
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 13:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934268Ab3FSLhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 07:37:09 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58357 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934052Ab3FSLhI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 07:37:08 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5JBb3QX017230
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 19 Jun 2013 13:37:04 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UpGhF-0001ze-Af; Wed, 19 Jun 2013 13:37:05 +0200
In-Reply-To: <CACuz9s0jqe9zErBLZ5+kv2OCKW5fFHq0sifc2GS=n4jFpDiQZw@mail.gmail.com>
	(Alexander Nestorov's message of "Wed, 19 Jun 2013 10:00:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 19 Jun 2013 13:37:04 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228391>

Alexander Nestorov <alexandernst@gmail.com> writes:

> Ok, this is how it looks. If everything is ok, I'm sending it to the ML

Please, read Documentation/SubmittingPatches (you lack a sign-off and if
you think the patch is ready, you should Cc Junio). Also, it's better to
have the commit headers directly as mail headers (git send-email is your
friend).

> +Reset only files who's content changed (instead of stat information)::

That's still not 100% accurate. Actual mode changes would trigger a
rewrite of the file. Perhaps stg like

Reset only files which actually changed (not those with only stat information change)::

(Sorry for nitpicking so much)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
