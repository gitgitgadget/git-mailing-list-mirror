From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Considering teaching plumbing to users harmful
Date: Wed, 16 Jul 2008 12:34:32 -0700
Message-ID: <7vabghr5br.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
 <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com>
 <7v7iblsnfh.fsf@gitster.siamese.dyndns.org>
 <32541b130807161151x19c20f9t91b7fb9b8c7b8c7b@mail.gmail.com>
 <7vmykhr6h1.fsf@gitster.siamese.dyndns.org>
 <32541b130807161229ob4c21cbsc6c86ee3e42c4101@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 21:36:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJCms-0003Xk-Ny
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 21:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755550AbYGPTem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 15:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752012AbYGPTem
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 15:34:42 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51446 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646AbYGPTel (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 15:34:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0E2A32451A;
	Wed, 16 Jul 2008 15:34:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 56D4324518; Wed, 16 Jul 2008 15:34:34 -0400 (EDT)
In-Reply-To: <32541b130807161229ob4c21cbsc6c86ee3e42c4101@mail.gmail.com>
 (Avery Pennarun's message of "Wed, 16 Jul 2008 15:29:39 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3A4A65A2-536E-11DD-B2AA-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88734>

"Avery Pennarun" <apenwarr@gmail.com> writes:

> On 7/16/08, Junio C Hamano <gitster@pobox.com> wrote:
>> "Avery Pennarun" <apenwarr@gmail.com> writes:
>> > svn avoids these excess merges by default, albeit because it puts your
>>  > working copy at risk every time you do "svn update".
>>
>> By default?  As if it has other mode of operation.
>>
>>  Of course if you do not allow any commits in between to make the history
>>  truly forked, you won't see merge commits.  It is like saying that you
>>  like your broken keyboard whose SHIFT key does not work because you think
>>  capital letters look ugly and your keyboard protects you from typing them
>>  by accident.
>>
>>  Is that an improvement?
>>
>>  I won't waste my time further on the apples and rotten oranges comparison,
> ...
> svn is fundamentally broken, but just because they did *some* things
> wrong doesn't mean they did *everything* wrong.  You can learn lessons
> even from your inferiors.

I agree in principle, but read what you wrote again and realize that your
criticism does not apply to this case *at all*.

You said svn makes it easier because it makes it very hard to do merges
and forces users to stay away from them.  This results in user doing "svn
update" which is to resolve conflicts with large uncommitted changes but
keeps the history straight single-strand-of-pearls.  

I am not saying the merge based workflow in git does not have any room to
improve.  I am just saying that there is nothing we can learn from svn in
that area.  "Solves it by not letting us to do merges" is not a solution.
