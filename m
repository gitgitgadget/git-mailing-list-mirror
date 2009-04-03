From: Finn Arne Gangstad <finnag@pvv.org>
Subject: [PATCHv2 0/2] git remote update: New option --prune (-p)
Date: Fri, 3 Apr 2009 11:00:36 +0200
Message-ID: <20090403090036.GA23955@pvv.org>
References: <20090402123823.GA1756@pvv.org> <9b18b3110904020634i17633645ue4ba91701ea243a1@mail.gmail.com> <20090402134414.GB26699@coredump.intra.peff.net> <7vab6zexq7.fsf@gitster.siamese.dyndns.org> <20090402201803.GA5397@pvv.org> <7vljqieq1r.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, demerphq <demerphq@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 03 11:02:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpfI2-0002nm-Ng
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 11:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754289AbZDCJAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 05:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753441AbZDCJAo
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 05:00:44 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:52652 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357AbZDCJAo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 05:00:44 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1LpfGO-000182-MY; Fri, 03 Apr 2009 11:00:36 +0200
Content-Disposition: inline
In-Reply-To: <7vljqieq1r.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115520>

On Thu, Apr 02, 2009 at 01:52:48PM -0700, Junio C Hamano wrote:
> Finn Arne Gangstad <finnag@pvv.org> writes:
> 
> > On Thu, Apr 02, 2009 at 11:06:56AM -0700, Junio C Hamano wrote:
> >> [...]
> >> 
> >> I gave the patch an only cursory look, so I wouldn't comment on the
> >> implementation; two things I would look at in the code would be if it
> >> makes two connections to the remote to learn the same information (which
> >> would be bad)
> >
> > How bad?
> 
> I'd say only "could be improved later" bad.

Ok. I split the patch into two to make it easier to review.
1/2 just splits out prune_remote() as a separate function, and does not
change any behavior.
2/2 adds the new option to remote update.

Finn Arne Gangstad (2):
  builtin-remote.c: Split out prune_remote as a separate function.
  git remote update: New option --prune

 Documentation/git-remote.txt |    4 ++-
 builtin-remote.c             |   76 ++++++++++++++++++++++++++----------------
 2 files changed, 50 insertions(+), 30 deletions(-)

- Finn Arne
