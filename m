From: Yaroslav Halchenko <debian@onerussian.com>
Subject: gitk: highlighting commits "touching path" with globs doesn't work
 for files list
Date: Thu, 29 Nov 2012 08:51:30 -0500
Message-ID: <20121129135130.GA24445@onerussian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 29 15:28:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te56i-00048h-5B
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 15:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754803Ab2K2O2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 09:28:36 -0500
Received: from washoe.Dartmouth.EDU ([129.170.30.229]:35632 "EHLO
	smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754647Ab2K2O2f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 09:28:35 -0500
X-Greylist: delayed 2224 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Nov 2012 09:28:35 EST
Received: from smtp.onerussian.com ([192.168.100.6] helo=washoe.onerussian.com)
	by smtp.onerussian.com with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <yoh@onerussian.com>)
	id 1Te4WY-000788-VA
	for git@vger.kernel.org; Thu, 29 Nov 2012 08:51:30 -0500
Received: from yoh by washoe.onerussian.com with local (Exim 4.72)
	(envelope-from <yoh@onerussian.com>)
	id 1Te4WY-000785-Mo
	for git@vger.kernel.org; Thu, 29 Nov 2012 08:51:30 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 192.168.100.6
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
X-SA-Exim-Scanned: No (on smtp.onerussian.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210836>

Hi GIT Gurus,

Highlighting files (in patch view) and commits which modified those
files is a really nice feature to have.   Often it is needed to
highlight based on a glob expression for files, e.g. '*Makefile*'
-- that seems to highlight the commits but files in the patch view
are no longer highlighted, which significantly reduces usefulness of
such a feature.

Also, those choices (Exact/IgnCase/Regexp) seems to have no relation
with the edit box when looking for "touching path" files, so shouldn't
it be somehow disabled/emptied to avoid users trying to create the
ultimate filepattern regexp for no good reason?  (the same for next
field on where to search through -- All Fields/... ) ;)

-- 
Yaroslav O. Halchenko
Postdoctoral Fellow,   Department of Psychological and Brain Sciences
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
