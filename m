From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-add--interactive: manual hunk editing mode
Date: Fri, 30 May 2008 03:46:26 -0700 (PDT)
Message-ID: <m3prr4135z.fsf@localhost.localdomain>
References: <200805232221.45406.trast@student.ethz.ch>
	<200805291737.53291.trast@student.ethz.ch>
	<20080529185808.GA2140@sigill.intra.peff.net>
	<alpine.DEB.1.00.0805301049000.13507@racer.site.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 30 12:47:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K228p-0006v1-0r
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 12:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355AbYE3Kqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 06:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753271AbYE3Kqa
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 06:46:30 -0400
Received: from ik-out-1112.google.com ([66.249.90.180]:6169 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753156AbYE3Kqa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 06:46:30 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1896284ika.5
        for <git@vger.kernel.org>; Fri, 30 May 2008 03:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=IoN9gHdG+iL4GS3dEwAGZ+5wa3ye4zTWzGhQ2+EIrds=;
        b=FHkjJWZgqC+4+00yS0uciHZF9nzE/joVf8U6TtL+Iduv4xcrbPO8vOqKC8TZv7vJflcPrJVr7XEyM9aZQQO5qMjARZu3H8nPg7sMhobRrbYlZz3R32GZbblSa9BXWIBeNR+5RtJJ2M0t2p5L7PkEcyc+O09kFGs8P8BWexvPClQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=V13Erbgg3pGEaY5d9cI+sEMe52Ksl8GHpjIcFY2f3T6o3XLIWCMtbWhX4zDFxue5N+6vog4OZmODEXMFeZs+VYEDs+N3ErNu+upaCCv11WN4+e2qpdUzh1/uq2/xyKViB/OXuZ3hSJ9o0QK74QEDrs15QqIt5v770hKojB5Nb/Y=
Received: by 10.78.154.14 with SMTP id b14mr118209hue.104.1212144387234;
        Fri, 30 May 2008 03:46:27 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.197.146])
        by mx.google.com with ESMTPS id 33sm287181hue.28.2008.05.30.03.46.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 May 2008 03:46:26 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m4UAjd1r023141;
	Fri, 30 May 2008 12:45:50 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m4UAjCTD023133;
	Fri, 30 May 2008 12:45:12 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.DEB.1.00.0805301049000.13507@racer.site.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83288>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> -- snipsnap --
> [PATCH] WIP: allow git-apply to fix up the line counts
> 
> Sometimes, the easiest way to fix up a patch is to edit it directly, even
> adding or deleting lines.  Now, many people are not as divine as certain
> benevolent dictators as to update the hunk headers correctly at the first
> try.

Or do not use editor with diff editing mode, such as unidiff mode for
GNU Emacs (and derivatives)... :-)
-- 
Jakub Narebski
Poland
ShadeHawk on #git
