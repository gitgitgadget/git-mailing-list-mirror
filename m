From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: convert from perl internal to utf8 for commitdiff_plain
Date: Mon, 28 Jan 2008 21:52:17 -0800
Message-ID: <7vejc1qium.fsf@gitster.siamese.dyndns.org>
References: <87ve5dicih.wl@mail2.atmark-techno.com>
	<7vir1dqjg0.fsf@gitster.siamese.dyndns.org>
	<87fxwhi3qj.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yasushi SHOJI <yashi@atmark-techno.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 06:53:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJjP7-0002Tt-6T
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 06:53:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179AbYA2Fw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 00:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754258AbYA2Fw3
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 00:52:29 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49333 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650AbYA2Fw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 00:52:28 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D8A81289F;
	Tue, 29 Jan 2008 00:52:26 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 58B9D289E;
	Tue, 29 Jan 2008 00:52:24 -0500 (EST)
In-Reply-To: <87fxwhi3qj.wl@mail2.atmark-techno.com> (Yasushi SHOJI's message
	of "Tue, 29 Jan 2008 14:45:56 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71950>

Yasushi SHOJI <yashi@atmark-techno.com> writes:

> At Mon, 28 Jan 2008 21:39:27 -0800,
> Junio C Hamano wrote:
>> 
>> Yasushi SHOJI <yashi@atmark-techno.com> writes:
>> 
>> > This patch effectively revert the commitdiff plain part of the commit
>> >
>> > 	59b9f61a3f76762dc975e99cc05335a3b97ad1f9
>> >
>> > which converted from print to here-doc. but it doesn't
>> > explain why in the commit log.
>> 
>> I think the patch makes sense but the above is misleading.  Read
>> it again.
>> 
>> Doesn't it sound like you are accusing that 59b9f61a introduced
>> a regression when it converted existsing "print utf8()" to
>> "print <<here-doc" without saying that is what it is doing?
>
> sorry about my stupid english.  What I meant was that because commit
> log doesn't say _why_ it changed to here-doc, I couldn't be sure it
> was ok to overwrite the change introduced by the commit 59b9f61a3.
>
> IOW, I was tring to ask, "is it ok to revert back to print?"

Sure.  Can I forge your Sign-off?
