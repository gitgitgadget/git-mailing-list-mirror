From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: fix the display of files when filtered by path
Date: Mon, 19 Mar 2012 10:11:43 +1100
Message-ID: <20120318231143.GD26977@bloggs.ozlabs.ibm.com>
References: <87hb14wg4l.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Mar 19 00:26:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9PUg-00087s-9l
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 00:26:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084Ab2CRX0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Mar 2012 19:26:22 -0400
Received: from ozlabs.org ([203.10.76.45]:54137 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754637Ab2CRX0L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 19:26:11 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id A5696B702D; Mon, 19 Mar 2012 10:26:09 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <87hb14wg4l.fsf@fox.patthoyts.tk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193399>

On Tue, Dec 13, 2011 at 04:50:50PM +0000, Pat Thoyts wrote:
> Launching 'gitk -- .' or 'gitk -- ..\t' restricts the display to files
> under the given directory but the file list is left empty. This is because
> the path_filter function fails to match the filenames which are relative
> to the working tree to the filter which is filessytem relative.
> This solves the problem by making both names fully qualified filesystem
> paths before performing the comparison.
> 
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>

Thanks, applied.

Paul.
