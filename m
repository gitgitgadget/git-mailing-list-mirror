From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix "git push $there +HEAD"
Date: Wed, 20 Feb 2008 10:16:13 -0800
Message-ID: <7vwsoz5w9e.fsf@gitster.siamese.dyndns.org>
References: <7vprurc3n8.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0802201226560.19024@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Feb 20 19:17:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRtVS-0008DE-NU
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 19:17:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756714AbYBTSQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 13:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756517AbYBTSQc
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 13:16:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42256 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756234AbYBTSQb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 13:16:31 -0500
Received: from .pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C9CED2D79;
	Wed, 20 Feb 2008 13:16:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 D05722D75; Wed, 20 Feb 2008 13:16:20 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0802201226560.19024@iabervon.org> (Daniel
 Barkalow's message of "Wed, 20 Feb 2008 12:59:24 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74529>

Daniel Barkalow <barkalow@iabervon.org> writes:

> ..., I think it would be better to have "<src>" 
> treated as "<src>:<resolve of <src>>" instead of as "<src>:<src>" in 
> match_refs(); and not do any special rewriting on the front end.

Wonderful.  That's hooking at the right layer.
