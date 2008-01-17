From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Do not show "diff --git" metainfo with --no-prefix
Date: Wed, 16 Jan 2008 18:42:13 -0800
Message-ID: <7vve5tkwai.fsf@gitster.siamese.dyndns.org>
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
	<7vabn5mdz7.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801170147350.17650@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Chris Ortman <chrisortman@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 17 03:43:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFKij-00055a-QB
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 03:43:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbYAQCmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 21:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbYAQCmk
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 21:42:40 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52676 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbYAQCmj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 21:42:39 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A68D4E62;
	Wed, 16 Jan 2008 21:42:38 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 912384D3E;
	Wed, 16 Jan 2008 21:42:30 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0801170147350.17650@racer.site> (Johannes
	Schindelin's message of "Thu, 17 Jan 2008 01:48:54 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70815>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> While we are discussing about diff, there is one thing that has been 
>> bugging me occasionally, but the annoyance factor has not motivated me 
>> enough to look into it myself, because I do not use it often: 
>> --color-words.  It appears that it shows lines that do not have any word 
>> differences in bold (whatever diff.color.meta is configured) and I think 
>> it should use plain color instead.
>> 
>> Was this intentional, or just a simple plain bug?
>
> Plain bug.  I even meant to implement your suggestion of having a variable 
> set of non-word characters, but never came around to work on it.  
> Hopefully this weekend...

I am not sure what that variable is about, but in the code you
have fn_out_diff_words_aux() that uses OLD/NEW/PLAIN and I do
not see where  you try to color anything to METAINFO color.

Perhaps you are talking about a different problem?  I am a bit
confused...
