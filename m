From: Joerg Rosenkranz <Joerg.Rosenkranz@gmail.com>
Subject: Re: git commit -a reports untracked files after a clone
Date: Wed, 5 Oct 2011 14:26:30 +0000 (UTC)
Message-ID: <loom.20111005T161522-357@post.gmane.org>
References: <7B399C74-8048-42BA-8672-9D7964F24888@goli.at> <7v39kgr5ln.fsf@alter.siamese.dyndns.org> <4501A58F-46F8-410C-BCEF-DD2FC10BC3A5@goli.at> <20110516103829.GA23889@sigill.intra.peff.net> <7C2AE1EE-4CAE-4E86-A53C-C97BE1F2573B@goli.at> <20110516120825.GA24418@sigill.intra.peff.net> <1D7CF554-A4AC-49EF-A095-9B05167BC458@goli.at> <20110516145535.GA25930@sigill.intra.peff.net> <20110527180045.GA29119@sigill.intra.peff.net> <20110527181321.GB29119@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 05 16:30:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBSUF-0004N3-K4
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 16:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934608Ab1JEOaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 10:30:12 -0400
Received: from lo.gmane.org ([80.91.229.12]:53124 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934577Ab1JEOaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 10:30:09 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RBSU2-0004I8-DD
	for git@vger.kernel.org; Wed, 05 Oct 2011 16:30:06 +0200
Received: from port-92-198-60-67.static.qsc.de ([92.198.60.67])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 16:30:06 +0200
Received: from Joerg.Rosenkranz by port-92-198-60-67.static.qsc.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 16:30:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 92.198.60.67 (Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.835.186 Safari/535.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182850>

> On Fri, May 27, 2011 at 02:00:45PM -0400, Jeff King wrote:
>   1. We load the index, and for each entry, insert it into the index's
>      name_hash. In addition, if ignorecase is turned on, we make an
>      entry in the name_hash for the directory (e.g., "contrib/"), which
>      uses the following code from 5102c61's hash_index_entry_directories:

Sorry for reactivating this old thread.
We are running in this problem too. The behavior is the same in msysgit and on 
Linux. Your patch resolves that problem for us.

Is there any chance to drive this patch forward? 

Thanks,
Joerg
