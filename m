From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: ignore --depth when cloning locally (implicitly
 --local)
Date: Thu, 26 Feb 2009 14:45:42 -0800
Message-ID: <7v8wnsrf55.fsf@gitster.siamese.dyndns.org>
References: <cover.1235672273u.git.johannes.schindelin@gmx.de>
 <1f63785d96d243ff19a063f684abbbe46cafc075.1235672273u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 26 23:47:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lcp0q-0000bP-7E
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 23:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759662AbZBZWpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 17:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757109AbZBZWpt
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 17:45:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46746 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759445AbZBZWpt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 17:45:49 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B74441FE1;
	Thu, 26 Feb 2009 17:45:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 399731FE0; Thu,
 26 Feb 2009 17:45:44 -0500 (EST)
In-Reply-To: <1f63785d96d243ff19a063f684abbbe46cafc075.1235672273u.git.johannes.schindelin@gmx.de> (Johannes Schindelin's message of "Thu, 26 Feb 2009 19:20:19 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 351C61EE-0457-11DE-9918-8D02133F2F75-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111608>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> When cloning locally, we default to --local, as it makes the whole
> operation fast and efficient.
>
> As the most common intent of cloning with a --depth parameter is to
> save space, and --local saves space more than --depth ever can,
> warn the user and ignore the --depth parameter when cloning locally.
>
> Should --depth be desired, the user can always force proper cloning
> by using a file:// URL.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Makes sense.  I'm inclined to apply this as a "fix" before 1.6.2, but I
cannot exactly say what we are fixing.  User's expectations?
