From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] [git-am] Handle "git show" output correctly
Date: Wed, 12 Sep 2012 17:57:46 +0200
Message-ID: <vpqbohbz11h.fsf@bauges.imag.fr>
References: <vpqligfz1sa.fsf@bauges.imag.fr>
	<1347464989-17421-1-git-send-email-pjones@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Peter Jones <pjones@redhat.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 17:58:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBpKG-0003y0-Tf
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 17:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759703Ab2ILP54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 11:57:56 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43972 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966Ab2ILP5z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 11:57:55 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q8CFqehP018760
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 12 Sep 2012 17:52:40 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TBpJy-0006yl-UX; Wed, 12 Sep 2012 17:57:47 +0200
In-Reply-To: <1347464989-17421-1-git-send-email-pjones@redhat.com> (Peter
	Jones's message of "Wed, 12 Sep 2012 11:49:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 12 Sep 2012 17:52:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q8CFqehP018760
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1348069964.39297@LhcAGFhyAuVkUbeKJVRc9g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205306>

Peter Jones <pjones@redhat.com> writes:

> Subject: [PATCH] [git-am] Handle "git show" output correctly

The convention in Git is "<subsystem>: <summary of change>" (i.e. no
brackets around git-am, just am: and no capital for Handle).

My other concerns (name of stgit, multi-lines subject lines and lack of
documentation) still hold.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
