From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Do not show "diff --git" metainfo with --no-prefix
Date: Wed, 16 Jan 2008 17:34:52 -0800
Message-ID: <7vabn5mdz7.fsf@gitster.siamese.dyndns.org>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com>
	<alpine.DEB.1.00.0801151444180.5289@eeepc-johanness>
	<c0f2d4110801150758t68714570y83e1e74acbb67325@mail.gmail.com>
	<alpine.LNX.1.00.0801151728120.13593@iabervon.org>
	<7vhched3kw.fsf@gitster.siamese.dyndns.org>
	<7v4pded1rk.fsf_-_@gitster.siamese.dyndns.org>
	<7v7iiabjyh.fsf_-_@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801151902080.2806@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801151919440.2806@woody.linux-foundation.org>
	<alpine.LNX.1.00.0801152256480.13593@iabervon.org>
	<alpine.LFD.1.00.0801152017490.2806@woody.linux-foundation.org>
	<7v1w8hploy.fsf@gitster.siamese.dyndns.org>
	<alpine.LNX.1.00.0801161524390.13593@iabervon.org>
	<7vprw1mfpr.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801170108440.17650@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Chris Ortman <chrisortman@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 17 02:35:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFJfJ-000556-9a
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 02:35:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbYAQBfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 20:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbYAQBfD
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 20:35:03 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48964 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542AbYAQBfB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 20:35:01 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 980262977;
	Wed, 16 Jan 2008 20:34:59 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F22CD2973;
	Wed, 16 Jan 2008 20:34:53 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0801170108440.17650@racer.site> (Johannes
	Schindelin's message of "Thu, 17 Jan 2008 01:11:16 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70803>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 16 Jan 2008, Junio C Hamano wrote:
>
>> An important point for me in this discussion is to agree that the 
>> current --no-prefix that claims to be "diff --git" is not safe for 
>> release and come to consensus that we need a fix.
>
> Having had time to think about it for a while, I think that...

While we are discussing about diff, there is one thing that has
been bugging me occasionally, but the annoyance factor has not
motivated me enough to look into it myself, because I do not use
it often: --color-words.  It appears that it shows lines that do
not have any word differences in bold (whatever diff.color.meta
is configured) and I think it should use plain color instead.

Was this intentional, or just a simple plain bug?

I noticed when I was reviewing documentation patch I received
from Dave Peticolas today (the feature is great for "apply the
patch as received, review the --color-words output, and undo the
uncalled-for line wrapping" workflow).
