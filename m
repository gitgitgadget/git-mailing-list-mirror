From: Yaroslav Halchenko <yoh@onerussian.com>
Subject: Re: wishlist; unify behavior while cloning non-bare repos over http
 to be in line with ssh/local
Date: Tue, 10 May 2016 15:06:52 -0400
Message-ID: <20160510190652.GI7907@onerussian.com>
References: <20160506131855.GD7907@onerussian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Benjamin Poldrack <benjaminpoldrack@gmail.com>,
	Michael Hanke <michael.hanke@gmail.com>
To: Git Gurus hangout <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 10 21:07:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0Czs-0005X5-UQ
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 21:07:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbcEJTG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 15:06:59 -0400
Received: from washoe.dartmouth.edu ([129.170.30.229]:36279 "EHLO
	smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569AbcEJTG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 15:06:58 -0400
Received: from smtp.onerussian.com ([192.168.100.6] helo=washoe.onerussian.com)
	by smtp.onerussian.com with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <yoh@onerussian.com>)
	id 1b0Czc-0003Uy-L4; Tue, 10 May 2016 15:06:52 -0400
Received: from yoh by washoe.onerussian.com with local (Exim 4.84)
	(envelope-from <yoh@onerussian.com>)
	id 1b0Czc-0003Ut-Ft; Tue, 10 May 2016 15:06:52 -0400
Content-Disposition: inline
In-Reply-To: <20160506131855.GD7907@onerussian.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294173>


On Fri, 06 May 2016, Yaroslav Halchenko wrote:

> Dear Git Folks,

> Originally this issue was mentioned in previous thread [1], and I have decided
> to bring it into a separate thread.  ATM there is a dichotomy in git behavior
> between cloning non-bare repos:  if I clone over ssh or just locally by
> providing url without trailing /.git, git senses for /.git and works just fine
> with ssh or local repositories, but fails for "dummy" http ones, the demo
> script is here [2] which produces output listed below.  From which you can see
> that  cloning using http URL to the repository without /.git fails (git version
> 2.8.1, Debian).  As it was noted in [1], concern could have been to not
> traverse website since could lead to dangerous places.  But .git is under
> originating url directory, as well as info/ or HEAD or any other object
> accessed by git, so IMHO this concern is not a concern.
> ...

If there is a better venue (bug tracker?) to spark the interest
and discussion, please let me know ;)

-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
