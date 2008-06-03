From: David Brown <git@davidb.org>
Subject: Re: Maintaining two branches.
Date: Tue, 3 Jun 2008 11:17:31 -0700
Message-ID: <20080603181731.GB11735@old.davidb.org>
References: <20080603163431.GA1244@old.davidb.org> <08056802-BBBC-4F1D-A1A6-2F8C381CDA2B@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Tue Jun 03 20:18:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3b5V-0002On-QH
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 20:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382AbYFCSRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 14:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752907AbYFCSRd
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 14:17:33 -0400
Received: from mail.davidb.org ([66.93.32.219]:40449 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752245AbYFCSRc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 14:17:32 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.69 #1 (Debian))
	id 1K3b4d-0003AT-Kq; Tue, 03 Jun 2008 11:17:31 -0700
Mail-Followup-To: Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <08056802-BBBC-4F1D-A1A6-2F8C381CDA2B@ai.rug.nl>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83687>

On Tue, Jun 03, 2008 at 08:08:09PM +0200, Pieter de Bie wrote:

> You might do the same workflow that Git has with stable / master / next
>
> If there is a new upstream release, merge it into external. If you have 
> patches you want to show to the outside, apply those patches to external. 
> Then you can merge external into local. The trick is to never merge local 
> into external.
>
> By going only one way (upstream --> external --> local), you'll never have 
> to worry about having to separate the different patches. Your history will 
> be displayed much nicer too.

I guess I didn't explain our dilema very well.  We _have_ to separate the
different patches, for legal reasons.  Perhaps 'external' isn't a good name
for the branch, maybe it should be 'other'.  Basically, the 'upstream'
branch is the real upstream tree.  The 'external' or 'other' branch
contains patches from outside our company.  We are forbidden from
redistributing these changes, and will be having our customers get them
from the same source that we do.  Then our 'local' branch is where we do
our development.

But, we can only build the system when the 'external/other' branch is
combined with 'local'.  It's just that the history has to be easily
separable so that we can generate the patches that are on the 'local'
branch along with the descriptions of the external branch so the customers
can get the same changes.

Thanks,
David
