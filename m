From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] Rename {git- => git}remote-helpers.txt
Date: Thu, 31 Jan 2013 22:56:20 +0000
Message-ID: <20130131225620.GQ1342@serenity.lan>
References: <7v1ud1gke7.fsf@alter.siamese.dyndns.org>
 <3f26b82599aa2a45897d345c851fab4751c55810.1359669205.git.john@keeping.me.uk>
 <7vy5f9dmrt.fsf@alter.siamese.dyndns.org>
 <20130131222817.GP1342@serenity.lan>
 <7vtxpxdldj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 23:56:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U133s-0003dV-Sc
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 23:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757234Ab3AaW4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 17:56:31 -0500
Received: from pichi.aluminati.org ([72.9.246.58]:47653 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757229Ab3AaW43 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 17:56:29 -0500
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 315FA161E410;
	Thu, 31 Jan 2013 22:56:29 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -9.225
X-Spam-Level: 
X-Spam-Status: No, score=-9.225 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLACK=1.775]
	autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rSf8Ctig-zag; Thu, 31 Jan 2013 22:56:28 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 2827C161E2F7;
	Thu, 31 Jan 2013 22:56:22 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vtxpxdldj.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215185>

On Thu, Jan 31, 2013 at 02:43:20PM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > Yes.  Should I change it to "git-remote-helpers.html.in" and then copy
> > it into place?  That seems like the simplest answer and means that
> > "*.html" will continue to refer only to generated files.
> 
> I'd like to see if we can have a way to keep its look as the default
> css gets updated without maintainance burden.
> 
> How about using AsciiDoc instead of "cp", perhaps like this on top
> of your patch?

I tried AsciiDoc first but didn't like the output.  I think putting "See
gitremote-helpers" in the synopsis is the magic I was missing.  This
looks good to me.


John
