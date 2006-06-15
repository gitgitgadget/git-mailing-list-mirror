From: Pavel Roskin <proski@gnu.org>
Subject: Re: Collecting cvsps patches
Date: Wed, 14 Jun 2006 23:08:32 -0400
Message-ID: <1150340912.24184.7.camel@dv>
References: <20060611122746.GB7766@nowhere.earth>
	 <46a038f90606111516v2c8c68e2v818a0a0f9dca2da6@mail.gmail.com>
	 <20060611224205.GF1297@nowhere.earth>
	 <200606150921.34690.lan@academsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Yann Dirson <ydirson@altern.org>, GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 15 05:08:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqiE2-0004wW-6O
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 05:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWFODIj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 23:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWFODIj
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 23:08:39 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:12690 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751308AbWFODIi
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jun 2006 23:08:38 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FqiDm-0002xg-0W
	for git@vger.kernel.org; Wed, 14 Jun 2006 23:08:38 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FqiDg-0006mh-FC; Wed, 14 Jun 2006 23:08:32 -0400
To: Alexander Litvinov <lan@academsoft.ru>
In-Reply-To: <200606150921.34690.lan@academsoft.ru>
X-Mailer: Evolution 2.7.2.1 (2.7.2.1-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21878>

On Thu, 2006-06-15 at 09:21 +0700, Alexander Litvinov wrote:
> Your master branch is not compilable. This is the fix for it.

Actually, revision 5ecebc5064df0fd578dbf4b5ba5255e9af8cda7a renamed
"tagnames" to "link" in cvsps_types.h, so I think the same should be
done in cache.c.

Also, you can check the definition of list_entry, you'll see that the
member (argument 3) is cast to the pointer to the requested type
(argument 2).  I don't think it's safe to cast name to a pointer to
TagName.

That said, having non-compilable repository defeats the purpose of
collecting the patches to cvsps.  Shouldn't only compilable patches be
allowed in the repository?

-- 
Regards,
Pavel Roskin
