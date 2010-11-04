From: Maaartin <grajcar1@seznam.cz>
Subject: Re: Problems switching branches
Date: Thu, 4 Nov 2010 00:23:03 +0000 (UTC)
Message-ID: <loom.20101104T012032-963@post.gmane.org>
References: <loom.20101103T032930-451@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 01:23:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDnc0-0000qS-1O
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 01:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186Ab0KDAXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 20:23:23 -0400
Received: from lo.gmane.org ([80.91.229.12]:59012 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751627Ab0KDAXW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 20:23:22 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PDnbs-0000kW-L8
	for git@vger.kernel.org; Thu, 04 Nov 2010 01:23:20 +0100
Received: from 188-120-198-113.luckynet.cz ([188-120-198-113.luckynet.cz])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 01:23:20 +0100
Received: from grajcar1 by 188-120-198-113.luckynet.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 01:23:20 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.120.198.113 (Opera/9.80 (Windows NT 5.2; U; en) Presto/2.6.30 Version/10.63)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160650>

Maaartin <grajcar1 <at> seznam.cz> writes:

> 
> I sometimes run in a problem similar to
> http://kerneltrap.org/mailarchive/git/2008/10/15/3667644/thread
> There are some ignored files which I want neither track nor throw away; I'm 
just 
> happy to have them and keep them out of version control.
> 
> Unfortunately, there weren't ignored in the old branch. I'd be quite happy 
with 
> non-destructive switching like "checkout everything what doesn't overwrite an 
> untracked file", so I would end in the old branch with a dirty working tree. 
Is 
> it possible?

No answer? In the meantime I've found a simple workaround: Checkout the old 
branch in another directory, modify .gitignore, commit and retry. But this is 
far from cool. Am I doing something stupid and nobody else ran into this?
