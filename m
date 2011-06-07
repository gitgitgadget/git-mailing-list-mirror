From: Alex Neronskiy <zakmagnus@google.com>
Subject: Re: [PATCH v2] Document the underlying protocol used by shallow repositories and --depth commands.
Date: Tue, 7 Jun 2011 20:41:03 +0000 (UTC)
Message-ID: <loom.20110607T223406-961@post.gmane.org>
References: <loom.20110607T212226-56@post.gmane.org> <7vzklt4c92.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 22:41:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU35W-0008NM-A9
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 22:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756681Ab1FGUlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 16:41:17 -0400
Received: from lo.gmane.org ([80.91.229.12]:53221 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756676Ab1FGUlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 16:41:16 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QU35P-0008LY-0p
	for git@vger.kernel.org; Tue, 07 Jun 2011 22:41:15 +0200
Received: from 216-239-45-4.google.com ([216.239.45.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 22:41:15 +0200
Received: from zakmagnus by 216-239-45-4.google.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 22:41:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 216.239.45.4 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110422 Ubuntu/10.04 (lucid) Firefox/3.6.17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175266>

Junio C Hamano <gitster <at> pobox.com> writes:
> It seems like you posted from the news interface at gmane, and the
> annoying &nbsp; are gone now.  The patch is still linewrapped (see the
> hunk header starting with "@@ -187,26"), but this one I can fix up and
> actually take a look .
So is the one starting with "@@ -215,21 +217,65". Sorry, I failed once again.
It's not cc'ed, either. I'm thinking maybe Scott Chacon also has comments, since
he seems to have written the file I'm modifying?

> As it is documented for the first time, we didn't have a formal
> terminology for calling these commits and it is this document's
> responsibility to come up with a good one. We have used "shallow clone"
> and "shallow history", and I agree with the use of adjective in these
> contexts, but I am not sure if it is a good idea to call the commits at
> the boundary of a shallow history "shallow"---the following sentences do
> not parse well at least for me:
> 
>     "This commit is shallow."
>     "This commit is not shallow, and it is a direct child of that commit,
>     which is shallow."
>     "That commit does not exist in this repository because it is an
>     ancestor of a shallow commit".
> 
> But it may be just me. Better wording ideas, anybody?
Yes, I see... I just transplanted the terminology that the protocol uses. When
"shallow SHA" is written, it means something is at the history boundary. Then
again, when "deepen d" is written, it specifies a depth and not an amount to
increase depth by, so maybe the strings the protocol uses are just bad for human
comprehension.
