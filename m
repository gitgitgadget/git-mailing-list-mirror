From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Write diff output to a file in struct diff_options
Date: Sun, 09 Mar 2008 23:18:03 -0700
Message-ID: <7v3aqzm7ac.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0803092235150.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Mar 10 07:18:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYbLb-0002La-P4
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 07:18:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617AbYCJGSR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 02:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752668AbYCJGSR
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 02:18:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39634 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752409AbYCJGSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 02:18:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 168EC114C;
	Mon, 10 Mar 2008 02:18:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 97D01114B; Mon, 10 Mar 2008 02:18:10 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0803092235150.19665@iabervon.org> (Daniel
 Barkalow's message of "Sun, 9 Mar 2008 22:43:39 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76698>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---
> I remember there being some expectation that this would be difficult, but 
> it was a pretty straightforward conversion, so I'm wondering if I've 
> missed something. In any case, this is missing tests and documentation for 
> --output=, but I really want it to use directly for rebase-interactive, 
> and I only did the command line option so I could do informal testing.

Looks Ok at lesat to my cursory review.

Some people however seemed to have had plans to take this even further and
optionally emit into strbuf; I suspect that was the difficulty you were
remembering about?
