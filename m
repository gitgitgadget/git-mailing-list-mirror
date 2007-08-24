From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-daemon on NSLU2
Date: Fri, 24 Aug 2007 15:59:32 -0700
Message-ID: <7vbqcwcze3.fsf@gitster.siamese.dyndns.org>
References: <9e4733910708232254w4e74ca72o917c7cadae4ee0f4@mail.gmail.com>
	<20070824062106.GV27913@spearce.org>
	<9e4733910708241238n1899f332j4fafbd6d7ccc48b9@mail.gmail.com>
	<alpine.LFD.0.999.0708241618070.16727@xanadu.home>
	<9e4733910708241417l44c55306xaa322afda69c6beb@mail.gmail.com>
	<9e4733910708241506h6eecc11ge41b1dc313022b4b@mail.gmail.com>
	<fanmmk$f5q$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 00:59:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOi7y-0008Nz-5O
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 00:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758769AbXHXW7h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 18:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761234AbXHXW7h
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 18:59:37 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:34015 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756375AbXHXW7g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 18:59:36 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id B62B712779A;
	Fri, 24 Aug 2007 18:59:55 -0400 (EDT)
In-Reply-To: <fanmmk$f5q$1@sea.gmane.org> (Jakub Narebski's message of "Sat,
	25 Aug 2007 00:39:16 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56610>

Jakub Narebski <jnareb@gmail.com> writes:

> There was idea to special case clone (just concatenate the packs, the
> receiving side as someone told there can detect pack boundaries; do not
> forget to pack loose objects, first), instead of using generic fetch --all
> for clone, bnut no code. Code speaks louder than words (although if someone
> would provide details of pack boundary detection...)

I have to say that "although ..." part of that statement
disqualifies this to be called an "idea".

Really, I find that you (yes, in this case I am not generalizing
but talking specifically about you) tend to overuse the word
"idea" when you talk things that are not yet even at that stage
yet.
