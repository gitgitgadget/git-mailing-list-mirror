From: Kevin D <me@ikke.info>
Subject: Re: [PATCH] clone: Warn if clone lacks LICENSE or COPYING file
Date: Thu, 26 Mar 2015 17:56:35 +0100
Message-ID: <20150326165635.GA14879@vps892.directvps.nl>
References: <E1YZNn7-0002Lc-7O@rmm6prod02.runbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 17:56:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbB5F-0006if-CE
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 17:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171AbbCZQ4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 12:56:37 -0400
Received: from ikke.info ([178.21.113.177]:58677 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752086AbbCZQ4g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 12:56:36 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1001)
	id 1EC891DCF6D; Thu, 26 Mar 2015 17:56:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <E1YZNn7-0002Lc-7O@rmm6prod02.runbox.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266337>

On Sat, Mar 21, 2015 at 02:06:33PM -0400, David A. Wheeler wrote:
> Warn cloners if there is no LICENSE* or COPYING* file that makes
> the license clear.  This is a useful warning, because if there is
> no license somewhere, then local copyright laws (which forbid many uses)
> and terms of service apply - and the cloner may not be expecting that.
> Many projects accidentally omit a license, so this is common enough to note.
> For more info on the issue, feel free to see:
> http://choosealicense.com/no-license/
> http://www.wired.com/2013/07/github-licenses/
> https://twitter.com/stephenrwalli/status/247597785069789184
> 

LWN article that lead to this patch: https://lwn.net/Articles/636261/
