From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: Produce better output with --inline or
 --attach
Date: Wed, 30 Jul 2008 11:52:59 -0700
Message-ID: <7vmyjz5hmc.fsf@gitster.siamese.dyndns.org>
References: <20080730052401.GC4034@sigill.intra.peff.net>
 <1217396973-82246-1-git-send-email-kevin@sb.org>
 <alpine.LSU.1.00.0807301624410.3486@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Ballard <kevin@sb.org>, git@vger.kernel.org, peff@peff.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 30 20:54:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOGoO-0000Wu-Hp
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 20:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759489AbYG3SxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 14:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759182AbYG3SxK
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 14:53:10 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53967 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757697AbYG3SxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 14:53:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 79C1343BC2;
	Wed, 30 Jul 2008 14:53:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 07DF543BC1; Wed, 30 Jul 2008 14:53:01 -0400 (EDT)
In-Reply-To: <alpine.LSU.1.00.0807301624410.3486@wbgn129.biozentrum.uni-wuerzburg.de>
 (Johannes Schindelin's message of "Wed, 30 Jul 2008 16:29:39 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BF74B4DA-5E68-11DD-90BA-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90831>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> The second change is to always write the line termination character 
>> (default: newline) even when using --inline or --attach. This is simply 
>> to improve the aesthetics of the resulting message. When using --inline 
>> an email client should render the resulting message identically to the 
>> non-inline version. And when using --attach this adds a blank line 
>> preceding the attachment in the email, which is visually attractive.
>
> It appears that your patch has one uncontroversial and one controversial 
> part, then.

Could you elaborate what's controversial about this?
