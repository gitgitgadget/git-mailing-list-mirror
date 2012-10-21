From: Paul Mackerras <paulus@samba.org>
Subject: Re: [BUG] gitk: clicking on a connecting line produces can't read
 "cflist_top"
Date: Mon, 22 Oct 2012 09:25:45 +1100
Message-ID: <20121021222545.GC7407@bloggs.ozlabs.ibm.com>
References: <506956E1.1080303@viscovery.net>
 <1349383817-14457-1-git-send-email-stefan@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Stefan Haller <stefan@haller-berlin.de>
X-From: git-owner@vger.kernel.org Mon Oct 22 00:25:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ3y0-0005xR-TZ
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 00:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932661Ab2JUWZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 18:25:44 -0400
Received: from ozlabs.org ([203.10.76.45]:51650 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932225Ab2JUWZo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 18:25:44 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 3CF172C00F4; Mon, 22 Oct 2012 09:25:43 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <1349383817-14457-1-git-send-email-stefan@haller-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208162>

On Thu, Oct 04, 2012 at 10:50:15PM +0200, Stefan Haller wrote:
> Sorry, I didn't realize that there is a display mode where the
> list of files is empty, not even showing a "Comments" entry.
> 
> Here's a patch that fixes it, plus another patch that is only related
> in so far as the bug that it fixes was introduced by the same commit.
> 
> [PATCH 1/2] gitk: Fix error message when clicking on a connecting line
> [PATCH 2/2] gitk: When searching, only highlight files when in Patch mode

Thanks, applied both.

Paul.
