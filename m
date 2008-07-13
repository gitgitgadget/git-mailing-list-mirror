From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Q: How to tag individual files
Date: Sun, 13 Jul 2008 05:35:37 +0000
Message-ID: <20080713053537.GA32746@spearce.org>
References: <g5bvte$52j$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Poojan Wagh <poojanwagh@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 07:36:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHuGE-0007mU-M7
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 07:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbYGMFfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 01:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbYGMFfi
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 01:35:38 -0400
Received: from george.spearce.org ([209.20.77.23]:50951 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbYGMFfh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 01:35:37 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4CF1B382A6; Sun, 13 Jul 2008 05:35:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <g5bvte$52j$1@ger.gmane.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88286>

Poojan Wagh <poojanwagh@gmail.com> wrote:
> The crash course at: http://git.or.cz/course/svn.html says:
>
>> You usually tag commits but if you want, you can tag files (or trees, 
>> but that's a bit low-level) as well. 
>
> I've done a bit of searching, and I can't for the life of me figure out  
> how to tag an individual file. Help from the group would be much  
> appreciated. Thanks.

You don't tag individual files.  Git is snapshot based.  You tag
the entire project at once.

The comment you quoted was talking about tagging a single listing of
blobs (a tree) or a single blob (stream of bytes).  This can be handy
in rare cases.  In the linux kernel for example the prior history
was stored by tagging the tree of that prior history, as there was
no git based history preceeding that snapshot, so there were no
commits to tag.  In git.git Junio publishes his GnuPG public key
as a tagged blob, making it available to validate signed tag objects.

So you can't tag individual files.  The comment is a bit misleading
and gets far too low-level for an otherwise high-level conversion
guide.

-- 
Shawn.
