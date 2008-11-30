From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Detecting HEAD more reliably while cloning
Date: Sun, 30 Nov 2008 02:04:55 -0800
Message-ID: <7vabbhttq0.fsf@gitster.siamese.dyndns.org>
References: <1228039053-31099-1-git-send-email-gitster@pobox.com>
 <1228039053-31099-2-git-send-email-gitster@pobox.com>
 <1228039053-31099-3-git-send-email-gitster@pobox.com>
 <1228039053-31099-4-git-send-email-gitster@pobox.com>
 <1228039053-31099-5-git-send-email-gitster@pobox.com>
 <1228039053-31099-6-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Nov 30 11:06:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6jCG-0002Yf-4t
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 11:06:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbYK3KFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 05:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbYK3KFO
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 05:05:14 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41693 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbYK3KFN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 05:05:13 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D43D9824CF;
	Sun, 30 Nov 2008 05:05:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 97E75824CE; Sun,
 30 Nov 2008 05:04:56 -0500 (EST)
In-Reply-To: <1228039053-31099-6-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Sun, 30 Nov 2008 01:57:33 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 60D82D4E-BEC6-11DD-9763-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101959>

You may have noticed that the new git-send-email reversed the order of six
patch files (one cover and five patches) I gave from the command line.
Please consider this series as a bug report ;-)

I think the bug is that "pop @ARGV" should read "shift @ARGV" or something
silly and trivial like that, but it is getting late, so I won't debug
tonight.
