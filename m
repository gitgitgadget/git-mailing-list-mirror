From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] push.default: Rename 'tracking' to 'upstream'
Date: Wed, 16 Feb 2011 11:26:23 +0100
Message-ID: <vpqhbc4mg1c.fsf@bauges.imag.fr>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
	<vpqy65gs6hs.fsf@bauges.imag.fr>
	<alpine.DEB.2.00.1102160421300.14950@debian>
	<201102161108.26637.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Dmitry Potapov <dpotapov@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 11:27:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppeb8-0005O7-Sp
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 11:27:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758807Ab1BPK04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 05:26:56 -0500
Received: from mx1.imag.fr ([129.88.30.5]:37513 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755126Ab1BPK0z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 05:26:55 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p1GAQNej021503
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 16 Feb 2011 11:26:23 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PpeaW-0006IX-D6; Wed, 16 Feb 2011 11:26:24 +0100
In-Reply-To: <201102161108.26637.jnareb@gmail.com> (Jakub Narebski's message of "Wed\, 16 Feb 2011 11\:08\:22 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 16 Feb 2011 11:26:24 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p1GAQNej021503
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1298456785.72347@bQZemr8MoDbtXJ58iRrqxw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166948>

Jakub Narebski <jnareb@gmail.com> writes:

> Actually while I think that it makes more sense to use local ref for
> 'branch.<name>.merge' because it is what is merged, i.e.:
>
>   branch.topic.merge = refs/remotes/origin/master
[...]
> I think that for 'branch.<name>.upstream' it would make more sense to
> use the name that *upstream* uses, i.e.
>
>   branch.topic.upstream = refs/heads/master

I disagree. Both --set-upstream and @{upstream} both refer to
refs/remotes/origin/master, i.e. the remote-tracking name in the local
repository, not to the local name in the remote repository.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
