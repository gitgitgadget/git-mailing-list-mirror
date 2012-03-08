From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] post-receive-email: defend against non UTF-8
 i18n.logoutputencoding setting
Date: Thu, 8 Mar 2012 07:52:37 -0600
Message-ID: <20120308135237.GA14918@burratino>
References: <20120308115119.GA2604@burratino>
 <20120308115957.GB2750@burratino>
 <20120308135030.GB30602@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Gerrit Pape <pape@smarden.org>,
	Alexey Shumkin <zapped@mail.ru>, Johannes Sixt <j6t@kdbg.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jon Jensen <jon@endpoint.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 08 14:52:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5dlz-0007mf-1T
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 14:52:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753159Ab2CHNwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 08:52:47 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:61351 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752260Ab2CHNwq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 08:52:46 -0500
Received: by obbuo6 with SMTP id uo6so686436obb.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 05:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=K90UQl+7orrQTw7coAkhJlqM/cR1Ci10qlNCPzn4+EY=;
        b=M2omDypQPQpYjekuFRIchbyhhnvGoLhD47vZjCciTnlHIATAA7Y6C/0GSeQI6+bbxw
         kM+8bNPkVegNdlFKefHtAwzbmufSYy4lNy/KMuWil2EKgRcqjtjBGzLZv5iOXhLoM6uW
         G8SvjPkLVXGu5QARmNXwD+L2UVGnL6NTOL04O4JQHT1vGDVD8pkFMF8IyRYDaOS+HhRk
         VKG50aIH6v/BaHx9ZS1wjsnP0cmcnnzB/JFygOZR9VRITL3RLIeh3ijKd7Ejk3T3EIuP
         +dSNSxfp/68CpZpweow4S8WV2lO44hWW70efUAcnNgUApQt62J080+xR7N8xN795WHkr
         VnRg==
Received: by 10.60.21.134 with SMTP id v6mr2460659oee.52.1331214765844;
        Thu, 08 Mar 2012 05:52:45 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id g6sm958106oeb.10.2012.03.08.05.52.44
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 05:52:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120308135030.GB30602@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192602>

Jeff King wrote:

> If you are using "-s" to suppress diff output, why are you using
> diff-tree? Wouldn't "rev-list -1" (or "rev-list --no-walk") work equally
> well and be a little more obvious?

Just a habit --- some part of me is wired to think "diff-tree is the
command to show a commit".  Maybe rev-list didn't support --pretty in
olden days?
