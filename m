From: Yaroslav Halchenko <yoh@onerussian.com>
Subject: Re: 'next'ed --allow-unrelated-histories could cause lots of grief
Date: Thu, 21 Apr 2016 16:36:06 -0400
Message-ID: <20160421203606.GM23764@onerussian.com>
References: <20160421161043.GK7907@onerussian.com>
 <xmqqbn52ud6r.fsf@gitster.mtv.corp.google.com>
 <20160421185528.GJ23764@onerussian.com>
 <xmqqinzasqgv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Benjamin Poldrack <benjaminpoldrack@gmail.com>,
	Joey Hess <id@joeyh.name>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Git Gurus hangout <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 21 22:36:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atLKh-0008RO-9G
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 22:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215AbcDUUgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 16:36:10 -0400
Received: from washoe.dartmouth.edu ([129.170.30.229]:54500 "EHLO
	smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbcDUUgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 16:36:09 -0400
Received: from smtp.onerussian.com ([192.168.100.6] helo=washoe.onerussian.com)
	by smtp.onerussian.com with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <yoh@onerussian.com>)
	id 1atLKY-0002ug-Q9; Thu, 21 Apr 2016 16:36:06 -0400
Received: from yoh by washoe.onerussian.com with local (Exim 4.84)
	(envelope-from <yoh@onerussian.com>)
	id 1atLKY-0002ub-G4; Thu, 21 Apr 2016 16:36:06 -0400
Content-Disposition: inline
In-Reply-To: <xmqqinzasqgv.fsf@gitster.mtv.corp.google.com>
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: 192.168.100.6
X-SA-Exim-Rcpt-To: git@vger.kernel.org, benjaminpoldrack@gmail.com, id@joeyh.name, torvalds@linux-foundation.org
X-SA-Exim-Mail-From: yoh@onerussian.com
X-SA-Exim-Scanned: No (on smtp.onerussian.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292152>


On Thu, 21 Apr 2016, Junio C Hamano wrote:
> >> It is not very productive to make such an emotional statement
> >> without substantiating _why_ a merge that adds a new root, which was
> >> declared in the thread above as "crap" (in the context of the kernel
> >> project),

> > Sorry if my statement sounded too emotional ;)  I will outline some of
> > the use-cases below.

> Thanks.  Emotional is fine, as long as you _also_ have useful
> information.

Gotcha:  I will follow "emotional + useful == fine" advice closer
next time ;)

Thank you a lot for the suggested patch with the env variable
workaround!
-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
