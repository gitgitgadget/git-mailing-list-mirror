From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 0/3] fixup remaining cvsimport tests
Date: Wed, 23 Jan 2013 11:03:12 +0000
Message-ID: <20130123110312.GK7498@serenity.lan>
References: <1357878439-27500-1-git-send-email-chris@rorvick.com>
 <20130120125838.GK31172@serenity.lan>
 <CAEUsAPZKd+mw2iK7nd6rTtB8N+B99ud19FkuSx0HVitNxrxxZA@mail.gmail.com>
 <20130120152857.GM31172@serenity.lan>
 <7vsj5vlm1d.fsf@alter.siamese.dyndns.org>
 <CAEUsAPaw8EUcZFbODDj9Z-=3Ppd1CC=jvYDvuyntFkX_3V0ynQ@mail.gmail.com>
 <50FFB35C.7070809@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Rorvick <chris@rorvick.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jan 23 12:03:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Txy7O-0002Mu-MI
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 12:03:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754800Ab3AWLDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 06:03:25 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:43965 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597Ab3AWLDY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 06:03:24 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 44B84606590;
	Wed, 23 Jan 2013 11:03:23 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4PVFziHabSFl; Wed, 23 Jan 2013 11:03:23 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 01F3A606562;
	Wed, 23 Jan 2013 11:03:22 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id E45AF161E4E3;
	Wed, 23 Jan 2013 11:03:21 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6lVWqjqjJgkQ; Wed, 23 Jan 2013 11:03:21 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 88F60161E34E;
	Wed, 23 Jan 2013 11:03:15 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <50FFB35C.7070809@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214311>

On Wed, Jan 23, 2013 at 10:54:36AM +0100, Michael Haggerty wrote:
> On 01/20/2013 09:17 PM, Chris Rorvick wrote:
>> I have never used cvs2git, but I suspect Eric's efforts in making it a
>> potential backend for cvsimport are a better use of time.

Is it possible to perform an incremental import with cvs2git?  This
seems to be the one use case where the old cvsimport script (with cvsps
2.x) still performs the best.

I suppose that just re-running the full import will do the right thing
since the commits in Git should be identical, but would it be possible
to do better given the right information about a previous run?


John
