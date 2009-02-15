From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/5] t3301: use test_must_fail instead of !
Date: Sat, 14 Feb 2009 23:52:59 -0800
Message-ID: <7vvdrcnnl0.fsf@gitster.siamese.dyndns.org>
References: <200902142056.42198.trast@student.ethz.ch>
 <8c50889d27e5baec1cbbd9a5775fa80b986c6df6.1234642638.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Feb 15 08:54:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYbpm-000552-Eg
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 08:54:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbZBOHxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 02:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbZBOHxI
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 02:53:08 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52137 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718AbZBOHxH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 02:53:07 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 50EF12B2A7;
	Sun, 15 Feb 2009 02:53:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 971182B287; Sun,
 15 Feb 2009 02:53:01 -0500 (EST)
In-Reply-To: <8c50889d27e5baec1cbbd9a5775fa80b986c6df6.1234642638.git.trast@student.ethz.ch> (Thomas Rast's message of "Sat, 14 Feb 2009 21:23:24 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AD783472-FB35-11DD-9FE3-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109971>

Thomas Rast <trast@student.ethz.ch> writes:

> +	MSG=3 test_must_fail git notes edit

test_must_fail is a shell function, and we have precedence 2d60615 (tests:
Avoid single-shot environment export for shell function invocation,
2009-01-26) to avoid this construct.
