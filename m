From: Andreas Krey <a.krey@gmx.de>
Subject: Re: Remote's 'currently active branch' not HEAD?
Date: Fri, 6 Sep 2013 14:54:44 +0200
Message-ID: <20130906125444.GD12966@inner.h.apk.li>
References: <20130903104652.GA5813@inner.h.apk.li> <20130903114831.GA8559@inner.h.apk.li> <20130903123733.GR12966@inner.h.apk.li> <20130903130250.GB20459@pc.elego.de> <20130903135034.GS12966@inner.h.apk.li> <xmqqd2opvs18.fsf@gitster.dls.corp.google.com> <20130906114130.GB12966@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Schubert <mschub@elegosoft.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 14:55:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHvZM-0007Iu-Fq
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 14:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625Ab3IFMzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 08:55:20 -0400
Received: from continuum.iocl.org ([217.140.74.2]:51459 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325Ab3IFMzT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 08:55:19 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id r86Csiu27109;
	Fri, 6 Sep 2013 14:54:44 +0200
Content-Disposition: inline
In-Reply-To: <20130906114130.GB12966@inner.h.apk.li>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234045>

On Fri, 06 Sep 2013 13:41:30 +0000, Andreas Krey wrote:
...
> If I run the exact same commands in a shell script they succeed,
> in t5601-clone.sh the clone step seems to fail, and I have no
> clue where to look for a clue.

Oh, never mind. --verbose shows that the test is borked;
it tries a checkout into an already-existing dir. Patch
coming up soon.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
