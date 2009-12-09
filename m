From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 2/2] git-svn: Move setting of svn.authorsfile in clone
	to between init and fetch
Date: Tue, 8 Dec 2009 20:44:03 -0800
Message-ID: <20091209044403.GA22566@dcvr.yhbt.net>
References: <1260305651-11111-1-git-send-email-alex@chmrr.net> <1260305651-11111-2-git-send-email-alex@chmrr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Alex Vandiver <alex@chmrr.net>
X-From: git-owner@vger.kernel.org Wed Dec 09 05:44:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIEPL-0003dK-KE
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 05:44:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756871AbZLIEn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 23:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756824AbZLIEn6
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 23:43:58 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:40744 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756798AbZLIEn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 23:43:57 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F4621FA9D;
	Wed,  9 Dec 2009 04:44:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1260305651-11111-2-git-send-email-alex@chmrr.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134934>

Alex Vandiver <alex@chmrr.net> wrote:
> If a clone errors out because of a missing author, or user interrupt,
> this allows `git svn fetch` to resume seamlessly, rather than forcing
> the user to re-provide the path to the authors file.

Thanks Alex,

I shortened the subject on this one, acked the series and pushed to
git://git.bogomips.org/git-svn

Alex Vandiver (2):
      git-svn: Set svn.authorsfile to an absolute path when cloning
      git-svn: set svn.authorsfile earlier when cloning

-- 
Eric Wong
