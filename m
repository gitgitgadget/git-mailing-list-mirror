From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Added --export option to git-send-email.
Date: Fri, 11 Jul 2008 00:03:06 -0700
Message-ID: <7vskugkimt.fsf@gitster.siamese.dyndns.org>
References: <20080710170735.4c5b237a@linux360.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: ryan@michonline.com, git@vger.kernel.org
To: Eduard - Gabriel Munteanu <eduard.munteanu@linux360.ro>
X-From: git-owner@vger.kernel.org Fri Jul 11 09:04:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHCfz-0003pz-Kh
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 09:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054AbYGKHDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 03:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754049AbYGKHDV
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 03:03:21 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33375 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754023AbYGKHDV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 03:03:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EC86C26271;
	Fri, 11 Jul 2008 03:03:15 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id F029A2626F; Fri, 11 Jul 2008 03:03:08 -0400 (EDT)
In-Reply-To: <20080710170735.4c5b237a@linux360.ro>
 (eduard.munteanu@linux360.ro's message of "Thu, 10 Jul 2008 17:07:35 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6F350E30-4F17-11DD-B162-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88087>

Eduard - Gabriel Munteanu <eduard.munteanu@linux360.ro> writes:

> This option allows the user to process patches with git-send-email and then
> import them into an email client, without having to send them directly. The
> output format is mbox.

Input format is also mbox, so an obvious question is "why?"
