From: Stephen Smith <ischis2@cox.net>
Subject: Re: [PATCH v2 2/2] object name: introduce =?utf-8?b?J157LyEtPG5lZ2F0aXZl?= =?utf-8?b?cGF0dGVybj59Jw==?= notation
Date: Fri, 8 Jan 2016 06:04:34 +0000 (UTC)
Message-ID: <loom.20160108T065547-969@post.gmane.org>
References: <1433550295-15098-1-git-send-email-wmpalmer@gmail.com> <1433550295-15098-3-git-send-email-wmpalmer@gmail.com> <xmqqbngqcfxd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 08 07:10:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHQFc-0000zL-70
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 07:10:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbcAHGKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 01:10:09 -0500
Received: from plane.gmane.org ([80.91.229.3]:60376 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751076AbcAHGKI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 01:10:08 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aHQFR-0000p7-LU
	for git@vger.kernel.org; Fri, 08 Jan 2016 07:10:06 +0100
Received: from ip68-231-74-134.ph.ph.cox.net ([68.231.74.134])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Jan 2016 07:10:05 +0100
Received: from ischis2 by ip68-231-74-134.ph.ph.cox.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Jan 2016 07:10:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 68.231.74.134 (Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:42.0) Gecko/20100101 Firefox/42.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283527>

Junio C Hamano <gitster <at> pobox.com> writes:
> >  	echo modified >>a-blob &&
> >  	git add -u &&
> >  	git commit -m Modified &&
> > +	git branch modref &&
> 
> This probably belongs to the previous step, no?
> 
What did you mean by this comment?  I looked at the original patch and at 
Will's response to your comment and am not quite sure what was meant.

> > +test_expect_success 'ref^{/!-}' '
> > +	test_must_fail git rev-parse master^{/!-}
> > +'
> 
I plan on leaving this in.

> > +test_expect_success 'ref^{/!-.}' '
> > +	test_must_fail git rev-parse master^{/!-.}
> > +'
> 
I plan on leaving this in.
