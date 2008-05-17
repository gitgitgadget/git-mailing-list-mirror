From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rephrased git-describe description
Date: Fri, 16 May 2008 17:03:00 -0700
Message-ID: <7vej81er0r.fsf@gitster.siamese.dyndns.org>
References: <1210789855-29413-1-git-send-email-ian.hilt@gmail.com>
 <7v7idwoh9m.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.10.0805141856380.30187@sys-0.hiltweb.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Kevin Ballard <kevin@sb.org>
To: Ian Hilt <ian.hilt@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 17 02:04:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx9uA-0003jW-4z
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 02:04:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232AbYEQADQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 20:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753137AbYEQADQ
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 20:03:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56011 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765AbYEQADP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 20:03:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BDE815672;
	Fri, 16 May 2008 20:03:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 20F585671; Fri, 16 May 2008 20:03:06 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A5681EF0-23A4-11DD-AF30-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82322>

Ian Hilt <ian.hilt@gmail.com> writes:

> On Wed, 14 May 2008 at 11:46am -0700, Junio C Hamano wrote:
>
>> Ian Hilt <ian.hilt@gmail.com> writes:
>>
>>> git-describe: Make description more readable.
>>
>> Thanks, both.  I think the above is meant to be on the Subject: line, and
>> the text certainly is more readable.
>
> This is probably a stupid question, but is that all you want for
> a commit message?

I think the following is clear enough to describe what your patch did.

    commit b7893cde53eb2834deb16820eccb709d2636b81b
    Author: Ian Hilt <ian.hilt@gmail.com>
    Date:   Wed May 14 14:30:55 2008 -0400

        Documentation/git-describe.txt: make description more readable

        Signed-off-by: Ian Hilt <ian.hilt@gmail.com>
        Credit-to: Kevin Ballard <kevin@sb.org>
        Signed-off-by: Junio C Hamano <gitster@pobox.com>

When made into a line in the shortlog, this makes it clear that it affects
the documentation (and documentation only), and it describes what the
patch did.

If there is a guiding principle that drove the change the patch did, and
that guiding principle is something other people can follow when fixing
similar breakages, it often is a good idea to describe what they are in
the body of the commit log message.  But I did not see such a clear,
reusable guiding principle for this change.

What I mean by a guiding principle in this case is something like...

 - command description should start with a clear description of what it
   does, so that the readers can decide if that is the command they want
   to solve their problem with by reading the very first part;

 - and then it should describe how it does it in an unambiguous and easy
   to read language.

Then you can have a comparison between the text before and after the
change to explain why the updated text is more unambiguous.  But you would
risk ending up with a textbook of English composition which is not what we
necessarily want to do here ;-)
