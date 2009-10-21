From: Mike Hommey <mh@glandium.org>
Subject: Re: [RFC] pull/fetch rename
Date: Wed, 21 Oct 2009 09:06:22 +0200
Message-ID: <20091021070622.GA3737@glandium.org>
References: <200910201947.50423.trast@student.ethz.ch>
 <alpine.LNX.2.00.0910201912390.14365@iabervon.org>
 <20091021063008.GA3349@glandium.org>
 <7v3a5db6ij.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	=?iso-8859-15?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 09:06:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0VHX-0005mX-5o
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 09:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbZJUHFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 03:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbZJUHFo
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 03:05:44 -0400
Received: from vuizook.err.no ([85.19.221.46]:53837 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750884AbZJUHFo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 03:05:44 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1N0VGE-0008U9-V5; Wed, 21 Oct 2009 09:05:33 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1N0VH4-0000zK-Mg; Wed, 21 Oct 2009 09:06:22 +0200
Content-Disposition: inline
In-Reply-To: <7v3a5db6ij.fsf@alter.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130890>

On Tue, Oct 20, 2009 at 11:33:40PM -0700, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > BTW, shouldn't fetch be deprecated in favour of git remote update ?
> 
> Why?  People will then be confused because half of them would expect
> "remote update" to somehow affect their working tree, and some others
> would expect their working tree reset to one of the branches from the
> remote, and it won't solve anything.

I must be missing the obvious but which one of fetch and remote update
does the above ? I was under the impression that none of them would.

> Oh, and it will irritate people who
> are used to type "git fetch", too.

That's another problem, but my understanding is that git fetch and git
remote update are roughly doing the same thing. Having two commands for
the same thing is confusing. I kind of like the idea to have one
command, remote, to handle, err, remotes. Also note that I said
deprecated, not remove ; that could mean keeping fetch, but pushing the
use of remote update for new users.

Mike
