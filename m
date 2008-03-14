From: Sergei Organov <osv@javad.com>
Subject: Re: About detached heads
Date: Fri, 14 Mar 2008 15:16:11 +0300
Message-ID: <87lk4lo60k.fsf@osv.gnss.ru>
References: <93c3eada0803140246k53408c74m21f9dc277857202d@mail.gmail.com>
	<m3lk4ly3vy.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: geoffrey.russell@gmail.com, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 13:17:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja8qK-0006rA-4O
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 13:17:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316AbYCNMQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 08:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753232AbYCNMQV
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 08:16:21 -0400
Received: from javad.com ([216.122.176.236]:1968 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751996AbYCNMQU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 08:16:20 -0400
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id m2ECGHV70539;
	Fri, 14 Mar 2008 12:16:17 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1Ja8pX-00023W-HJ; Fri, 14 Mar 2008 15:16:11 +0300
In-Reply-To: <m3lk4ly3vy.fsf@localhost.localdomain> (Jakub Narebski's message of "Fri\, 14 Mar 2008 03\:52\:14 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77212>

Jakub Narebski <jnareb@gmail.com> writes:

[...]

> 3. Now, if you have published 1..5 history you would not want
> (usually) to rewind published branch. If you do the following:
>
>   $ git revert --no-commit 5

the working tree in now dirty...

>   $ git revert 4

and this one fails with dirty tree :(

Probably:

$ git revert -n 5 && git revert -n 4 && git commit -a


BTW, why git-revert doesn't take a range? Is there some fundamental
problem with it?

-- Sergei.
