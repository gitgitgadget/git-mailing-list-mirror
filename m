From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] Add a --cover-letter option to format-patch
Date: Mon, 18 Feb 2008 13:09:46 -0800
Message-ID: <7vejbanf8l.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802171335520.5816@iabervon.org>
 <alpine.LSU.1.00.0802181245270.30505@racer.site>
 <alpine.LNX.1.00.0802181254060.5816@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Feb 18 22:11:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRDGZ-0008LZ-Jp
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 22:11:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970AbYBRVKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 16:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752824AbYBRVKP
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 16:10:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37704 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761524AbYBRVKN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 16:10:13 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E7937BEB;
	Mon, 18 Feb 2008 16:10:11 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 379497BE7; Mon, 18 Feb 2008 16:09:49 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0802181254060.5816@iabervon.org> (Daniel
 Barkalow's message of "Mon, 18 Feb 2008 13:54:36 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74354>

Daniel Barkalow <barkalow@iabervon.org> writes:

>> > diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
>> > index 651efe6..53e6d2e 100644
>> > --- a/Documentation/git-format-patch.txt
>> > +++ b/Documentation/git-format-patch.txt
>> > @@ -17,6 +17,7 @@ SYNOPSIS
>> >                     [--in-reply-to=Message-Id] [--suffix=.<sfx>]
>> >                     [--ignore-if-in-upstream]
>> >                     [--subject-prefix=Subject-Prefix]
>> > +                   [--cover-letter]
>> >  		   [ <since> | <revision range> ]
>> 
>> Since you are already there, and it is really a small change, why not fix 
>> the whitespace?
>
> What *is* the correct whitespace for alignment in documentation?

The last time I checked, AsciiDoc output did not change before
and after running "expand" and then "unexpand" in all *.txt
files in Documentation/ directory, so if it is indenting to
multiple of 8, HT is fine.

Don't we have Documentation/.gitattributes that says indentation
to 8*N-th column must be done with N HTs these days?

>> Why not sign off the cover letter, too?
>
> I think cover letters aren't normally signed off, since they don't contain 
> any content that goes into the history.

Right.  They do not contain any content that needs DCO.
