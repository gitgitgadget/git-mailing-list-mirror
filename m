From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] git-am: emit usage when called w/o arguments and
 w/o patch on stdin
Date: Tue, 27 Jan 2009 20:17:29 -0800
Message-ID: <7vhc3kxdwm.fsf@gitster.siamese.dyndns.org>
References: <1233113262-17491-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, sverre@rabbelier.nl
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 05:19:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS1tG-0001Zc-V3
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 05:19:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182AbZA1ERh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 23:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751631AbZA1ERh
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 23:17:37 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59575 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbZA1ERh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 23:17:37 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6EA8194305;
	Tue, 27 Jan 2009 23:17:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E4C3B94304; Tue,
 27 Jan 2009 23:17:30 -0500 (EST)
In-Reply-To: <1233113262-17491-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Tue, 27 Jan 2009 22:27:41 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 97D2DDF8-ECF2-11DD-986E-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107470>

Jay Soffian <jaysoffian@gmail.com> writes:

> +	test $# = 0 && test -t 0 && usage

Sorry to be dense.  Why isn't your patch the above single liner?
