From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2] git-svn: New flag to emulate empty directories
Date: Tue, 28 Jun 2011 04:23:24 +0000
Message-ID: <20110628042324.GA29123@dcvr.yhbt.net>
References: <1306391903-22092-1-git-send-email-rchen@cs.umd.edu>
 <loom.20110601T231627-922@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ray Chen <rchen@cs.umd.edu>
X-From: git-owner@vger.kernel.org Tue Jun 28 06:26:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbPsn-0006HW-1A
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 06:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756396Ab1F1EZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 00:25:27 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:54916 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755959Ab1F1EXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 00:23:25 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ABAD1F897;
	Tue, 28 Jun 2011 04:23:24 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <loom.20110601T231627-922@post.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176381>

Sorry, I got tied up with other things for a while.  Feel free to
remind me after a week or so if I don't respond, too.

Ray Chen <rchen@cs.umd.edu> wrote:
> Is there anything I can do to make this patch more palatable for inclusion?

I would like the config option to be "sticky" like the "--ignore-paths"
option when used with clone and saved to the config file.  This can be
done inside do_git_init_db().

In shell scripts, use $(command) instead of `command` in shell scripts
as suggested in Documentation/CodingStyle.

Otherwise, things look mostly alright and I'm inclined to accept your
patch.  An extra reviewer would also be helpful since I very rarely use
git-svn nowadays.

-- 
Eric Wong
