From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-revert is one of the most misunderstood command in git, help users out.
Date: Mon, 05 Nov 2007 20:54:02 -0800
Message-ID: <7vode8j7o5.fsf@gitster.siamese.dyndns.org>
References: <1194289301-7800-1-git-send-email-madcoder@debian.org>
	<CD2E6759-9E7E-41E6-8B58-AB6CA9604111@midwinter.com>
	<7vlk9cmiyq.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711052325090.4362@racer.site>
	<7vsl3kjdct.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711060317220.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 06 05:54:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpGST-0006qS-8Q
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 05:54:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756162AbXKFEyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 23:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755667AbXKFEyW
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 23:54:22 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:48675 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755551AbXKFEyV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 23:54:21 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id A0C6C2EF;
	Mon,  5 Nov 2007 23:54:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 1EEFE92B76;
	Mon,  5 Nov 2007 23:54:37 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711060317220.4362@racer.site> (Johannes
	Schindelin's message of "Tue, 6 Nov 2007 03:18:34 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63624>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 5 Nov 2007, Junio C Hamano wrote:
>
>> Allowing people to revert or cherry pick partially by using paths 
>> limiter is a very good idea; the whole "it comes from a commit so we 
>> also commit" feels an utter nonsense, though.
>
> No.
>
> When "git revert <commit>" commits the result, "git revert <commit> -- 
> <file>" should, too.

I was not questioning about that part.  "If 'git revert <some
other form> foo' does not talk about commit, it should not
commit" was what I was referring to.
