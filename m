From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: RFD: Handling case-colliding filenames on case-insensitive filesystems
Date: Wed, 23 Feb 2011 20:17:23 +0100
Message-ID: <vpq62sa36ik.fsf@bauges.imag.fr>
References: <201102231811.45948.johan@herland.net>
	<AANLkTi=MyqXYi=zNZ+MFcUW2p-_icwg0m_aMQpVioT8J@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 23 20:17:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsKDQ-00063b-UW
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 20:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461Ab1BWTRb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 14:17:31 -0500
Received: from mx1.imag.fr ([129.88.30.5]:36464 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932241Ab1BWTRb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 14:17:31 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p1NJHLH2025013
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 23 Feb 2011 20:17:21 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PsKDD-0006CJ-8K; Wed, 23 Feb 2011 20:17:23 +0100
In-Reply-To: <AANLkTi=MyqXYi=zNZ+MFcUW2p-_icwg0m_aMQpVioT8J@mail.gmail.com>
	(Jay Soffian's message of "Wed, 23 Feb 2011 14:07:35 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 23 Feb 2011 20:17:21 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p1NJHLH2025013
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1299093444.99071@wG7+Jr+US/0WSStJH4tGrA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167714>

Jay Soffian <jaysoffian@gmail.com> writes:

> The checkout can't be compiled correctly, so what's the point of even
> allowing it?

There's at least one: allow the user to fix it.

I'm not a user of case-insensitive filesystem, but I guess it must be
terribly frustrating for a user to have the tool say "your repo is so
broken that I'm not even going to show you what's it in".

Now, it doesn't solve the problem of people having case-colliding
filenames on purpose ...

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
