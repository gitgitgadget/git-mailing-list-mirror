From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Install man3 manpages to $PREFIX/share/man/man3 even for site installs
Date: Thu, 23 Aug 2007 01:11:38 -0700
Message-ID: <7vbqcyvfet.fsf@gitster.siamese.dyndns.org>
References: <11875945951398-git-send-email-madduck@madduck.net>
	<11875945952624-git-send-email-madduck@madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "martin f. krafft" <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Thu Aug 23 10:11:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO7nB-0004OY-Jr
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 10:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755552AbXHWILo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 04:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755455AbXHWILn
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 04:11:43 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:57949 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbXHWILm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 04:11:42 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 5004A12330D;
	Thu, 23 Aug 2007 04:12:02 -0400 (EDT)
In-Reply-To: <11875945952624-git-send-email-madduck@madduck.net> (martin
	f. krafft's message of "Mon, 20 Aug 2007 09:23:15 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56471>

Sorry for keeping you waiting for quite a while.  I've had a
chance to test building an RPM tonight, and this does not seem
to affect the output (the perl manpage is already installed in
/usr/share/man/man3), so I'd say this is probably safe to
apply.

For people who do private installs, the path is changed from
$prefix/man/man3/ to $prefix/share/man/man3 (where $prefix is
typically set to $HOME), but all the other manual pages are
installed in $prefix/share/man/man[1-7] anyway, so this change
cannot hurt.
