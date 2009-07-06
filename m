From: Eric Wong <normalperson@yhbt.net>
Subject: Re: "git svn reset" only resets current branch ?
Date: Mon, 6 Jul 2009 14:29:28 -0700
Message-ID: <20090706212928.GA11043@dcvr.yhbt.net>
References: <43948.10.0.0.1.1246874857.squirrel@intranet.linagora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ben Jackson <ben@ben.com>
To: Yann Dirson <ydirson@linagora.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 23:29:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNvkl-0000AC-KU
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 23:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592AbZGFV30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 17:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753545AbZGFV3Z
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 17:29:25 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:46879 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753543AbZGFV3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2009 17:29:25 -0400
Received: from localhost (unknown [12.186.229.34])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 03E881F44D;
	Mon,  6 Jul 2009 21:29:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <43948.10.0.0.1.1246874857.squirrel@intranet.linagora.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122796>

Yann Dirson <ydirson@linagora.com> wrote:
> I just tried the new "git svn reset" from master, and got puzzled that
> only the svn branch which is an ancestor of current git HEAD got rolled
> back.  Is that the expected behaviour ?  It would not make it very easy to
> fixup imports from svn trees with lots of branches/tags.

Ben was the original implementer of this idea, so I'm not sure of his
reasoning behind it.  For one, it's easier to only roll back one svn
branch.  Perhaps adding an --all flag to this command would be the best
way to go?

-- 
Eric Wong
