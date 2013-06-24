From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] status: really ignore config with --porcelain
Date: Mon, 24 Jun 2013 19:21:37 +0200
Message-ID: <vpqobavs9um.fsf@anie.imag.fr>
References: <1372077912-18625-1-git-send-email-artagnon@gmail.com>
	<1372077912-18625-2-git-send-email-artagnon@gmail.com>
	<vpqhagnwraj.fsf@anie.imag.fr>
	<CALkWK0=F_i95S+53eZmOAJtA+jG=jvi5-sDc3BgW3rNQo=n3Ng@mail.gmail.com>
	<vpqhagnv9xq.fsf@anie.imag.fr>
	<7vk3ljbh5r.fsf@alter.siamese.dyndns.org>
	<vpq7ghjtpv1.fsf@anie.imag.fr>
	<7v1u7rbf9v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 19:23:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrAUW-0001Oj-5Z
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 19:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881Ab3FXRXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 13:23:44 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54555 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750964Ab3FXRXn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 13:23:43 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5OHLa5S010551
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 24 Jun 2013 19:21:36 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UrASQ-0001Os-9Q; Mon, 24 Jun 2013 19:21:38 +0200
In-Reply-To: <7v1u7rbf9v.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 24 Jun 2013 10:16:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 24 Jun 2013 19:21:36 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228880>

Junio C Hamano <gitster@pobox.com> writes:

> That means after we add more and more other options like --branch
> that enrich the output in several years, scripts that want to use
> the enriched data need to pass tons of options to get what they
> want, which is not very nice,

Right, but accepting status.branch would not even solve that. Script
writers should not assume that status.branch is set. So, the --branch is
still required.

Actually, that would even be worse, as a script writer who's used to
status.branch being set would not even notice that --branch is missing.
So, he'd still need it, but would have greater chance to miss it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
