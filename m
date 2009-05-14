From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Q] merge squash unexpected conflicts
Date: Wed, 13 May 2009 21:42:19 -0700
Message-ID: <7veiusz45w.fsf@alter.siamese.dyndns.org>
References: <bb9d69200905131706m61b0dda1xc347ca2e719ec142@mail.gmail.com>
	<bb9d69200905131942t7a43a29fh9638d2548e9f12dc@mail.gmail.com>
	<7v4ovo1iap.fsf@alter.siamese.dyndns.org>
	<bb9d69200905132057u60adc2f8vb9ba9a35791f72ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Cory Sharp <cory.sharp@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 06:42:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4SmC-0004V3-Vh
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 06:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752190AbZENEmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 00:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbZENEmT
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 00:42:19 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:50060 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbZENEmT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 00:42:19 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090514044220.MFZU17670.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Thu, 14 May 2009 00:42:20 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id rGiK1b00a4aMwMQ04GiKsW; Thu, 14 May 2009 00:42:19 -0400
X-Authority-Analysis: v=1.0 c=1 a=zSBdUJs4lXYA:10 a=pGLkceISAAAA:8
 a=ybZZDoGAAAAA:8 a=iPh8y5EUt-ChKEYEu0IA:9 a=WC08VKV7MNvTigyaBx5x4VUjoV8A:4
 a=MSl-tDqOz04A:10 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
In-Reply-To: <bb9d69200905132057u60adc2f8vb9ba9a35791f72ac@mail.gmail.com> (Cory Sharp's message of "Wed\, 13 May 2009 20\:57\:43 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119132>

Cory Sharp <cory.sharp@gmail.com> writes:

> On Wed, May 13, 2009 at 8:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> ..
>> Of course.  That's the whole point of recording a merge as a merge.
>>
>
> $ git help merge
>
>   --squash
>            Produce the working tree and index state as if a real merge
> happened. ... This allows you to create a
>            single commit on top of the current branch whose effect is
> the same as merging another branch.

What's your point?

WIth --squash, the tree and the index state becomes the same as if a real
merge happened.  But the merge history is discarded with --squash.  It is
a simulation of a merge in CVS and SVN (before they added "merge tracking").

If you want support for repeated merges by merge tracking, you do not want
todiscard the merge history by using --squash.
