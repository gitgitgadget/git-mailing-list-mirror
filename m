From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git apply vs. renamed files index mismatch
Date: Mon, 08 Sep 2008 17:55:47 -0700
Message-ID: <7vabeicf3g.fsf@gitster.siamese.dyndns.org>
References: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com>
 <1220900995-11928-2-git-send-email-becky.bruce@freescale.com>
 <48C57A92.6060608@freescale.com>
 <20080908212717.GA21338@oksana.dev.rtsoft.ru>
 <48C59B71.3040902@freescale.com> <20080908215441.GA924@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Wood <scottwood@freescale.com>,
	Becky Bruce <becky.bruce@freescale.com>,
	linuxppc-dev@ozlabs.org, git@vger.kernel.org
To: avorontsov@ru.mvista.com
X-From: git-owner@vger.kernel.org Tue Sep 09 02:57:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcrXj-00059Z-GJ
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 02:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754852AbYIIA4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 20:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754751AbYIIA4F
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 20:56:05 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50716 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076AbYIIA4E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 20:56:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 21ED3794D7;
	Mon,  8 Sep 2008 20:56:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 99E16794D1; Mon,  8 Sep 2008 20:55:50 -0400 (EDT)
In-Reply-To: <20080908215441.GA924@oksana.dev.rtsoft.ru> (Anton Vorontsov's
 message of "Tue, 9 Sep 2008 01:54:41 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 13FFF5B2-7E0A-11DD-964B-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95324>

Anton Vorontsov <avorontsov@ru.mvista.com> writes:

> ..rename and changes ideally go in separate patches.
>
> IIRC this also helps git to track renames (it can easily compare
> hashes instead of guessing).

It does not help much, and it is frowned upon (at least by well educated
users in git circle) because such a split patch hurts reviewability.
