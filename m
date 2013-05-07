From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] contrib/hooks/post-receive-email: get description from repo.git/config
Date: Tue, 07 May 2013 09:49:20 +0200
Message-ID: <vpq7gjbrzzz.fsf@grenoble-inp.fr>
References: <15tsj20cizd.fsf@tux.uio.no>
	<7vtxmgruhc.fsf@alter.siamese.dyndns.org>
	<vpq1u9kunba.fsf@grenoble-inp.fr>
	<7vwqrbmh4d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Trond Hasle Amundsen <t.h.amundsen@usit.uio.no>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 07 09:49:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZceh-0003Us-Qm
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 09:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757049Ab3EGHtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 03:49:43 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37776 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756504Ab3EGHtm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 03:49:42 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r477nK3q024751
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 7 May 2013 09:49:20 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UZceG-0000ls-N0; Tue, 07 May 2013 09:49:20 +0200
In-Reply-To: <7vwqrbmh4d.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 06 May 2013 23:36:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 07 May 2013 09:49:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r477nK3q024751
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1368517760.78873@PRYT9QbNvm+kseSdEYWOOQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223565>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> More precisely: you should have a look at git-multimail (in directory
>> contrib/, in branch for now pu/, or from
>> https://github.com/mhagger/git-multimail) before spending time on
>> post-receive-email.
>
> Oh, by the way, is this a vote of confidence in that topic, hinting
> that we would want to advance it to 'next'?

I definitely would like to see git-multimail in contrib/, and to have it
considered as "the recommended way to send emails from a hook". It does
all the old script did, and much more.

post-receive-email can stay for people who don't have Python on their
servers, or for existing users who don't want to migrate.

My preference would go for a subtree merge to keep the existing history
(that would mean extracting a subdirectory of git-multimail's tree
before merging it to git.git).

> As it is only adding a new script to contrib/, it could be argued
> that we could even push it to 1.8.3-rc1,

OTOH, it's not urgent, people can already use git-multimail by taking it
from GitHub.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
