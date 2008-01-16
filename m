From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Do not show "diff --git" metainfo with --no-prefix
Date: Tue, 15 Jan 2008 18:15:58 -0800
Message-ID: <7v63xutt0h.fsf@gitster.siamese.dyndns.org>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com>
	<alpine.DEB.1.00.0801151444180.5289@eeepc-johanness>
	<c0f2d4110801150758t68714570y83e1e74acbb67325@mail.gmail.com>
	<alpine.LNX.1.00.0801151728120.13593@iabervon.org>
	<7vhched3kw.fsf@gitster.siamese.dyndns.org>
	<7v4pded1rk.fsf_-_@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801160133150.17650@racer.site>
	<7vir1ubl0g.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801160152540.17650@racer.site>
	<alpine.LNX.1.00.0801152056030.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Chris Ortman <chrisortman@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 03:16:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JExpg-0003RH-Iw
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 03:16:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbYAPCQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 21:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbYAPCQT
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 21:16:19 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49704 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbYAPCQS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 21:16:18 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D67883A4;
	Tue, 15 Jan 2008 21:16:17 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A27A983A2;
	Tue, 15 Jan 2008 21:16:10 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0801152056030.13593@iabervon.org> (Daniel
	Barkalow's message of "Tue, 15 Jan 2008 21:04:24 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70604>

Daniel Barkalow <barkalow@iabervon.org> writes:

> At most, I think, if a_one and b_two are identical, we could use the 
> "Index:" form, since "diff -ur something something" is weird (how can 
> "something" be different from itself?).

I think you can have --src-prefix=a- --dst-prefix=b- and see
"diff a-foo b-foo" ;-).  I really do not care much either way,
as long as it does not say "diff --git".

This is also an offtopic remark but I have been wondering how
safe those fake "diff --git" output people seem to be able to
get out of recent-enough Hg.
