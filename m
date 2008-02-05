From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/9] Allow callers of unpack_trees() to handle failure
Date: Tue, 05 Feb 2008 15:43:43 -0800
Message-ID: <7vd4rb7yvk.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802041334450.13593@iabervon.org>
	<alpine.LSU.1.00.0802050107440.8543@racer.site>
	<alpine.LNX.1.00.0802051428180.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 01:35:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMYFj-00019u-4S
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 01:35:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760944AbYBFAe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 19:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760938AbYBFAe2
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 19:34:28 -0500
Received: from lollipop.listbox.com ([208.210.124.78]:59225 "EHLO
	lollipop.listbox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760698AbYBFAe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 19:34:27 -0500
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by lollipop.listbox.com (Postfix) with ESMTP id 71A6E43576A
	for <git@vger.kernel.org>; Tue,  5 Feb 2008 18:45:48 -0500 (EST)
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id A57E81939F5;
	Tue,  5 Feb 2008 18:44:17 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 8DC9F193B8B;
	Tue,  5 Feb 2008 18:44:12 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72731>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Tue, 5 Feb 2008, Johannes Schindelin wrote:
> ...
>> BTW after the whole series (was too lazy to check the individual 
>> patches), I count one instance in builtin-checkout.c and two in diff-lib.c 
>> where unpack_trees()' return value is not checked.  Is this intended?
>
> ..., but it's probably best to check and 
> exit anyway, if only in the conversion commit. (If we remove the check 
> afterward, there will be a change in the history that documents that we 
> don't need to check)

I think that is a sensible thing to do.
