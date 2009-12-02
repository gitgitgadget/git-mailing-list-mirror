From: David Soria Parra <sn_@gmx.net>
Subject: Re: [PATCH v2] Add --track option to git clone
Date: Wed, 2 Dec 2009 19:27:27 +0000 (UTC)
Message-ID: <slrnhhdfr1.d2h.sn_@experimentalworks.net>
References: <1259707865-6561-1-git-send-email-sn_@gmx.net>
 <20091202192028.6117@nanako3.lavabit.com>
 <20091202190807.GB30778@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 20:27:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFurl-0003DD-1N
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 20:27:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755393AbZLBT1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 14:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755367AbZLBT1q
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 14:27:46 -0500
Received: from lo.gmane.org ([80.91.229.12]:59975 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755232AbZLBT1p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 14:27:45 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NFure-0003At-4h
	for git@vger.kernel.org; Wed, 02 Dec 2009 20:27:50 +0100
Received: from 217.114.211.68 ([217.114.211.68])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Dec 2009 20:27:50 +0100
Received: from sn_ by 217.114.211.68 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Dec 2009 20:27:50 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 217.114.211.68
User-Agent: slrn/0.9.9p1 (SunOS)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134379>

On 2009-12-02, Jeff King <peff@peff.net> wrote:
>   1. Add "--track foo" as a convenience wrapper for "-f foo -b foo".
>
>   2. If no "-b" is given, the first "-f" is assumed as "-b". So "git
>      clone -f foo" becomes equivalent to David's --track.
>
> And of course the name "-f" (for --fetch, if you were wondering) is open
> to suggestion.
>
> What do you think?
>
This approach is much better than my initial proposal. Sadly I won't have time
to implement this, which is why I wrote the simplest working solution for me.
Fetch seems to reasonable. I can rewrite the patch to be able to use refspecs, but
it would require additional refactoring to be able to specify multiple --fetch parameters.

David
