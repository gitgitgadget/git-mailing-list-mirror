From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 4/5] Full rework of quote_c_style and write_name_quoted.
Date: Wed, 19 Sep 2007 10:28:03 +0200
Message-ID: <86r6kv2h64.fsf@lola.quinscape.zz>
References: <20070918223947.GB4535@artemis.corp> <20070918224122.2B55D344AB3@madism.org> <46F0C3AB.8010801@op5.se> <20070919080030.GA28205@artemis.corp> <46F0D8E2.5090706@op5.se> <20070919082111.GB28205@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 19 10:28:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXuvJ-0002yU-OF
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 10:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754281AbXISI2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 04:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753704AbXISI2f
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 04:28:35 -0400
Received: from main.gmane.org ([80.91.229.2]:34503 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752426AbXISI2e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 04:28:34 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IXuuv-0004Ro-Bw
	for git@vger.kernel.org; Wed, 19 Sep 2007 10:28:17 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 19 Sep 2007 10:28:17 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 19 Sep 2007 10:28:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:D69VDuUMUqpaGVkP9gJSlFtBrps=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58695>

Pierre Habouzit <madcoder@debian.org> writes:

> On Wed, Sep 19, 2007 at 08:08:02AM +0000, Andreas Ericsson wrote:
>> Then perhaps a separate patch for this would have been prudent? I'm not
>> against the change per se and I understand the reasoning behind it, but
>> it seems to go against Documentation/SubmittingPatches (submit one change
>> at a time).
>
>   Yes, the thing is, I wrote it in one piece, and had a _very_ hard time
> splitting it. The aggregated patches had almost no chunks, and editing
> diffs by hand isn't what I like to do :)

Use Emacs for it.  After loading the patch in a file, type

Esc x diff-mode RET

If you now move to a place in the middle of a hunk and type C-c C-s,
the hunk is split at that point into two hunks.  C-c C-k kills the
current hunk.  C-x C-s saves the file, C-x C-c exits Emacs.

In that manner throwing selected material out of a patch is rather
straightforward, even when it is in the middle of a hunk.

-- 
David Kastrup
