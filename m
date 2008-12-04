From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow passing of --directory to git-am.
Date: Thu, 04 Dec 2008 11:27:35 -0800
Message-ID: <7vhc5jeo60.fsf@gitster.siamese.dyndns.org>
References: <49382612.3010207@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Thu Dec 04 20:29:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8Jsj-0005Q3-Ir
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 20:29:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788AbYLDT1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 14:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753906AbYLDT1p
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 14:27:45 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54516 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753765AbYLDT1o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 14:27:44 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5CA7284481;
	Thu,  4 Dec 2008 14:27:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0BAD58447F; Thu,
  4 Dec 2008 14:27:38 -0500 (EST)
In-Reply-To: <49382612.3010207@fs.ei.tum.de> (Simon Schubert's message of
 "Thu, 04 Dec 2008 19:48:50 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9EC59B2A-C239-11DD-91D9-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102359>

Simon 'corecode' Schubert <corecode@fs.ei.tum.de> writes:

> We need to play some shell tricks to be able to pass directory names
> which contain spaces and/or quotes.

There already was an earlier attempt for this feature by Kevin Ballard,
which had issues I pointed out:

  http://thread.gmane.org/gmane.comp.version-control.git/94335/focus=94456

The patch was carried for a few weeks in 'pu' but was dropped due to lack
of follow-up updates.

Does your version address the issues Kevin's one had?
