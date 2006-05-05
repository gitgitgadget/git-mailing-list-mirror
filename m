From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [ANNOUNCE] Git wiki
Date: Fri, 5 May 2006 08:22:36 +0200
Message-ID: <20060505062236.GA4544@c165.ib.student.liu.se>
References: <20060505005659.9092.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 05 08:22:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbtiI-0007p3-DC
	for gcvg-git@gmane.org; Fri, 05 May 2006 08:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbWEEGWj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 02:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWEEGWj
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 02:22:39 -0400
Received: from 85.8.31.11.se.wasadata.net ([85.8.31.11]:41344 "EHLO
	mail6.wasadata.com") by vger.kernel.org with ESMTP id S1750750AbWEEGWi
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 5 May 2006 02:22:38 -0400
Received: from c165 (85.8.2.189.se.wasadata.net [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 6368A40FF; Fri,  5 May 2006 08:41:32 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1Fbti0-0001FX-00; Fri, 05 May 2006 08:22:36 +0200
To: linux@horizon.com
Content-Disposition: inline
In-Reply-To: <20060505005659.9092.qmail@science.horizon.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19600>

On Thu, May 04, 2006 at 08:56:59PM -0400, linux@horizon.com wrote:
> What people who are asking for explicit rename tracking actually want
> is automatic rename merging.  If branch A renames a file, and branch B
> corrects a typo on a comment somewhere, they'd like the merge to
> both patch and rename the file.  If you can do that, you have met the
> need, even if your solution isn't the one the feature requester
> imagined.

I don't know if you already know this, if you do it might be valuable
for other readers.

If the rename is detected by the current rename detection code
(git-diff-tree -M) then the merge case described above is handled
perfectly fine by the current git. That is, the rename is followed and
the patch fixing the typo is applied to the renamed file. This assumes
that the default merge strategy (recursive) is used.


- Fredrik
