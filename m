From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v2 00/25] Remove assumptions about each_ref_fn arg lifetimes
Date: Wed, 29 May 2013 10:25:03 +0200
Message-ID: <8761y2ura8.fsf@linux-k42r.v.cablecom.net>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"Johan Herland" <johan@herland.net>, <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed May 29 10:25:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhbh4-0005CN-06
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 10:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100Ab3E2IZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 04:25:07 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:58984 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965029Ab3E2IZF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 04:25:05 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 29 May
 2013 10:24:59 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 cas10.d.ethz.ch (172.31.38.210) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Wed, 29 May 2013 10:25:03 +0200
In-Reply-To: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Sat, 25 May 2013 11:07:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225776>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>

I read the entire series on Monday, and give it an Ack at maybe 90%
confidence level -- sorry, I was short on caffeine and sleep ;-)

I meant to verify this assertion:

> I did a manual audit of the 50 (!) functions that are used as an
> each_ref_fn callback to the for_each_ref()-style functions.  (I hope I
> haven't missed any.)  I checked that they do not make the assumption
> that the lifetimes of the refname and sha1 arguments extend past the
> duration of the callback invocation.  There were a number of callers
> that got this wrong; I believe I have fixed them all.

But time ran out, and I wouldn't want you to hold your breath.  The
series is a big improvement even if another caller slipped through the
cracks.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
