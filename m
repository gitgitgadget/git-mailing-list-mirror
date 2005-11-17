From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: recent patch breaks the build ?
Date: Wed, 16 Nov 2005 16:46:21 -0800
Message-ID: <20051117004621.GB3968@reactrix.com>
References: <437B6997.8010903@mc.com> <7v64qs8kuo.fsf@assigned-by-dhcp.cox.net> <437B8CEC.8040002@mc.com> <20051116203334.GA3968@reactrix.com> <Pine.LNX.4.63.0511170023040.9284@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Wozniak <awozniak@mc.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 01:47:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcXvF-00038S-IE
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 01:46:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161055AbVKQAqi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 19:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161056AbVKQAqi
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 19:46:38 -0500
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:47190 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1161055AbVKQAqi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 19:46:38 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jAH0kMLf027605;
	Wed, 16 Nov 2005 16:46:22 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jAH0kLZ9027603;
	Wed, 16 Nov 2005 16:46:21 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511170023040.9284@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12078>

On Thu, Nov 17, 2005 at 12:25:06AM +0100, Johannes Schindelin wrote:

> It was 7.8.1. I checked. You might want to add this somewhere:
> 
> #if LIBCURL_VERSION_NUM < 0x070801
> #error http-push needs curl >= 7.8.1 (because of CURLOPT_HTTPGET)
> #endif

Is it worth trying to figure this out in the Makefile instead, using eg.
curl-config --vernum?

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
