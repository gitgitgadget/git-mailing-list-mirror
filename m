From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: [PATCH 3/3] Return CURL error message when object transfer fails
Date: Mon, 26 Sep 2005 17:12:41 -0700
Message-ID: <20050927001241.GB15615@reactrix.com>
References: <20050926175211.GD9410@reactrix.com> <7v4q87ed73.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 02:12:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK35X-0003Wh-Cl
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 02:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbVI0AMs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 20:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbVI0AMs
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 20:12:48 -0400
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:16262 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1750816AbVI0AMs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 20:12:48 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j8R0CfRh017318;
	Mon, 26 Sep 2005 17:12:41 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j8R0Cf1r017316;
	Mon, 26 Sep 2005 17:12:41 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4q87ed73.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9356>

On Mon, Sep 26, 2005 at 02:22:56PM -0700, Junio C Hamano wrote:

> Sounds like a good idea.  Also if you happen to know if this
> option is not available in older versions of the library, it
> might not hurt to guard it with "#if LIBCURL_VERSION_NUM" like
> we do with other options.

I don't see any indication that CURLOPT_ERRORBUFFER is a new feature.
The curl_easy_strerror() function is new as of 7.12.0 which is why
I elected to use the CURLOPT_ERRORBUFFER option instead.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
