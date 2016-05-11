From: Yaroslav Halchenko <yoh@onerussian.com>
Subject: Re: wishlist; unify behavior while cloning non-bare repos over http
 to be in line with ssh/local
Date: Tue, 10 May 2016 20:49:31 -0400
Message-ID: <20160511004931.GX23764@onerussian.com>
References: <xmqqfutpoepz.fsf@gitster.mtv.corp.google.com>
 <20160510221032.GV23764@onerussian.com>
 <xmqq8tzhmuiz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Benjamin Poldrack <benjaminpoldrack@gmail.com>,
	Michael Hanke <michael.hanke@gmail.com>
To: Git Gurus hangout <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 11 02:49:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0ILL-0006X2-MK
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 02:49:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbcEKAtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 20:49:33 -0400
Received: from washoe.dartmouth.edu ([129.170.30.229]:41149 "EHLO
	smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092AbcEKAtd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 20:49:33 -0400
Received: from smtp.onerussian.com ([192.168.100.6] helo=washoe.onerussian.com)
	by smtp.onerussian.com with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <yoh@onerussian.com>)
	id 1b0ILD-0006vh-Cl; Tue, 10 May 2016 20:49:31 -0400
Received: from yoh by washoe.onerussian.com with local (Exim 4.84)
	(envelope-from <yoh@onerussian.com>)
	id 1b0ILD-0006vb-6f; Tue, 10 May 2016 20:49:31 -0400
Content-Disposition: inline
In-Reply-To: <xmqq8tzhmuiz.fsf@gitster.mtv.corp.google.com>
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: 192.168.100.6
X-SA-Exim-Rcpt-To: git@vger.kernel.org, benjaminpoldrack@gmail.com, michael.hanke@gmail.com
X-SA-Exim-Mail-From: yoh@onerussian.com
X-SA-Exim-Scanned: No (on smtp.onerussian.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294209>


On Tue, 10 May 2016, Junio C Hamano wrote:
> >> The necessary update to the client might be as simple as using
> >> $GIVEN_URL/.git/ and attempting the request again after seeing the
> >> probe for $GIVEN_URL/info/refs fails.

> > Sure -- workarounds are possible,...

> Just so that there is no misunderstanding, the above was not a
> workaround but is an outline of an implementation of updated http
> client shipped with Git.

ah, sorry, I have indeed might have misread it.  So we are on the same
page -- that is I saw also as the tentative implementation ;)

-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
