From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Yet another builtin-fetch round
Date: Wed, 19 Sep 2007 21:08:43 -0700
Message-ID: <7v6426m110.fsf@gitster.siamese.dyndns.org>
References: <20070919044923.GP3099@spearce.org>
	<Pine.LNX.4.64.0709192233360.21941@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 06:08:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYDLS-00041U-RE
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 06:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbXITEIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 00:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbXITEIu
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 00:08:50 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:34326 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbXITEIt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 00:08:49 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 81333136D16;
	Thu, 20 Sep 2007 00:09:07 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0709192233360.21941@iabervon.org> (Daniel
	Barkalow's message of "Wed, 19 Sep 2007 22:40:30 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58751>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Wed, 19 Sep 2007, Shawn O. Pearce wrote:
>
>> Another short series for db/fetch-pack, still in pu.  Aside from
>> optimizing the pipeline on the native transport (so we only invoke
>> the remote process we need once vs. twice) I'm actually now quite
>> comfortable with this whole series and think it is ready for next.
>
> While it's still in pu, should these series of corrections be amended into 
> the original series (for the ones that correct new code)? Most of the 
> before-fixing states aren't worth saving as project history.

Yeah, I was wondering if that is a sane thing to do.  It is
merely additional work to arrive at the same tree state, but
might be a good investment in the longer term.
