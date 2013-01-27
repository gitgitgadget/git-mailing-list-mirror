From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] git-remote-testpy: fix patch hashing on Python 3
Date: Sun, 27 Jan 2013 22:42:08 +0000
Message-ID: <20130127224208.GV7498@serenity.lan>
References: <7vwquzzkiw.fsf@alter.siamese.dyndns.org>
 <5104B0B5.1030501@alum.mit.edu>
 <20130127141329.GN7498@serenity.lan>
 <20130127145056.GP7498@serenity.lan>
 <7vzjzuv224.fsf@alter.siamese.dyndns.org>
 <20130127200401.GT7498@serenity.lan>
 <7vr4l6v11z.fsf@alter.siamese.dyndns.org>
 <20130127202106.GU7498@serenity.lan>
 <7va9ruuzsf.fsf@alter.siamese.dyndns.org>
 <7v622iuzea.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 23:42:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzavw-0005Xr-If
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 23:42:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756799Ab3A0WmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 17:42:19 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:52309 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755199Ab3A0WmS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 17:42:18 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 7093B202D1;
	Sun, 27 Jan 2013 22:42:17 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id baVzNzc-JlN6; Sun, 27 Jan 2013 22:42:16 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 1D47622CBE;
	Sun, 27 Jan 2013 22:42:10 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7v622iuzea.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214745>

On Sun, Jan 27, 2013 at 12:47:09PM -0800, Junio C Hamano wrote:
> I remember that I earlier asked somewhere if we want to say "Python
> 3.x that is older than 3.y is unsupported"
> 
>     http://thread.gmane.org/gmane.comp.version-control.git/213920/focus=213926
> 
> but I was told that we will support all versions in 3.x series, IIRC.
> 
> Does this patch contradict with that?  If so I think we would need
> to revisit the update to CodingGuidelines in that thread.

Yes.  I'll send an update to that over the next couple of days.

I think 3.1 and later is fine, when I said "Python 3.0 is unsupported"
in the commit message below, I meant "unsupported by the Python
developers".  Support ended at least 3 months ago:

    http://hg.python.org/peps/rev/6d2e9d41dfaa


John
