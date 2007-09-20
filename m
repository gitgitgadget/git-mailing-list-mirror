From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [git-p4] Detect exec bit in more cases.
Date: Thu, 20 Sep 2007 15:53:52 -0700
Message-ID: <7vodfxj6db.fsf@gitster.siamese.dyndns.org>
References: <119022570352-git-send-email-git@davidb.org>
	<200709192103.53526.simon@lst.de>
	<20070920151637.GA26873@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Simon Hausmann <simon@lst.de>
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Fri Sep 21 00:54:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYUuy-0008Og-5e
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 00:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbXITWyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 18:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbXITWyE
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 18:54:04 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:50681 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbXITWyD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 18:54:03 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id BA09C138E25;
	Thu, 20 Sep 2007 18:54:16 -0400 (EDT)
In-Reply-To: <20070920151637.GA26873@old.davidb.org> (David Brown's message of
	"Thu, 20 Sep 2007 08:16:37 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58815>

David Brown <git@davidb.org> writes:

> On Wed, Sep 19, 2007 at 09:03:50PM +0200, Simon Hausmann wrote:
>>On Wednesday 19 September 2007 20:15:03 David Brown wrote:
>
>>> git-p4 was missing the execute bit setting if the file had other attribute
>>> bits set.
>>> ---
>
>>I'm fine with this, so unless you find a better way:
>>
>>Acked-By: Simon Hausmann <simon@lst.de>
>
> I sent out an improved version of this patch yesterday
> <1190232768445-git-send-email-git@davidb.org> that I'd like to get
> approved.  I guess I'm not quite sure what happens at this point with a
> patch.

I still have that *768445* message as "the last one proposed as
better than previous ones" in my mbox.

Simon?
