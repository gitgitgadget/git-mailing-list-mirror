From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Community Book
Date: Tue, 29 Jul 2008 10:43:15 -0700
Message-ID: <7vmyk0fux8.fsf@gitster.siamese.dyndns.org>
References: <d411cc4a0807290920p62f5d7e1r727a62ef2b4611fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git list" <git@vger.kernel.org>
To: "Scott Chacon" <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 19:45:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNtGB-0001qM-Td
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 19:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759893AbYG2RnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 13:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760274AbYG2RnX
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 13:43:23 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43789 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757560AbYG2RnV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 13:43:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 193AA41D91;
	Tue, 29 Jul 2008 13:43:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4E83F41D8C; Tue, 29 Jul 2008 13:43:17 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D54AB328-5D95-11DD-80B0-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90661>

"Scott Chacon" <schacon@gmail.com> writes:

> So I wanted to develop a really nice, easy to follow book for Git
> newcomers to learn git quickly and easily.  One of the issues I
> remember having when learning Git is that there is a lot of great
> material in the User Guide, Tutorial, Tutorial 2, Everyday Git, etc -
> but they're all huge long documents that are sometimes difficult to
> come back to and remember where you were, and I didn't know which one
> to start with or where to find what I was looking for, etc.

Interesting.  A few comments, before I get dragged into my day job fully.

[overall]

 - Some people mentioned that the necessity of reading through large
   volume of documentation can be reduced if they were divided by
   developer roles (similar to how Everyday does), e.g. people in
   individual contributor role does not have to learn integrator tools
   such as "am" in their first pass on the documentation.  Has the
   approach considered while developing this book?

 - The order of sections in "Working with Git" chapter somehow does not
   feel quite right, except that I'd agree that "Git on Windows" at the
   beginning is a very good idea (disclaimer. I do not use Windows
   myself). "StGIT" coming next was very understandable, but then
   "Capistrano"????  And no CVS section next to Subversion section?  Ruby
   before Perl or Python (I would have listed Perl, Python and then Ruby
   to avoid language wars.  That's the language age order, and it is even
   alphabetical)???

   Above "Capistrano" and "Ruby" comment shows the bias this TOC has (and
   my bias being different from the TOC's bias).  I'd imagine that
   Ruby-minded folks won't share the same reaction as I had.  What's the
   target audience of this book?  Git users in general, or primarily
   Ruby-minded subset?  If the latter, labeling this as "Community Book"
   may be misleading.

[http://book.git-scm.com/1_the_git_object_database.html]

 - The color of "blob" does not match the blob that is committed to eat
   trees at the top of your site ;-)

 - In a recent thread on the list, quite a lot of people seem to have
   found that teaching the low level details and plumbing first to the new
   people is detrimental.  Do you have response to that thread?
