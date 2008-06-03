From: David Brown <git@davidb.org>
Subject: Re: Maintaining two branches.
Date: Tue, 3 Jun 2008 11:13:24 -0700
Message-ID: <20080603181324.GA11735@old.davidb.org>
References: <20080603163431.GA1244@old.davidb.org> <20080603180213.GA5541@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Tue Jun 03 20:14:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3b1Y-0000y6-8r
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 20:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754397AbYFCSN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 14:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754226AbYFCSN1
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 14:13:27 -0400
Received: from mail.davidb.org ([66.93.32.219]:58239 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753789AbYFCSN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 14:13:26 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.69 #1 (Debian))
	id 1K3b0e-00036a-Pq; Tue, 03 Jun 2008 11:13:24 -0700
Mail-Followup-To: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20080603180213.GA5541@leksak.fem-net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83686>

On Tue, Jun 03, 2008 at 08:02:13PM +0200, Stephan Beyer wrote:
>Hi,
>
>> I've tried creating a 'next' branch where I merge each change from local
>> and/or external, and this seems to work, but the history gets very
>> cluttered with merge commits.
>
>You could cherry-pick commits from local and/or external instead of
>merging. See git-cherry-pick(1).

The problem is that this makes future merges more difficult, since there
isn't a history between the trees.  Our 'local' branch really is a merge of
the two.

Once I cherry pick anything, that branch has divergent history from the
other branches, and I have to cherry pick from then on (or merge from then
on).

David
