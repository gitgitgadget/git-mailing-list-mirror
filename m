From: Mike Hommey <mh@glandium.org>
Subject: Re: [BUG REPORT] "git ls-remote http://git.domain.com/repo.git
	HEAD" doesn't work
Date: Sat, 14 Jun 2008 11:02:44 +0200
Organization: glandium.org
Message-ID: <20080614090244.GA1262@glandium.org>
References: <loom.20080614T065448-251@post.gmane.org> <20080614071011.GA29699@glandium.org> <7vprqkh423.fsf@gitster.siamese.dyndns.org> <loom.20080614T074854-525@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sven <svoop@delirium.ch>
X-From: git-owner@vger.kernel.org Sat Jun 14 11:04:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7Rgf-0002tb-O5
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 11:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754283AbYFNJDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 05:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754240AbYFNJDr
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 05:03:47 -0400
Received: from vuizook.err.no ([194.24.252.247]:33314 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754224AbYFNJDq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 05:03:46 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1K7Rfe-0000kO-8F; Sat, 14 Jun 2008 11:03:44 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1K7Rem-0000MS-3m; Sat, 14 Jun 2008 11:02:44 +0200
Content-Disposition: inline
In-Reply-To: <loom.20080614T074854-525@post.gmane.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84992>

On Sat, Jun 14, 2008 at 07:49:06AM +0000, Sven wrote:
> Junio C Hamano <gitster <at> pobox.com> writes:
> > Traditionally it _never_ talked about HEAD as it technically is not a ref.
> 
> How likely is it that ls-remote HEAD is added for HTTP as well rather than
> stripped for all protocols?

When someone sends a patch ;)

FWIW, quickly looking at the code, it seems the rsync backend may have
the same problem. Now, I wonder if other protocols allow to use other
refs such as FETCH_HEAD, or if they special case HEAD. I don't have
enough time to look this up.

Mike
