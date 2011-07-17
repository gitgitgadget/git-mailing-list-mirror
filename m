From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git commit generation numbers
Date: Sun, 17 Jul 2011 16:58:59 -0700
Message-ID: <CA+55aFwt+RDRK_r=9CXbdzsLuGDqswvGTtJDKi9Q3DQwB_Ha5Q@mail.gmail.com>
References: <CA+55aFwqFhzd_cmbFxkCyNXhF99igBqdr8p4J76hLz=m4=ZNWg@mail.gmail.com>
 <20110717233959.3548.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 01:59:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QibFA-0000kf-IB
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 01:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756371Ab1GQX7W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Jul 2011 19:59:22 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37532 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756323Ab1GQX7V convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2011 19:59:21 -0400
Received: from mail-ww0-f44.google.com (mail-ww0-f44.google.com [74.125.82.44])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p6HNxJfY015051
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Sun, 17 Jul 2011 16:59:20 -0700
Received: by wwe5 with SMTP id 5so2688422wwe.1
        for <git@vger.kernel.org>; Sun, 17 Jul 2011 16:59:19 -0700 (PDT)
Received: by 10.216.237.131 with SMTP id y3mr2485295weq.87.1310947159087; Sun,
 17 Jul 2011 16:59:19 -0700 (PDT)
Received: by 10.216.158.65 with HTTP; Sun, 17 Jul 2011 16:58:59 -0700 (PDT)
In-Reply-To: <20110717233959.3548.qmail@science.horizon.com>
X-Spam-Status: No, hits=-102.921 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177326>

On Sun, Jul 17, 2011 at 4:39 PM, George Spelvin <linux@horizon.com> wro=
te:
>
> I'm slapping my forehead like Homer Simpson here. =A0The fact that co=
mputing
> the generation number is expensive is why it's worth cacheing. =A0But=
 the
> fact that it *can* be computed is a reason not to clutter the publish=
ed
> commit object format with it.

And I'm slapping *my* forehead.

Nobody has *ever* given a reason why the cache would be better than
just making it explicit.

That's my issue.

Why is that so hard for people to understand? The cache is just EXTRA W=
ORK.

To take your TLB example: it's like having a TLB for a page table that
would be as easy to just create in a way that it's *faster* to look up
in the actual data structure than it would be to look up in the cache.

Or to take your disk cache example: wouldn't you say that a disk cache
is a F&*&ING BAD IDEA if it is slower than the disk it caches?

Seriously.

                    Linus
