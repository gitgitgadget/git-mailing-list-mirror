From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: Re: v1.5.4 plans
Date: Wed, 12 Dec 2007 14:21:57 -0800 (PST)
Message-ID: <772829.29268.qm@web52407.mail.re2.yahoo.com>
References: <7vodcv7kw6.fsf@gitster.siamese.dyndns.org>
Reply-To: ddkilzer@kilzer.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Dec 12 23:22:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2ZyE-0001K7-Ur
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 23:22:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbXLLWV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 17:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752525AbXLLWV7
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 17:21:59 -0500
Received: from web52407.mail.re2.yahoo.com ([206.190.48.170]:39084 "HELO
	web52407.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752393AbXLLWV6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Dec 2007 17:21:58 -0500
Received: (qmail 29551 invoked by uid 60001); 12 Dec 2007 22:21:57 -0000
X-YMail-OSG: cIOsN7QVM1nXRvVJ17YLMkHlGC.giZhtfBK_RGct6zhPfMxXXWHd75CNfjgHC5j.HU0.Lw--
Received: from [17.202.20.198] by web52407.mail.re2.yahoo.com via HTTP; Wed, 12 Dec 2007 14:21:57 PST
X-RocketYMMF: ddkilzer
In-Reply-To: <7vodcv7kw6.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68105>

Junio C Hamano <gitster@pobox.com> wrote:

> Eric Wong <normalperson@yhbt.net> writes:
> 
> > I also noticed some race-conditions on this test when running this on my
> > Centrino laptop (my fastest box, but I rarely use it for git
> > development) and having git on my USB thumb drive.  I'm pretty sure
> > these were caused by inconsistencies in handling timestamps on symlinks
> > vs timestamps on the files they link to.
> 
> I actually saw that for the first time on my primary box during the
> nightly rebuild last night.  I'll disable the test for now --- if we can
> spot and fix the race by the release, that's good, otherwise, shipping
> the test disabled is also fine, too.

I'll see if I can reproduce it and figure out where the race is happening.

Dave
