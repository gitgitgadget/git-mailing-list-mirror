From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Mon, 25 Aug 2008 16:41:57 -0700
Message-ID: <7vy72kek6y.fsf@gitster.siamese.dyndns.org>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>
 <1219664940.9583.42.camel@pmac.infradead.org>
 <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org,
	users@kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 26 01:43:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXliL-0005xa-MF
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 01:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753442AbYHYXmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 19:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753384AbYHYXmH
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 19:42:07 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40524 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293AbYHYXmG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 19:42:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 91DE968B61;
	Mon, 25 Aug 2008 19:42:05 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 115A168B60; Mon, 25 Aug 2008 19:41:58 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes
 Schindelin's message of "Mon, 25 Aug 2008 20:19:49 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6CA33320-72FF-11DD-9D09-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93694>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 25 Aug 2008, David Woodhouse wrote:
>
>> On Sat, 2008-08-23 at 20:33 -0700, Junio C Hamano wrote:
>> > 
>> > There is one alternative, and one augmentation:
>> > 
>> >  (A) We do not do anything.
>> > 
>> >  (B) In addition to the main transition plan, outside git, prepare an
>> >      optional "git-old-style" package that installs many "git-foo" 
>> >      wrappers in $PATH (i.e. /usr/bin).  Each of them exec "git foo". 
>> >      People who like the dashed form can keep typing "git-foo", even 
>> >      though that will cost them two exec()s.
>> 
>>   (C) Just don't do it. Leave the git-foo commands as they were. They
>>       weren't actually hurting anyone, and you don't actually _gain_
>>       anything by removing them.
>
> Umm.  What exactly makes you feel you should ignore the discussions we had 
> around the issues on the git and msysgit mailing list?

Well, this was partly my fault, as I did not make it clear in this part
that beating the horse that has been dead for two years is not a
productive way to spend out time.  I however did, in the part David did
not quote, try to make it clear:

  That's all history now anyway.  We should try to do better the next time,
  which is much more important, and that is the topic of this message.

  Now, we haven't set the timeframe yet, but the original plan, advocated by
  Linus and others, was to eventually stop installing "git-foo" form on the
  filesystem for builtin commands.  If we were to do this, we should plan
  how the deprecation period for this change should look like.  I think the
  sequence of events would look like this:

that we are now talking about what we can do better from here going
forward, but these paragraphs were separated from the quoted part that
describes what kind of *variations* are possible in addition to the "the
sequence of events would look like this:" list, and allowed David to make
an out of context quoting that made a comment on an offtopic tangent look
as if it were one of the valid alternatives.
