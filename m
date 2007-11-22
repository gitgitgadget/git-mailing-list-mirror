From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Adding push configuration to .git/config
Date: Thu, 22 Nov 2007 00:28:49 -0800
Message-ID: <7v8x4q8z0e.fsf@gitster.siamese.dyndns.org>
References: <20071121105517.GA11875@denkbrett.schottelius.org>
	<7vabp79hjt.fsf@gitster.siamese.dyndns.org>
	<C297CFC3-8DD0-4EEE-8FD3-BF997F6E269A@zib.de>
	<47453551.3060502@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Nico -telmich- Schottelius <nico-linux-git@schottelius.org>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Nov 22 09:29:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv7Qx-0006Dn-FJ
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 09:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbXKVI25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 03:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbXKVI25
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 03:28:57 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:37878 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbXKVI24 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 03:28:56 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 9A86E2FA;
	Thu, 22 Nov 2007 03:29:17 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 1B0D096A9B;
	Thu, 22 Nov 2007 03:29:12 -0500 (EST)
In-Reply-To: <47453551.3060502@op5.se> (Andreas Ericsson's message of "Thu, 22
	Nov 2007 08:52:49 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65753>

Andreas Ericsson <ae@op5.se> writes:

> Steffen Prohaska wrote:
>>
>> On Nov 22, 2007, at 2:48 AM, Junio C Hamano wrote:
>> ...
>>> If we were to do this, it might also make sense to rename the
>>> word 'origin' we use for the default remote name to 'default' or
>>> something.  People with shared repository workflow would fetch
>>> from one repository and push back to the same repository, so the
>>> distinction would not matter, but for others who need something
>>> like you suggest, the default repository for fetching and
>>> pushing are different, and while you may still consider where
>>> you fetch from your 'origin', where you push into is not your
>>> 'origin' anymore.
>>
>> I like this idea.
>
> I don't. It's troublesome enough to try to teach the finer points
> of git to my co-workers without different defaults between versions.

I don't like the s/origin/default/ part either, which was the
reason I said "it might".  That would be what I would have done
if I were doing git from scratch right now.
