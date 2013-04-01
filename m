From: Paul Mackerras <paulus@samba.org>
Subject: Re: [Patch] gitk: added a file history browser
Date: Mon, 1 Apr 2013 18:24:08 +1100
Message-ID: <20130401072408.GB4427@iris.ozlabs.ibm.com>
References: <0063A4B3-8C79-4F2F-97C7-D14AEBB17DEC@freunde-aus-berlin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dirk <dirk@freunde-aus-berlin.net>
X-From: git-owner@vger.kernel.org Mon Apr 01 09:27:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMZ99-0000K2-Cy
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 09:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758164Ab3DAH0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 03:26:46 -0400
Received: from ozlabs.org ([203.10.76.45]:58924 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758130Ab3DAH0p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 03:26:45 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 9FD2C2C010C; Mon,  1 Apr 2013 18:26:44 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <0063A4B3-8C79-4F2F-97C7-D14AEBB17DEC@freunde-aus-berlin.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219677>

On Wed, Feb 20, 2013 at 12:14:20AM +0100, Dirk wrote:
> Hi,
> 
> I added a file history browser for a single file in the gitk. I use git log with the option --follow. This option is useful for the user switch from cvs to git. He misses a history from only one file and the function "Highlight this only" breaks by moved files. The new option do not break by the moved files. I use ideas from the tkcvs branch dialog.

How is this better than running "gitk --follow -- file"?

Also, it's rather a large patch with only a two-line patch description,
which is not really adequate.  And it's missing a Signed-off-by.

I think the right way to do this is to have the file menu option
create a new view specifying the file and the --follow option,
rather than creating a whole new window.

Paul.
