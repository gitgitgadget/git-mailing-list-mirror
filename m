From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Cast things properly to handle >2G files.
Date: Wed, 17 Jun 2009 16:16:20 -0700
Message-ID: <7v7hzae9iz.fsf@alter.siamese.dyndns.org>
References: <E1MFvux-0001ix-I7@fencepost.gnu.org>
	<alpine.DEB.1.00.0906142215560.26154@pacific.mpi-cbg.de>
	<E1MG32S-0004C6-8A@fencepost.gnu.org>
	<alpine.LFD.2.01.0906142118250.3305@localhost.localdomain>
	<E1MH3bD-0004g2-97@fencepost.gnu.org>
	<alpine.LFD.2.01.0906171543120.16802@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: "Alfred M. Szmidt" <ams@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jun 18 01:25:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MH4Vg-0000Vp-32
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 01:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755510AbZFQXZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 19:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753429AbZFQXZb
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 19:25:31 -0400
Received: from fed1rmmtai102.cox.net ([68.230.241.58]:58395 "EHLO
	fed1rmmtai102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753939AbZFQXZa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 19:25:30 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090617231621.YPYW2915.fed1rmmtao103.cox.net@fed1rmimpo03.cox.net>;
          Wed, 17 Jun 2009 19:16:21 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 5BGL1c00L4aMwMQ04BGLMs; Wed, 17 Jun 2009 19:16:20 -0400
X-VR-Score: -200.00
X-Authority-Analysis: v=1.0 c=1 a=AYBFenIAru0A:10 a=Z4Rwk6OoAAAA:8
 a=ABRZB0M4jOrPjYWabf8A:9 a=daDhEadr4rCZn-rLQMbLupbwJ1YA:4 a=jbrJJM5MRmoA:10
X-CM-Score: 0.00
In-Reply-To: <alpine.LFD.2.01.0906171543120.16802@localhost.localdomain> (Linus Torvalds's message of "Wed\, 17 Jun 2009 15\:45\:16 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121786>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 17 Jun 2009, Alfred M. Szmidt wrote:
>> 
>> I would suggest the following update to the DCO, it makes it more
>> general both to free software hackers, and open source hackers alike.
>
> And I would suggest that Junio just not take patches from people who 
> aren't able to read the existing DCO. It's not worth the pain. 
>
> 		Linus

Thanks for trying to reduce my load.  Very much appreciated.

Even though I am _not_ a nice person, I _am_ a practical one.  Before
stopping to pay attention to this thread, I'll quote from my response once
more to ask a simple yes-or-no questions to Alfred.

  Are you the original author of the patch, and have the right to submit
  it under the license "indicated in the file"?

  The overall license of git is GPLv2, and that is what applies to unless
  there is an explicit license term indicated in the file otherwise. We do
  have some code under different licenses in some parts of the system, but
  the files that you are touching are all GPLv2.

  Can you certify that your patch is yours and you have rights to make it
  part of git under the same terms as the original?  Or can you not?

So Alfred, "yes"?  or "no"?  If "yes", you can send a sign-off.

Of course you can choose not to even if the answer is "yes", but then we
can choose to ignore your patch, too; and in fact we probably have to.
