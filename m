From: Joe Perches <joe@perches.com>
Subject: Re: git and linux kernel source
Date: Thu, 09 Aug 2007 18:59:47 -0700
Message-ID: <1186711187.3073.75.camel@localhost>
References: <1186701106.3073.71.camel@localhost>
	 <20070809231718.GH12875@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Fri Aug 10 04:00:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJJnF-0003Ub-Mv
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 04:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758410AbXHJB76 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 21:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758357AbXHJB76
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 21:59:58 -0400
Received: from DSL022.labridge.com ([206.117.136.22]:3349 "EHLO Perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758296AbXHJB74 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 21:59:56 -0400
Received: from [192.168.1.128] ([192.168.1.128])
	by Perches.com (8.9.3/8.9.3) with ESMTP id SAA27043;
	Thu, 9 Aug 2007 18:53:36 -0700
In-Reply-To: <20070809231718.GH12875@fieldses.org>
X-Mailer: Evolution 2.10.2-2.1mdv2007.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55499>

On Thu, 2007-08-09 at 19:17 -0400, J. Bruce Fields wrote:
> > Is there a way to separate the resultant single patch into multiple
> > patches by subdirectory?  Perhaps some git-rev-parse option?
> Something like
> 	for each sub/dir:
> 		git add sub/dir
> 		git commit -m "use bar not foo in sub/dir"
> should do it.  (Of course, in the particular case above the patches you
> ended up with probably wouldn't compile individually.)

Nor would it likely survive a git bisect, but it's a start.
My goal is to eventually commit by maintainer.

Thanks, Joe
