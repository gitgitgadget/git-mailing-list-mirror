From: David Brown <git@davidb.org>
Subject: Re: [PATCH] [git-p4] Detect exec bit in more cases.
Date: Wed, 19 Sep 2007 14:03:18 -0700
Message-ID: <20070919210318.GA32131@old.davidb.org>
References: <119022570352-git-send-email-git@davidb.org> <1190232768445-git-send-email-git@davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 19 23:03:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IY6hf-0004UC-Sg
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 23:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbXISVDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 17:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbXISVDT
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 17:03:19 -0400
Received: from mail.davidb.org ([66.93.32.219]:56336 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751205AbXISVDS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 17:03:18 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.67 #1 (Debian))
	id 1IY6ha-0008OL-A6
	for <git@vger.kernel.org>; Wed, 19 Sep 2007 14:03:18 -0700
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1190232768445-git-send-email-git@davidb.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58736>

On Wed, Sep 19, 2007 at 01:12:48PM -0700, David Brown wrote:
>git-p4 was missing the execute bit setting if the file had other attribute
>bits set.
>---
> contrib/fast-import/git-p4 |   10 +++++++++-
> 1 files changed, 9 insertions(+), 1 deletions(-)

I've tested this patch on our fairly large P4 repo, and at least the tip
exactly matches the files that P4 finds.  So, it at least should be better.
git-p4 still has some problems with case-insensitive servers.

Dave
