From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Importing patches from email, which address?
Date: Mon, 4 Aug 2008 11:09:59 +0200
Message-ID: <20080804090959.GA9425@diana.vm.bytemark.co.uk>
References: <9e4733910807280959h19039402kc14bfa1a3b653846@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 10:49:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPvkQ-0002Bb-TY
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 10:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbYHDIr5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Aug 2008 04:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752170AbYHDIr4
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 04:47:56 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2342 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbYHDIr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 04:47:56 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KPw4m-0002Za-00; Mon, 04 Aug 2008 10:10:00 +0100
Mail-Followup-To: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <9e4733910807280959h19039402kc14bfa1a3b653846@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91329>

On 2008-07-28 12:59:24 -0400, Jon Smirl wrote:

> When working with the list of author emails for the kernel, I
> noticed that a lot of the author's email address are from internal
> mail servers. How is the handled in git (stgit, etc..)? Is the
> import using the email From:, would it be better to use Reply-to:?

I believe all relevant tools use the From: header (unless it's
overridden by a From: in the message body). I think this is how Linus
originally wanted it to work -- in the first linux-kernel commit his
e-mail is torvalds@ppc970.osdl.org, and I seem to recall him saying
something along the lines of this being a feature: others could see
which machine he commited on, and the e-mail should really be
considered more of a unique identifier than an actual real e-mail
address.

Not sure if the policy has changed since then, though.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
