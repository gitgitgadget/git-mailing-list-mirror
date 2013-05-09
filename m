From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: added an --include-path flag
Date: Thu, 9 May 2013 01:19:04 +0000
Message-ID: <20130509011904.GA24257@dcvr.yhbt.net>
References: <20130501204616.GA12203@dcvr.yhbt.net>
 <1367622618-28220-1-git-send-email-pjwhams@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Paul Walmsley <pjwhams@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 09 03:19:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaFVr-0001Sn-9n
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 03:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754030Ab3EIBTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 21:19:06 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:50221 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752490Ab3EIBTF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 21:19:05 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFE441F6BF;
	Thu,  9 May 2013 01:19:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1367622618-28220-1-git-send-email-pjwhams@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223699>

Paul Walmsley <pjwhams@gmail.com> wrote:
> The SVN::Fetcher module is now able to filter for inclusion as well
> as exclusion (as used by --ignore-path). Also added tests, documentation
> changes and git completion script.
> 
> If you have an SVN repository with many top level directories and you
> only want a git-svn clone of some of them then using --ignore-path is
> difficult as it requires a very long regexp. In this case it's much
> easier to filter for inclusion.
> 
> Signed-off-by: Paul Walmsley <pjwhams@gmail.com>

Thanks, signed-off and applied, will push.
