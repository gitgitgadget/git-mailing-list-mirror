From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] git-am: minor cleanups
Date: Tue, 27 Jan 2009 20:18:17 -0800
Message-ID: <7vd4e8xdva.fsf@gitster.siamese.dyndns.org>
References: <1233113262-17491-1-git-send-email-jaysoffian@gmail.com>
 <1233113262-17491-2-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, sverre@rabbelier.nl
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 05:19:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS1u3-0001hi-0K
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 05:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287AbZA1ES1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 23:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752180AbZA1ES0
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 23:18:26 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59806 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702AbZA1ESZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 23:18:25 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1D8D19431E;
	Tue, 27 Jan 2009 23:18:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 17FE794318; Tue,
 27 Jan 2009 23:18:18 -0500 (EST)
In-Reply-To: <1233113262-17491-2-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Tue, 27 Jan 2009 22:27:42 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B4D45EAE-ECF2-11DD-AB8A-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107471>

Jay Soffian <jaysoffian@gmail.com> writes:

> Use "test -t 0" instead of deprecated "tty -s" to detect when stdin is a
> terminal.

Who deprecated it?

Other changes looked sensible, though.
