From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Lightweight tag ?
Date: Sun, 11 Jan 2009 13:04:30 -0800
Message-ID: <7v63klsgf5.fsf@gitster.siamese.dyndns.org>
References: <38b2ab8a0901111044x5db21d74i25ff7a26bb702a5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Francis Moreau" <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 11 22:06:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM7W0-0006Jh-4v
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 22:06:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071AbZAKVEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 16:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbZAKVEj
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 16:04:39 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61345 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbZAKVEj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 16:04:39 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4376D1C44C;
	Sun, 11 Jan 2009 16:04:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4056B1C42E; Sun,
 11 Jan 2009 16:04:31 -0500 (EST)
In-Reply-To: <38b2ab8a0901111044x5db21d74i25ff7a26bb702a5d@mail.gmail.com>
 (Francis Moreau's message of "Sun, 11 Jan 2009 19:44:30 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 746B1D34-E023-11DD-BB4B-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105228>

"Francis Moreau" <francis.moro@gmail.com> writes:

> My problem is that I don't see their point !
>
> They behave the same way like the annotated tags: when pushing to a
> repo the lightweight tags are pushed as well, and pulling from a repo
> with lightweight tags give the same results (all of this with the
> --tags switch).

Don't use explicit --tags blindly.  It says "no matter what kind of tag,
transfer everything under refs/tags".  Otherwise you won't see a
difference.
