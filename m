From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add gitattributes file making whitespace checking pickier
Date: Sun, 10 Feb 2008 13:52:28 -0800
Message-ID: <7v3as0fpib.fsf@gitster.siamese.dyndns.org>
References: <20080209162234.GA25533@fieldses.org>
	<m363wxhey1.fsf@localhost.localdomain>
	<7v8x1t5uk1.fsf@gitster.siamese.dyndns.org>
	<200802101231.16847.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 22:53:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOK71-0000Xn-KG
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 22:53:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbYBJVwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 16:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbYBJVwr
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 16:52:47 -0500
Received: from rune.pobox.com ([208.210.124.79]:36783 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750906AbYBJVwq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 16:52:46 -0500
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 65BE71969A8;
	Sun, 10 Feb 2008 16:53:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id C47C9196747;
	Sun, 10 Feb 2008 16:52:58 -0500 (EST)
In-Reply-To: <200802101231.16847.jnareb@gmail.com> (Jakub Narebski's message
	of "Sun, 10 Feb 2008 12:31:15 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73421>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>> 
>>>> *.py whitespace=!indent,trail,space
>>>> *.el whitespace=!indent,trail,space
>
> Emacs Lisp is (like Perl, and contrary to Python) whitespace agnostic,

What does agnostic have anything to do with anything?

C is whitespace agnostic and outside obvious places like string
constants and #preprocessor directives you can have SP and HT
and LF interchangeably.  It does not mean you do not need
whitespace policy.

If gitweb historically used SP everywhere like git.el, I think
that is a very good reason to treat it just like *.py and *.el,
though.  See the updated set of patterns I sent to Daniel just
now.

>> It also happens that I do not personally believe in "alignment
>> with spaces" argument.  If you accept W and a SP occupy the same
>> horizontal space (which "alignment with spaces" assume), I do
>> not think it is unreasonable to accept HT goes to the next
>> column that is multiple of 8 places.
>  
> My argument is ...

Wasn't my 5 lines enough clue to save you from repeating that?
I said I do not agree with it, so please don't even try wasting
everybody's time on bikeshedding.
