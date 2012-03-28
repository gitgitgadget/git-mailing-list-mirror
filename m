From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git add -p and unresolved conflicts
Date: Wed, 28 Mar 2012 17:21:41 +0200
Message-ID: <vpqvclozr7e.fsf@bauges.imag.fr>
References: <CABPQNSYVXMxS3kugu1j=62ArJ_1saYYfMjJdZvqhjgPFGN=Eqw@mail.gmail.com>
	<7vbongyd67.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: kusmabite@gmail.com, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 17:21:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCuh8-0007rr-IV
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 17:21:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757702Ab2C1PVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 11:21:49 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55015 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754734Ab2C1PVs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 11:21:48 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q2SFGXVn027259
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 28 Mar 2012 17:16:33 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SCugw-0006as-3Z; Wed, 28 Mar 2012 17:21:42 +0200
In-Reply-To: <7vbongyd67.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 28 Mar 2012 08:10:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 28 Mar 2012 17:16:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q2SFGXVn027259
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1333552595.23232@M9mec9G5X0X6JmVnUaddMw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194129>

Junio C Hamano <gitster@pobox.com> writes:

> I mildly suspect nobody would come up with a sane behaviour, but what
> would I know...

Designing a per-hunk behavior would clearly be very tricky.

But a simple way to deal with this would be to show the whole-file
patch, and ask "stage this file (yes/no)?".

My fingers are used to typing

git add -p
y
y
y
git commit

and they would appreciate if it worked in the presence of conflicts.
Most of the time, I have small conflicts, so a whole-file behavior
wouldn't be disturbing, but I like seeing the changes before commiting
them.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
