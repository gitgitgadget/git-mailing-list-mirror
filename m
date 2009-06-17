From: "Alfred M. Szmidt" <ams@gnu.org>
Subject: Re: [PATCH] Cast things properly to handle >2G files.
Date: Wed, 17 Jun 2009 18:27:19 -0400
Message-ID: <E1MH3bD-0004g2-97@fencepost.gnu.org>
References: <E1MFvux-0001ix-I7@fencepost.gnu.org> <alpine.DEB.1.00.0906142215560.26154@pacific.mpi-cbg.de> <E1MG32S-0004C6-8A@fencepost.gnu.org> <alpine.LFD.2.01.0906142118250.3305@localhost.localdomain>
Reply-To: ams@gnu.org
Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 18 00:27:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MH3bO-0007xD-Ia
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 00:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759906AbZFQW1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 18:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756825AbZFQW1T
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 18:27:19 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:48912 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756054AbZFQW1R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 18:27:17 -0400
Received: from ams by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <ams@gnu.org>)
	id 1MH3bD-0004g2-97; Wed, 17 Jun 2009 18:27:19 -0400
In-reply-to: <alpine.LFD.2.01.0906142118250.3305@localhost.localdomain>
	(message from Linus Torvalds on Sun, 14 Jun 2009 21:25:34 -0700 (PDT))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121782>

   > I cannot agree to the D-C-O in good faith, since it speaks of
   > open source licenses, a group of licenses that include non-free
   > software licenses, something which I cannot support.

   If you can't sign off on it, then Junio shouldn't take it, since
   you're basically saying that you cannot say that you own the
   copyrights or cannot license it under the appropriate copyright.

That is not what I am saying.  In either case, I already explained why
I cannot agree to the DCO above.  And you are right, Junio shouldn't
apply the patch if it goes against commit policies.

   Yes, it speaks of "open source licenses", but it says: "under the
   open source license indicated in the file", and "appropriate open
   source license".

That is a good point, almost none of the files in git specify the
license so it is impossible to know what one is actually agreeing too.

I would suggest the following update to the DCO, it makes it more
general both to free software hackers, and open source hackers alike.

  Developer's Certificate of Origin 1.2-draft

  By making a contribution to this project, I certify that:

  (a) The contribution was created in whole or in part by me and I
      have the right to submit it under the license indicated in the
      file; or

  (b) The contribution is based upon previous work that, to the best
      of my knowledge, is covered under an compatible license and I
      have the right under that license to submit that work with
      modifications, whether created in whole or in part by me, under
      the same license (unless I am permitted to submit under a
      different license), as indicated in the file; or

  (c) The contribution was provided directly to me by some other
      person who certified (a), (b) or (c) and I have not modified it.

  (d) I understand and agree that this project and the contribution
      are public and that a record of the contribution (including all
      personal information I submit with it, including my sign-off) is
      maintained indefinitely and may be redistributed consistent with
      this project or the license(s) involved.
