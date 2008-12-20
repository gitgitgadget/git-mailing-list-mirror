From: Mike Hommey <mh@glandium.org>
Subject: Re: rsync deprecated?
Date: Sat, 20 Dec 2008 09:15:11 +0100
Organization: glandium.org
Message-ID: <20081220081511.GA28212@glandium.org>
References: <200812180041.10312.markus.heidelberg@web.de> <7vljuei2xw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 20 09:13:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDwy4-0000vH-MB
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 09:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895AbYLTILy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 03:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753984AbYLTILy
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 03:11:54 -0500
Received: from vuizook.err.no ([194.24.252.247]:41595 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752869AbYLTILx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 03:11:53 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LDww4-0004mN-UM; Sat, 20 Dec 2008 09:11:47 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LDwzP-0007OA-42; Sat, 20 Dec 2008 09:15:11 +0100
Content-Disposition: inline
In-Reply-To: <7vljuei2xw.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103631>

On Wed, Dec 17, 2008 at 07:20:59PM -0800, Junio C Hamano wrote:
> Markus Heidelberg <markus.heidelberg@web.de> writes:
> 
> > in the "Merging external work" section of the gitcore-tutorial it is
> > stated that the rsync transport is deprecated. The description was added
> > in commit 914328a (Update tutorial., 2005-08-30) together with the
> > "deprecated" note. Having never heard/read this before and since this
> > commit is quite old, I wonder if it is still the case or there was a
> > solution for this problem.
> 
> Sorry, I do not quite understand what you perceive as "this problem".
> 
> It has been deprecated for too long a time.  Maybe it is time to remove
> the support, instead of carrying the deprecated command forever?  Is that
> the problem you are talking about?
> 
> I tend to agree that rsync transport way outlived its usefulness, and not
> maintained at all.  There may be unnoticed and undiagnosed bugs lurking,
> but nobody knows about it because nobody uses it.

Something that could well make this transport be maintained would be to
make it share code/internal API with the "local file transport".
Ideally, http, rsync and file could all share the same basis, and
ensuring the file transport to be functional would pretty much guarantee
all work.

Anyways, I'm not the right person to say that, as I've been failing to
deliver a beginning of such code for a year, now (damn, time goes too
fast).

Maybe libgit2 could be a good occasion to start some API like this,
though.

Mike
