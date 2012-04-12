From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: GIT pull
Date: Thu, 12 Apr 2012 17:03:58 +0200
Message-ID: <vpqiph5m1pd.fsf@bauges.imag.fr>
References: <1334242077960-7459655.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: cvalusek <clintv2@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 17:04:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SILZG-0007y2-7B
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 17:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934325Ab2DLPEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 11:04:08 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44973 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757552Ab2DLPEG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 11:04:06 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q3CEw5iw012376
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 12 Apr 2012 16:58:05 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SILZ1-0001jM-7k; Thu, 12 Apr 2012 17:03:59 +0200
In-Reply-To: <1334242077960-7459655.post@n2.nabble.com> (cvalusek's message of
	"Thu, 12 Apr 2012 07:47:57 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 12 Apr 2012 16:58:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3CEw5iw012376
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1334847489.49547@TWVnxI8WN37zywQ6QctUXw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195331>

cvalusek <clintv2@gmail.com> writes:

> If a user has local modifications not on the index and does a pull, I have
> seen git attempt to start applying the merge to master and abort. The whole
> checkout is then left in a terrible state that is nearly
> unrecoverable.

What do you mean by "terrible state"? What does "git status" say?

> In the past, I thought GIT would run some sort of check to identify
> these problems before it attempts the merge.

Git does check uncommited changes before merging. It allows the merge if
the changes touch different files (i.e. if the merge is guaranteed not
to touch the same files as the one for which you have uncommited
changes).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
