From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 0/4 v2] push.default upcomming change
Date: Sun, 22 Apr 2012 13:05:41 +0200
Message-ID: <vpqipgs81ru.fsf@bauges.imag.fr>
References: <vpqfwbye9re.fsf@bauges.imag.fr>
	<1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
	<20120420203552.GC13103@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 22 13:06:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLucd-0002uX-3H
	for gcvg-git-2@plane.gmane.org; Sun, 22 Apr 2012 13:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688Ab2DVLGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Apr 2012 07:06:18 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37009 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751652Ab2DVLF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2012 07:05:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q3MAxRTh005112
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 22 Apr 2012 12:59:27 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SLubu-0003ao-Ei; Sun, 22 Apr 2012 13:05:42 +0200
In-Reply-To: <20120420203552.GC13103@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 20 Apr 2012 13:35:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 22 Apr 2012 12:59:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3MAxRTh005112
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1335697170.16029@qPUNkiy3B6FUgcD7tp3DWA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196078>

Jeff King <peff@peff.net> writes:

> The "Git 2.0" mention in patch 4/4 might need to be tweaked. :)

The "Git 2.0" comes from Junio. I don't mind changing that to "Git 1.9.0
or Git 2.0, whichever is released earlier".

Actually, I'm starting to think that the "warning" part should be
delayed a bit: we probably want to wait for the "simple" implementation
to be available widely before we start advising people to set it
explicitely (otherwise, people using different Git versions on different
machines, but sharing the same configuration will get complaints from
Git about invalid value).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
