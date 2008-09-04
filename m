From: Mike Hommey <mh@glandium.org>
Subject: Re: Medium term dreams
Date: Thu, 4 Sep 2008 07:33:09 +0200
Organization: glandium.org
Message-ID: <20080904053309.GA16412@glandium.org>
References: <7vsksjsbcc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 07:35:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb7UQ-0002Fi-PT
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 07:34:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756183AbYIDFdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 01:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756135AbYIDFdg
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 01:33:36 -0400
Received: from vuizook.err.no ([194.24.252.247]:45518 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755059AbYIDFdf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 01:33:35 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1Kb7T9-0004ml-Vf; Thu, 04 Sep 2008 07:33:30 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1Kb7Sv-0004Z7-LY; Thu, 04 Sep 2008 07:33:09 +0200
Content-Disposition: inline
In-Reply-To: <7vsksjsbcc.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94896>

On Mon, Sep 01, 2008 at 04:19:47PM -0700, Junio C Hamano wrote:
> Perhaps because it is also Linus's brainchild, git development has not
> generally advanced by intelligent design but by organic evolution.  We
> have worked without setting any grand, long term visions, but primarily
> by gathering the fruits of individual developers' work to scratch their
> own itches.  While I do not see that as a problem at all, it sometimes
> may help to write down some medium to long term wishes to review what we
> haven't done (and we should) in a perspective.
> 
> This is such a wishlist, not a grand intelligent design in any way.
> 
> 1. Pathspecs
> 2. Submodules

I'd add these two:

- Handle cvs/svn/whatever remotes as standard remotes.

I don't see why these remotes should have a different workflow, and why
there couldn't be hooks to do whatever is required to pull/push from
these remotes when git pull/push'ing. This might not be easy to implement,
but I think it is a worthwhile goal.

- Git-aware mergetool

There are various merge scenarios where using standard tools such as
those supported by current git-mergetool is not very helpful, and where
some basic git awareness might help the user resolve conflicts in more
natural ways.

Mike
