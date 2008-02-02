From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Documentation/git-reset.txt: Use HEAD~N syntax
	everywhere (unify examples)
Date: Sat, 2 Feb 2008 09:44:06 +0100
Organization: glandium.org
Message-ID: <20080202084406.GA15305@glandium.org>
References: <3asc6spe.fsf@blue.sea.net> <7v7iho6p2m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 02 09:45:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLDzv-0000sq-1U
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 09:45:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757451AbYBBIon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 03:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757395AbYBBIon
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 03:44:43 -0500
Received: from vuizook.err.no ([85.19.215.103]:44828 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757280AbYBBIom (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 03:44:42 -0500
Received: from aputeaux-153-1-85-206.w86-205.abo.wanadoo.fr ([86.205.43.206] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JLDzx-0000Or-RC; Sat, 02 Feb 2008 09:45:24 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JLDyo-0004Jo-OX; Sat, 02 Feb 2008 09:44:06 +0100
Content-Disposition: inline
In-Reply-To: <7v7iho6p2m.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72232>

On Fri, Feb 01, 2008 at 06:59:29PM -0800, Junio C Hamano wrote:
> Jari Aalto <jari.aalto@cante.net> writes:
> 
> > The examples in the documentation refer to multiple ~N commits. To
> > Keep the exampels unified with the same syntax, use ~N in all examples.
> >
> > Signed-off-by: Jari Aalto <jari.aalto AT cante.net>
> 
> > -$ git reset --soft HEAD^      <1>
> > +$ git reset --soft HEAD~1     <1>
> > -<1> The last three commits (HEAD, HEAD^, and HEAD~2) were bad
> > +<1> The last three commits (HEAD, HEAD~1, and HEAD~2) were bad
> > -$ git reset --soft HEAD^ ;# go back to WIP state  <2>
> > +$ git reset --soft HEAD~1 ;# go back to WIP state <2>
> 
> I personally think this is a regression, not an improvement.
> 
> People need to refer to the HEAD^ (one commit ago) much more
> often than HEAD~N for larger values of N.  And we should give
> them exposure to HEAD^ and HEAD^^; both are faster and easier to
> type and read than HEAD~1 and HEAD~2.
> 
> Especially about HEAD~1, nobody sane would type that.  It is
> there only for consistency.
> 
> Otherwise, twisted people would complain "I can say HEAD~4
> instead of HEAD^^^^ and it helps brevity; but it is inconsistent
> that I cannot say HEAD~1 instead of HEAD^".

I wonder if it wouldn't make sense to have ^ described with ^1 ^2, and
add the possibility to also have ~, which would have the same meaning by
side effect, described with ~1 ~2, etc.

The problem with ^ being described with ~1 ~2 is that it makes things
harder to understand than they actually are. The real problem being that
^ sounds like having different meanings depending whether it's followed
by a number or not.

Mike
