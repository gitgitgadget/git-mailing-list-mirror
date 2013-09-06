From: Andreas Krey <a.krey@gmx.de>
Subject: Re: Remote's 'currently active branch' not HEAD?
Date: Fri, 6 Sep 2013 13:41:30 +0200
Message-ID: <20130906114130.GB12966@inner.h.apk.li>
References: <20130903104652.GA5813@inner.h.apk.li> <20130903114831.GA8559@inner.h.apk.li> <20130903123733.GR12966@inner.h.apk.li> <20130903130250.GB20459@pc.elego.de> <20130903135034.GS12966@inner.h.apk.li> <xmqqd2opvs18.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Schubert <mschub@elegosoft.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 13:43:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHuRk-00014l-C7
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 13:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243Ab3IFLnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 07:43:24 -0400
Received: from continuum.iocl.org ([217.140.74.2]:51397 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab3IFLnY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 07:43:24 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id r86BfUS24506;
	Fri, 6 Sep 2013 13:41:30 +0200
Content-Disposition: inline
In-Reply-To: <xmqqd2opvs18.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234040>

On Tue, 03 Sep 2013 08:33:39 +0000, Junio C Hamano wrote:
...
> Reading the patch series from 2008 again, I do agree with J6t's
> comment that it should be just a regular capability,

I've implemented it as a 'sym=refs/heads/foo' capability.
It actually makes the patch series a lot shorter; the only
thing I don't get running is the t5601-clone.sh test case.

If I run the exact same commands in a shell script they succeed,
in t5601-clone.sh the clone step seems to fail, and I have no
clue where to look for a clue.

Any pointers?

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
