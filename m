From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] filter-branch: use --simplify-merges
Date: Mon, 11 Aug 2008 23:59:32 -0700
Message-ID: <7vsktara5n.fsf@gitster.siamese.dyndns.org>
References: <7viqub9dzi.fsf@gitster.siamese.dyndns.org>
 <7vljz3t2ts.fsf@gitster.siamese.dyndns.org>
 <7v7iant1yx.fsf@gitster.siamese.dyndns.org>
 <200808120747.22228.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jan Wielemaker <J.Wielemaker@uva.nl>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 12 09:00:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSns8-00046L-Uu
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 09:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbYHLG7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 02:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbYHLG7k
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 02:59:40 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61529 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbYHLG7j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 02:59:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 61B2556F2E;
	Tue, 12 Aug 2008 02:59:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 656B056F2D; Tue, 12 Aug 2008 02:59:34 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3B50FB54-683C-11DD-A9BE-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92073>

Thomas Rast <trast@student.ethz.ch> writes:

> Junio C Hamano wrote:
>>  ... 
>> Nevermind.  You based this on top of the "fix ancestor discovery" patch.
>>
>> I'll squash these two and queue them in 'pu' for now.
>
> Please don't.  I'm still convinced the "fix ancestor discovery" is a
> fix to current code that works independent of --simplify-merges.  If
> you squash them, it cannot go into a release before --simplify-merges
> even if I manage to convince Dscho of this.

Anything parked in 'pu' is a fair game for replacement later, so please
send a replacement series and tell me to drop the previous ones from 'pu'.
