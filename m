From: Dave Kleikamp <shaggy@austin.ibm.com>
Subject: Re: How do I...
Date: Fri, 06 May 2005 09:37:01 -0500
Message-ID: <1115390221.10459.4.camel@localhost>
References: <427B3DB3.4000507@tuxrocks.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 06 16:31:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU3qi-0000G6-LC
	for gcvg-git@gmane.org; Fri, 06 May 2005 16:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVEFOhR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 10:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVEFOhR
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 10:37:17 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:60399 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261241AbVEFOhG
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 6 May 2005 10:37:06 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j46Eb4ua516204
	for <git@vger.kernel.org>; Fri, 6 May 2005 10:37:04 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j46Eb3Th124084
	for <git@vger.kernel.org>; Fri, 6 May 2005 08:37:03 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j46Eb3p7031615
	for <git@vger.kernel.org>; Fri, 6 May 2005 08:37:03 -0600
Received: from kleikamp.austin.ibm.com (dyn95390155.austin.ibm.com [9.53.90.155])
	by d03av01.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j46Eb2bx031598;
	Fri, 6 May 2005 08:37:02 -0600
To: Frank Sorenson <frank@tuxrocks.com>
In-Reply-To: <427B3DB3.4000507@tuxrocks.com>
X-Mailer: Evolution 2.0.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-05-06 at 03:49 -0600, Frank Sorenson wrote:

> After doing a cg-update, can I cg-log just the changes since the last
> update?  Alternatively, how can I tell cg-log I'm caught up, and don't
> need anything historical?

(Assuming pulling from "origin")
Instead of doing cg-update, do cg-pull.  Then "cg-log :origin" will give
you you the changesets you just pulled.  "cg-merge origin" will then
complete operation, thereby catching you up.

-- 
David Kleikamp
IBM Linux Technology Center

