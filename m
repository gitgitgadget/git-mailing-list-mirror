From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Trying to get GIT running on SCO OpenServer
Date: Wed, 23 Jan 2008 16:17:16 -0800 (PST)
Message-ID: <m3bq7ckrh7.fsf@roke.D-201>
References: <20080123212613.GN2230@yugib.highrise.ca>
	<alpine.LSU.1.00.0801232346010.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aidan Van Dyk <aidan@highrise.ca>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 24 01:17:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHpn0-0002BF-Se
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 01:17:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754410AbYAXARV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 19:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754301AbYAXARU
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 19:17:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:14062 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753996AbYAXART (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 19:17:19 -0500
Received: by ug-out-1314.google.com with SMTP id z38so208969ugc.16
        for <git@vger.kernel.org>; Wed, 23 Jan 2008 16:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=MsuUVa/T7a5Hy0ca3UVE8L9wflyZGzwUjGTFmLsESxw=;
        b=G0YoW/XxZ6ByqtY97OgMFtkT83g2vzevaasGh8TBwa56X0PEjYnujg9lG6lc47J2tc8XzDJ2tdeY5NaUrBzZo4kIx+P6WE+PHAabnF81Gy5eL9APL79tlhNJ4Otw2U1Rn5OE3HrYoIIgr/H+FrPshPDUk+kGNEzg0droIsypn/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=a6W0AMkfwcoppTNsmmOmDWYo9XTU+hX7MMJbTxIwpm+ak/uywXWThcPFjM6jWJmUlBE5TdHX2nkO+WB1X0rktzaZp0+R0Ks5JUpqciduRAFjoGpfDYN3KdeFZw6foSzvAWWpRzxechcFJApVsYAIq6c4QIFqLD4mOahXCYXMrts=
Received: by 10.67.115.15 with SMTP id s15mr1550810ugm.63.1201133837481;
        Wed, 23 Jan 2008 16:17:17 -0800 (PST)
Received: from roke.D-201 ( [83.8.202.8])
        by mx.google.com with ESMTPS id b17sm74829fka.4.2008.01.23.16.17.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 Jan 2008 16:17:16 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id m0O0H4RJ013685;
	Thu, 24 Jan 2008 01:17:05 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m0O0Gbi1013677;
	Thu, 24 Jan 2008 01:16:37 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <alpine.LSU.1.00.0801232346010.5731@racer.site>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71578>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> That might give you an idea how to solve the issue.  Maybe you even make a 
> git patch out of it?  With a Makefile variable BROKEN_SNPRINTF=YesPlease, 
> maybe?

I think the "convention" is to use BROKEN_SNPRINTF=UnfortunatelyYes ;-)

-- 
Jakub Narebski
Poland
ShadeHawk on #git
