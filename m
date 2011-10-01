From: Peter Shenkin <shenkin@gmail.com>
Subject: Re: [PATCH] Clarify that '--tags' fetches tags only
Date: Sat, 1 Oct 2011 21:41:09 +0000 (UTC)
Message-ID: <loom.20111001T232414-84@post.gmane.org>
References: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com> <1316649176-32352-1-git-send-email-anatol.pomozov@gmail.com> <119711285.RuumktFLOq@hyperion> <loom.20110930T041939-332@post.gmane.org> <CAMOZ1BsTKBPArRF-LxoNOJcQarMWx-2a2UBoVjWN-96xJ3Ad8A@mail.gmail.com> <loom.20111001T073652-884@post.gmane.org> <CAMOZ1Bvn64q5sVfo2-ZhTSpBttpjG1pHELJMM9sEmWsrqANCkw@mail.gmail.com> <loom.20111001T191413-25@post.gmane.org> <CAMOZ1Bsc2idQnKxeggruPi1rrY3+vsa=DoMydHY4+BM+qoW69w@mail.gmail.com> <loom.20111001T214551-834@post.gmane.org> <CAMOZ1BsYYmH6hqcB4vfCq2LAu+fxJ4MzPQ1+-erUSqU1ptx2mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 01 23:41:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RA7JU-0008IZ-IN
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 23:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717Ab1JAVl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Oct 2011 17:41:26 -0400
Received: from lo.gmane.org ([80.91.229.12]:60566 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751318Ab1JAVlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2011 17:41:25 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RA7JD-0008G6-VN
	for git@vger.kernel.org; Sat, 01 Oct 2011 23:41:24 +0200
Received: from h-67-101-25-249.nycmny83.dynamic.covad.net ([67.101.25.249])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Oct 2011 23:41:23 +0200
Received: from shenkin by h-67-101-25-249.nycmny83.dynamic.covad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Oct 2011 23:41:23 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 67.101.25.249 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.835.186 Safari/535.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182578>

Michael Witten <mfwitten <at> gmail.com> writes:
 
> On Sat, Oct 1, 2011 at 20:22, Peter Shenkin <shenkin <at> gmail.com> wrote:
>     [--tags] is merely a shorthand for writing the refspec
>     `refs/tags/\*:refs/tags/\*'; that is,

Yes, I understand that fully and it makes perfect sense.

But it leaves unexplained and undocumented the fact
that the user's specification of an *additional* refspec is
observed if the additional refspec is given on the
command line but ignored if the additional refspec is
given in the config file.

-P.
