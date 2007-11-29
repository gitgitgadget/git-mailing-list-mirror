From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn now reads settings even if called in subdirectory
Date: Wed, 28 Nov 2007 23:41:32 -0800
Message-ID: <20071129074132.GA32277@soma>
References: <1195912076-3903-1-git-send-email-hendeby@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Thu Nov 29 08:42:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixe2Z-0000de-0G
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 08:42:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755601AbXK2Hlf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 02:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754984AbXK2Hlf
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 02:41:35 -0500
Received: from hand.yhbt.net ([66.150.188.102]:42600 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755540AbXK2Hle (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 02:41:34 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 289067DC0FE;
	Wed, 28 Nov 2007 23:41:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1195912076-3903-1-git-send-email-hendeby@isy.liu.se>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66511>

Gustaf Hendeby <hendeby@isy.liu.se> wrote:
> Previously, git-svn first read the .git/config file for settings as if
> current working directory was the repository top-directory, and after
> that made sure to cd into top-directory.  The result was a silent
> failur to read configuration settings.  This patch changes the order
> these two things are done.
> 
> Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>
> 
> ---
> 
> This fix seems a bit too obvious, which makes me think I missed
> something conceptual here.  However, the patch passes "make test" and
> "make full-svn-test", and the problems I had with the svn.authorsfile
> setting not being honored while fetching from a subdirectory are gone.

Thanks Gustaf,

Seems right to me (note: I never use the authors file feature myself).

Acked-by: Eric Wong <normalperson@yhbt.net>

-- 
Eric Wong
