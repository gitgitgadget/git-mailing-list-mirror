From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Wed, 27 Aug 2008 16:38:42 -0700
Message-ID: <7v63pmkozh.fsf@gitster.siamese.dyndns.org>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>
 <1219664940.9583.42.camel@pmac.infradead.org>
 <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <7vy72kek6y.fsf@gitster.siamese.dyndns.org>
 <20080826145719.GB5046@coredump.intra.peff.net>
 <7vr68b8q9p.fsf@gitster.siamese.dyndns.org>
 <20080827001705.GG23698@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, David Woodhouse <dwmw2@infradead.org>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org
To: Matthew Wilcox <matthew@wil.cx>
X-From: git-owner@vger.kernel.org Thu Aug 28 01:42:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYUef-0002MY-JC
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 01:42:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754475AbYH0XlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 19:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754441AbYH0XlS
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 19:41:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50447 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753690AbYH0XlS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 19:41:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3ACA164E97;
	Wed, 27 Aug 2008 19:41:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7EB4064CD6; Wed, 27 Aug 2008 19:38:56 -0400 (EDT)
In-Reply-To: <20080827001705.GG23698@parisc-linux.org> (Matthew Wilcox's
 message of "Tue, 26 Aug 2008 18:17:05 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A4A0206A-7491-11DD-81A5-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93988>

Matthew Wilcox <matthew@wil.cx> writes:

> On Tue, Aug 26, 2008 at 01:39:30PM -0700, Junio C Hamano wrote:
>> When I hear something like what David Woodhouse said in this thread, I
>> should be feeling "People -- those of you who claimed to be the silent
>> majority -- see, I told you so!  This is a very bad move".
>> 
>> But I can't.  People who complain _now_ just annoy me even more.  Why
>> weren't you defending the backward compatibility with me, which you seem
>> to value it so much, perhaps even more than I did back then?  Why are you
>> wasting our time bringing it up again, instead of joining the discussion
>> when it _mattered_ back then?
>
> We didn't know the conversation was going on.  Why should we?  We only
> use the tool, not develop it.  I'm also not on the mailing lists for
> mutt, vim, gcc, binutils, openssh, grep, xchat, mozilla, gnome, xpdf or
> any of the dozens of other programs I use on a daily basis.

Oh, I wasn't talking to you, or "we as git users".  The user side of the
discussion has long been over in another thread titled "[kernel.org users]
README and ChangeLog files" that was started by HPA, and everybody now
knows that the conclusion of the discussion was that 1.6.0 transition was
underadvertised to the end-user community and caused pain.  Sorry about
that, but let's leave it behind.  What has happend has happened.

The discussion in this thread was about how to go forward from here, now
the transition is over.  One of the future directions the transition was
aiming at was removal of git-foo form for built-ins even from the libexec
area -- I was complaining about David's beating an offtopic dead horse in
the above, because it was throwing the thread in an off-track direction,
distracting everybody from discussing what was more important, discussing
constructively if/how to proceed from here.

Now the primary topic of what to do about built-ins have already settled.
We _will_ keep git-foo commands in the libexec area.  We won't be removing
them.

So there is no need to worry.
