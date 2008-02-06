From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/9] Use git diff instead of diff in t7201
Date: Tue, 05 Feb 2008 21:21:48 -0800
Message-ID: <7v3as664nn.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802041336030.13593@iabervon.org>
	<alpine.LSU.1.00.0802050139470.8543@racer.site>
	<alpine.LNX.1.00.0802042152560.13593@iabervon.org>
	<7v1w7r7yv0.fsf@gitster.siamese.dyndns.org>
	<alpine.LNX.1.00.0802052011290.13593@iabervon.org>
	<7vr6fq6di0.fsf@gitster.siamese.dyndns.org>
	<alpine.LNX.1.00.0802052306450.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 06:22:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMck8-0002va-K0
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 06:22:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbYBFFWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 00:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbYBFFWJ
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 00:22:09 -0500
Received: from rune.pobox.com ([208.210.124.79]:52944 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751161AbYBFFWI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 00:22:08 -0500
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 566631901B0;
	Wed,  6 Feb 2008 00:22:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 7E9B2192393;
	Wed,  6 Feb 2008 00:22:22 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0802052306450.13593@iabervon.org> (Daniel
	Barkalow's message of "Tue, 5 Feb 2008 23:30:00 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72755>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Tue, 5 Feb 2008, Junio C Hamano wrote:
> ...
>> My preference is NEVER using "git diff" when comparing expected
>> result and the actual output from git.  When "git diff" has
>> breakage, it would break unrelated tests and make debugging
>> needlessly harder.
>
> Certainly, although we seem to do a lousy job of ordering tests currently 
> such that the tests that fail are the ones for the thing that's broken;

Yeah, Porcelains have become we take for granted ;-).
