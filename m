From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Multiple -M options for git-cvsimport
Date: Fri, 29 Feb 2008 21:59:19 -0800
Message-ID: <7vejav7zns.fsf@gitster.siamese.dyndns.org>
References: <1204193904-3652-1-git-send-email-book@cpan.org>
 <7vzltkj14d.fsf@gitster.siamese.dyndns.org>
 <20080229100241.GA6777@plop.home.bruhat.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Philippe Bruhat (BooK)" <book@cpan.org>
X-From: git-owner@vger.kernel.org Sat Mar 01 07:00:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVKlY-0002MO-KL
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 07:00:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697AbYCAF7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 00:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752651AbYCAF7d
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 00:59:33 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50884 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545AbYCAF7d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 00:59:33 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1EB872315;
	Sat,  1 Mar 2008 00:59:32 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 68E0F2314; Sat,  1 Mar 2008 00:59:29 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75622>

"Philippe Bruhat (BooK)" <book@cpan.org> writes:

> On Thu, Feb 28, 2008 at 12:07:46PM -0800, Junio C Hamano wrote:
>
>> I'll take a look at them later, when I have enough time to fish
>> for messages and discussions from earlier round in the list
>> archive in order to process this.
>
> You can ignore my previous messages, then. These four patches were
> rebased on the top of master, and correct the problems that were
> previously pointed to me.

I do not work that way.  I am a trust-but-verify kind of person.

So I dug up the old ones and the discussion.  The series looks
fine.

cvsimport: have default merge regex allow for dashes in the branch name

  You can extend the default with -M anyway, but I guess the
  default pattern can be loosened like this without increasing
  the risk of false hits, so probably it is Ok.

cvsimport: allow for multiple -M options

  Ok.

cvsimport: document that -M can be used multiple times

  Ok, except that "can be used seveval times" should probably be
  "can be used more than once".

cvsimport: configure Getopt::Long to bundle options

  Ok.  Why isn't bundling the default, I have to wonder...

