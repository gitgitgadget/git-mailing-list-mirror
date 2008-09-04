From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash completion: Hide more plumbing commands
Date: Wed, 03 Sep 2008 21:57:47 -0700
Message-ID: <7vwshs7bjo.fsf@gitster.siamese.dyndns.org>
References: <20080826171012.GO10360@machine.or.cz>
 <20080826171144.21328.82727.stgit@localhost>
 <m3y72jr80w.fsf@localhost.localdomain> <20080903175651.GZ10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, andi@firstfloor.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Sep 04 06:59:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb6vy-0002zx-6g
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 06:59:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752336AbYIDE57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 00:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752233AbYIDE56
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 00:57:58 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53738 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654AbYIDE55 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 00:57:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4265C72F38;
	Thu,  4 Sep 2008 00:57:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id AAB0D72F36; Thu,  4 Sep 2008 00:57:49 -0400 (EDT)
In-Reply-To: <20080903175651.GZ10360@machine.or.cz> (Petr Baudis's message of
 "Wed, 3 Sep 2008 19:56:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 09D1D012-7A3E-11DD-BDB1-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94893>

Petr Baudis <pasky@suse.cz> writes:

> On Tue, Aug 26, 2008 at 10:38:45AM -0700, Jakub Narebski wrote:
>> Petr Baudis <pasky@suse.cz> writes:
>> > +		count-objects)    : plumbing;;
>> 
>> Plumbing (hyphenated name is a very good hint), but useful to decide
>> when to repack. I'm partially to leaving it, as I use it from time to
>> time from CLI.
>
> Is this just residuum of customs developed before auto-gc was
> introduced?
>
>> > +		ls-files)         : plumbing;;
>> 
>> IIRC it doesn't have porcelain equivalent.
>
> git status for the generally end-user-interesting functionality.

I do not consider either of the above plumbing, but I tend to agree that
they are much less frequently used.  I think verify-pack falls into the
same category.

Applied to 'maint' but won't be pushing out for some time (my git day is
over).
