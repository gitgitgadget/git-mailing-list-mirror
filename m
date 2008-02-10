From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add gitattributes file making whitespace checking pickier
Date: Sat, 09 Feb 2008 20:01:18 -0800
Message-ID: <7v8x1t5uk1.fsf@gitster.siamese.dyndns.org>
References: <20080209162234.GA25533@fieldses.org>
	<alpine.LNX.1.00.0802091251430.13593@iabervon.org>
	<20080209185038.GB25533@fieldses.org>
	<7vr6fletkl.fsf@gitster.siamese.dyndns.org>
	<m363wxhey1.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 05:02:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO3OF-0008RI-QJ
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 05:02:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755863AbYBJEBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 23:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755857AbYBJEBa
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 23:01:30 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64223 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755809AbYBJEB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 23:01:29 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 744F731B3;
	Sat,  9 Feb 2008 23:01:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BE13031AF;
	Sat,  9 Feb 2008 23:01:20 -0500 (EST)
In-Reply-To: <m363wxhey1.fsf@localhost.localdomain> (Jakub Narebski's message
	of "Sat, 09 Feb 2008 15:45:35 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73306>

Jakub Narebski <jnareb@gmail.com> writes:

>> *.py whitespace=!indent,trail,space
>> *.el whitespace=!indent,trail,space
>> fast-import/git-p4 whitespace=!indent,trail,space
>
> I would also exclude gitweb/gitweb.perl

Why?

As far as I can tell, Perl does not use Python/Elisp "indents
are all whitespace" rule and neither does the script.

It also happens that I do not personally believe in "alignment
with spaces" argument.  If you accept W and a SP occupy the same
horizontal space (which "alignment with spaces" assume), I do
not think it is unreasonable to accept HT goes to the next
column that is multiple of 8 places.
