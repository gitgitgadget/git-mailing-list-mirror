From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] init: handle empty "template" parameter, was Re: fetch
 refspec foo/* matches foo*
Date: Sun, 27 Jul 2008 23:13:37 -0700
Message-ID: <7vljzmv8mm.fsf@gitster.siamese.dyndns.org>
References: <1216854795-51155-1-git-send-email-lee.marlow@gmail.com>
 <1216858043-53646-1-git-send-email-lee.marlow@gmail.com>
 <20080725204051.GB23202@spearce.org>
 <7v1w1hsmnc.fsf@gitster.siamese.dyndns.org>
 <20080726082405.GA10104@sigill.intra.peff.net>
 <20080726083356.GB10104@sigill.intra.peff.net>
 <alpine.DEB.1.00.0807261511490.26810@eeepc-johanness>
 <20080728060204.GC7294@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 28 08:14:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNM0M-0006TT-8w
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 08:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbYG1GNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 02:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbYG1GNp
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 02:13:45 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63111 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbYG1GNp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 02:13:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4A2D63F398;
	Mon, 28 Jul 2008 02:13:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 674BF3F396; Mon, 28 Jul 2008 02:13:39 -0400 (EDT)
In-Reply-To: <20080728060204.GC7294@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 28 Jul 2008 02:02:04 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5461E13E-5C6C-11DD-9A16-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90414>

Thanks, it seems that I keep forgetting to apply this patch after saying
to myself "Heh, it obviously is the correct thing to do".
