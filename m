From: Kevin Daudt <me@ikke.info>
Subject: Re: git-remote add: --no-tags/--tags which one is the default option
Date: Tue, 3 Mar 2015 23:09:18 +0100
Message-ID: <20150303220918.GB17528@vps892.directvps.nl>
References: <54F431E8.3050009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 23:09:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSv0K-0008VQ-0A
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 23:09:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932752AbbCCWJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 17:09:22 -0500
Received: from ikke.info ([178.21.113.177]:59841 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932747AbbCCWJU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 17:09:20 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1001)
	id 8C0561DCF6D; Tue,  3 Mar 2015 23:09:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <54F431E8.3050009@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264697>

On Mon, Mar 02, 2015 at 10:48:24AM +0100, Francis Moreau wrote:
> Hi,
> 
> git remote add has --no-tags/--tags option, but I can't find in the man
> page which one is the default.
> 
> Could anybody tell me the default option ?
> 


Neither is default. This option has three states, set, unset and
default:

- unset (--no-tags) doesn't fetch any tags at all
- default (no option passed) will fetch any tags that are reachable from the refs that are
  being fetch
- set (--tags) will fetch all tags, even if they aren't reachable.

These options can also be set with the remote.<name>.tagopt config
option, which takes values [--tags|--no-tags].

Kevin
