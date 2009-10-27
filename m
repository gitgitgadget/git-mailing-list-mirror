From: Joe Perches <joe@perches.com>
Subject: Re: git vs hg commit counts?
Date: Mon, 26 Oct 2009 21:14:29 -0700
Message-ID: <1256616869.29938.30.camel@Joe-Laptop.home>
References: <1256602127.29938.8.camel@Joe-Laptop.home>
	 <7v8wexd6zq.fsf@alter.siamese.dyndns.org>
	 <54b33ccd0910261816x3c49d4ccr60a80a88dd4cfac9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	LKML <linux-kernel@vger.kernel.org>, git <git@vger.kernel.org>,
	mercurial@selenic.com
To: Marti Raudsepp <marti@juffo.org>
X-From: git-owner@vger.kernel.org Tue Oct 27 05:14:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2dSK-0006sn-Bv
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 05:14:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbZJ0EO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 00:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbZJ0EO0
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 00:14:26 -0400
Received: from mail.perches.com ([173.55.12.10]:1091 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750816AbZJ0EOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 00:14:25 -0400
Received: from [192.168.1.151] (Joe-Laptop.home [192.168.1.151])
	by mail.perches.com (Postfix) with ESMTP id 2272624368;
	Mon, 26 Oct 2009 20:14:22 -0800 (PST)
In-Reply-To: <54b33ccd0910261816x3c49d4ccr60a80a88dd4cfac9@mail.gmail.com>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131309>

On Tue, 2009-10-27 at 03:16 +0200, Marti Raudsepp wrote:
> On Tue, Oct 27, 2009 at 2:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > We simplify a merge history by discarding one branch when the merge result
> > matches one of the parents.  Does "hg" know how to do that as well?
> 
> 57 of the differing changesets are normal merges (probably what Junio explained)
> 3 are duplicate changesets in hg, probably also related to that
> 27 changesets are octopus merge fixups
> 
> wrt octopus merges: in git, one merge commit can have an arbitrary
> number of parents, but in hg a merge changeset always has 2 parents --
> so a octopus merge is represented as multiple distinct changesets.

Thanks.

For hg support in get_maintainers, it's probably
simplest to ignore the delta in number of commits
as "close enough".
