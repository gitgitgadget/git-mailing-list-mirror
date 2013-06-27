From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [BUG] rebase should desambiguate abbreviated hashes before starting
Date: Thu, 27 Jun 2013 13:04:10 +0200
Message-ID: <vpq1u7n3jdh.fsf@anie.imag.fr>
References: <20130627105513.6bf84060@chalon.bertin.fr>
	<CAMPXz=pSseQKebNVPVYogTZ2FUc1LqubgmS+pN76sveV=eqC0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Yann Dirson <dirson@bertin.fr>, git list <git@vger.kernel.org>
To: David <bouncingcats@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 27 13:04:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Us9zu-0001kY-Qr
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 13:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566Ab3F0LEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 07:04:14 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38827 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806Ab3F0LEO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 07:04:14 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5RB4AXo026082
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 27 Jun 2013 13:04:10 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Us9zn-0005zU-8y; Thu, 27 Jun 2013 13:04:11 +0200
In-Reply-To: <CAMPXz=pSseQKebNVPVYogTZ2FUc1LqubgmS+pN76sveV=eqC0A@mail.gmail.com>
	(David's message of "Thu, 27 Jun 2013 19:38:04 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 27 Jun 2013 13:04:10 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229094>

David <bouncingcats@gmail.com> writes:

> I'm not sure that rebase could predict the new hashes without actually creating
> the prior commits? So maybe the "short" SHA1 is "too short"?

It's OK to show the short sha1 to the user, but "git rebase" could and
should expand these to complete sha1 right after the editor is closed. I
think that's what Yann means.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
