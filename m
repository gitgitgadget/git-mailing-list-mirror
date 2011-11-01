From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] svn: Quote repository root in regex match
Date: Tue, 1 Nov 2011 20:13:11 +0000
Message-ID: <20111101201310.GA29769@dcvr.yhbt.net>
References: <1320100632-10058-1-git-send-email-ted.percival@quest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ted Percival <ted.percival@quest.com>
X-From: git-owner@vger.kernel.org Tue Nov 01 21:13:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLKhw-0000Ta-UH
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 21:13:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754914Ab1KAUNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Nov 2011 16:13:12 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47384 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750829Ab1KAUNL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2011 16:13:11 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4536D2EE3A1;
	Tue,  1 Nov 2011 20:13:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1320100632-10058-1-git-send-email-ted.percival@quest.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184583>

Ted Percival <ted.percival@quest.com> wrote:
> Fixes a problem matching repository URLs, especially those with a '+' in
> the URL, such as svn+ssh:// URLs. Parts of the URL were interpreted as
> special characters by the regex matching.
> 
> Signed-off-by: Ted Percival <ted.percival@quest.com>

Looks obviously correct to me, thanks

Acked-by: Eric Wong <normalperson@yhbt.net>

And pushed to master of git://bogomips.org/git-svn.git
(commit 0e7e30f5606b48a4c6d34bc99c6d680bb76d3fbc)
