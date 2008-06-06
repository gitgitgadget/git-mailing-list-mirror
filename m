From: Kevin Ballard <kevin@rapleaf.com>
Subject: Re: git-clone still broken wrt. unpacking working tree with http transport
Date: Fri, 6 Jun 2008 16:28:50 -0700
Message-ID: <32A340A4-BB0C-4D0E-9B8D-A4FCEA4B24D1@rapleaf.com>
References: <0F5C1FC7-258E-44A4-9FE6-AB6696D0B5BE@rapleaf.com> <20080606061428.GF18257@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 07 01:29:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4lNQ-0002Vy-Ev
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 01:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756308AbYFFX2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 19:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbYFFX2w
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 19:28:52 -0400
Received: from mail.rapleaf.com ([208.96.16.213]:50361 "EHLO mail.rapleaf.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756308AbYFFX2v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 19:28:51 -0400
Received: from mail.rapleaf.com (localhost.localdomain [127.0.0.1])
	by mail.rapleaf.com (Postfix) with ESMTP id 8344812502D0;
	Fri,  6 Jun 2008 16:28:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; c=nofws; d=rapleaf.com; q=dns; s=m1; b=v8QaM
	Z7K4v6OITd6FaxzfJYtoyXsdgAS46+5DuT06UhaM7RGF0heI1balImCxx5x7+Dpg
	t4rQ7nHWwp3wpTDc/JBZKFJu1fBfQVLWK+R1VRVtJU4hVQk4+Ao6XSYEkt5nYiEF
	5HHlAcIYpeolEmygk4bViGfSDdtqU1djPlu2pw=
Received: from [10.100.18.156] (unknown [10.100.18.156])
	by mail.rapleaf.com (Postfix) with ESMTP id 5C5461250050;
	Fri,  6 Jun 2008 16:28:50 -0700 (PDT)
In-Reply-To: <20080606061428.GF18257@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84143>

No I didn't. I guess it's just bad luck that 541fc218 was committed a  
few hours before I reported the issue ;) I generally git-pull in the  
morning, so I pulled before that got committed.

Actually, I ran into it last week but forgot to mention it then.

-Kevin

On Jun 5, 2008, at 11:14 PM, Jeff King wrote:

> On Thu, Jun 05, 2008 at 04:48:56PM -0700, Kevin Ballard wrote:
>
>> The new builtin git-clone is still broken in that it doesn't unpack  
>> the
>> working tree if the clone happened over http.
>
> Did you try with a git that contains 541fc218?
>
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Kevin Ballard
kevin@rapleaf.com
