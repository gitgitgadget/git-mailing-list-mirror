From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-cvsimport-3 and incremental imports
Date: Sun, 20 Jan 2013 15:42:05 -0800
Message-ID: <20130120234205.GC3474@elie.Belkin>
References: <20130120200922.GC7498@serenity.lan>
 <20130120232008.GA25001@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 00:42:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx4X7-0000No-Ko
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 00:42:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621Ab3ATXmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 18:42:11 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:43001 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342Ab3ATXmK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 18:42:10 -0500
Received: by mail-pa0-f54.google.com with SMTP id bi5so3044713pad.27
        for <git@vger.kernel.org>; Sun, 20 Jan 2013 15:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=QpXiSX44t9XkqaZ8MpMMmITLYrLkuO64bvPnbiaKOls=;
        b=uYVc5j8figmO1agtz/2x5pYpesa8l7gERIE7USAVB/AWyHoQbpZA8na3Oj9Wg6nslA
         G7s3M7PYwnDymhurb+iXpsZEedLSYPDFmWjDQl1ktD7n5MwrMjC+QjKawu4qLJfSCQI4
         Gp6TI14PpsBb9AL0TzsMn3g21sf8SeGQ8WalaC2a/NYwuAdXmpp2MlpOeHc3y/dH56Qs
         dx9u1kpDVxnraj7+64EqGJBGEGr07ox9+BMNuDK4PMPVZZKLuQoksyVxJybmQc2jEXsF
         MhOUpWgVJdcHFxVRgMdaaWLFl+GGnjWFdEJm11n/bnLlFdXaB0sN11o8CylXxMJ6pYK5
         sqzw==
X-Received: by 10.68.216.201 with SMTP id os9mr24800493pbc.36.1358725329676;
        Sun, 20 Jan 2013 15:42:09 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id qb3sm7473858pbb.35.2013.01.20.15.42.07
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 20 Jan 2013 15:42:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130120232008.GA25001@thyrsus.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214059>

Eric S. Raymond wrote:

> You get to integrate this.  I think the transition strategy Junio
> has chosen is seriously mistaken, leading to unnecessary grief for users
> who will be fooled into thinking it's OK to still use cvsps-2.

Ah, I missed a detail on first reading.  I think there has been a
small misunderstanding.

Junio proposed a transition strategy, but I don't think it's fair to
say he has chosen it without discussion or is imposing it on you.  If
you or someone else comes up with a better transition strategy, you
are free to completely ignore Junio's proposal.  If the affected users
generally prefer your alternate proposal, in my experience that means
it will be integrated.

Hoping that clarifies a little,
Jonathan
