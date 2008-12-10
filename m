From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] modify/delete conflict resolution overwrites untracked
 file
Date: Wed, 10 Dec 2008 12:51:59 -0800
Message-ID: <7vzlj3ycr4.fsf@gitster.siamese.dyndns.org>
References: <20081210201259.GA12928@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Dec 10 21:53:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAW3q-00085T-0t
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 21:53:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753737AbYLJUwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 15:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752700AbYLJUwJ
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 15:52:09 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45638 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753641AbYLJUwI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 15:52:08 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5F0281892C;
	Wed, 10 Dec 2008 15:52:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 66F0818929; Wed,
 10 Dec 2008 15:52:01 -0500 (EST)
In-Reply-To: <20081210201259.GA12928@localhost> (Clemens Buchacher's message
 of "Wed, 10 Dec 2008 21:12:59 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 683B4EA2-C6FC-11DD-BC54-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102719>

Clemens Buchacher <drizzd@aon.at> writes:

> If it's a regression, it dates far back, since 1.5.0 fails as well.

A good lit(h)mus test to see if it is a regression or just a plain bug in
the recursive strategy would be to see what 'resolve' strategy does
(replace "merge" with "merge -s resolve" in your test).
