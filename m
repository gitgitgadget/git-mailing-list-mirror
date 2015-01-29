From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn import failure : write .git/Git_svn_hash_BmjclS: Bad
 file descriptor
Date: Thu, 29 Jan 2015 23:34:30 +0000
Message-ID: <20150129233429.GA7162@dcvr.yhbt.net>
References: <CABNxngNDwf_Cy77OzvMg__kCNoTz5y1a2KKG1vobYjE_m_aLkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Valery Yundin <yuvalery@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 00:34:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGybb-0004Gi-6x
	for gcvg-git-2@plane.gmane.org; Fri, 30 Jan 2015 00:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbbA2Xeb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2015 18:34:31 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:42679 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767AbbA2Xea (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2015 18:34:30 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A512633801;
	Thu, 29 Jan 2015 23:34:30 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CABNxngNDwf_Cy77OzvMg__kCNoTz5y1a2KKG1vobYjE_m_aLkQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263165>

Valery Yundin <yuvalery@gmail.com> wrote:
> Tested on:
> git-svn version 2.3.0.rc2 (svn 1.8.11) - FAIL
> git-svn version 2.2.2 (svn 1.8.10) - FAIL
> git-svn version 1.8.4.5 (svn 1.8.11) - WORKS

Thank you for that info.  Do you think you can bisect which
versions/revisions of git-svn introduced that failure for us?  I don't
have much time this part of the year for git-svn, but maybe it's related
to the performance work we did around fall 2014.

Thanks again.
