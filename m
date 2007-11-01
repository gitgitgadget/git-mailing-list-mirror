From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Newbie: report of first experience with git-rebase.
Date: Thu, 01 Nov 2007 13:20:04 -0700
Message-ID: <7v8x5hbtvv.fsf@gitster.siamese.dyndns.org>
References: <87d4uv3wh1.fsf@osv.gnss.ru>
	<20071031195702.GB24332@atjola.homenet> <874pg73u6h.fsf@osv.gnss.ru>
	<Pine.LNX.4.64.0710312111170.4362@racer.site>
	<7vhck7gdzs.fsf@gitster.siamese.dyndns.org>
	<87ve8m2mfn.fsf@osv.gnss.ru>
	<Pine.LNX.4.64.0711011423440.4362@racer.site>
	<20071101151016.GA26103@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sergei Organov <osv@javad.com>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 21:20:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IngWi-0005oj-Pf
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 21:20:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754558AbXKAUUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 16:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754460AbXKAUUN
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 16:20:13 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:50196 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837AbXKAUUL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 16:20:11 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id B7DA72F0;
	Thu,  1 Nov 2007 16:20:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 2EF4F911F5;
	Thu,  1 Nov 2007 16:20:28 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62989>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> On Thu, Nov 01, 2007 at 02:24:37PM +0000, Johannes Schindelin wrote:
>> 
>> They are rare events.  In your case I guess that subtly different versions 
>> were _actually_ applied (such as white space fixes),
>
> That's actually pretty common, in my experience.
>
>> which is why such a rare event hit you.
>
> I'm using git to track some changes I submitted to a project that's
> mainly text, and that I only get release tarballs of.  On my most recent
> rebase all my patches got applied, but the text also got re-wrapped and
> re-indented at the same time.  So all but I think one or two of a dozen
> patches ended up with a conflict resolution and then --skip.
>
> Which may not be a case git's really intended for--fair enough.  But
> I've found it's pretty common in my kernel work too.  Either I'm
> rebasing against changes I made myself, or else a maintainer took my
> changes but fixed up some minor style problems along the way.

Ok, so I retract that "rare" comment.

Now, we have established that this is a real problem worth
solving, what's next?
