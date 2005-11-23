From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: Why not clone to a remote directory over SSH
Date: Wed, 23 Nov 2005 15:28:29 -0800
Message-ID: <20051123232829.GO3968@reactrix.com>
References: <20051123211601.GA2260@hpsvcnb.fc.hp.com> <20051123230838.GN3968@reactrix.com> <4384F7F6.10404@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 00:30:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ef42W-0005op-Ty
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 00:28:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbVKWX2e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 18:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbVKWX2e
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 18:28:34 -0500
Received: from 194.37.26.69.virtela.com ([69.26.37.194]:52142 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1751083AbVKWX2c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 18:28:32 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jANNSUBo010759;
	Wed, 23 Nov 2005 15:28:30 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jANNSTNv010757;
	Wed, 23 Nov 2005 15:28:29 -0800
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <4384F7F6.10404@op5.se>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12660>

On Thu, Nov 24, 2005 at 12:15:02AM +0100, Andreas Ericsson wrote:

> You'll still need to install at least git-init-db and git-receive-pack 
> (and git-merge, and...), even if they're run through commands from the 
> web. That's pretty special intelligence.

If the server is DAV-enabled, a local git-init-db could use HTTP to
create an empty remote repository, and git-http-push can already send
local changes including merges etc. to such a remote repository.

Want to host your project using GIT?  Just use your .Mac iDisk.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
