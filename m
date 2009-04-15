From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch: Strip usernames from url's before storing them
Date: Wed, 15 Apr 2009 10:19:22 -0700
Message-ID: <7viql5vnqd.fsf@gitster.siamese.dyndns.org>
References: <1239797816-24582-1-git-send-email-ae@op5.se>
 <49E5D372.1090504@drmicha.warpmail.net> <49E5E8C5.4050501@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Apr 15 19:21:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu8nI-0003b0-72
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 19:21:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753024AbZDORTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 13:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752796AbZDORTa
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 13:19:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33486 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752762AbZDORTa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 13:19:30 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0F2BEAAD33;
	Wed, 15 Apr 2009 13:19:29 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AB6E4AAD2D; Wed,
 15 Apr 2009 13:19:24 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 93B80136-29E1-11DE-A377-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116632>

Andreas Ericsson <ae@op5.se> writes:

> The reason for this patch is that we published some repositories publicly
> a week or two ago and one such malicious person started attacking all our
> public servers with the usernames found in the commit messages.

Interesting.  Do you also worry about the names on committer and author
lines?
