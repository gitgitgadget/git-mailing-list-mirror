From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Modify description file to say what this file is
Date: Tue, 17 Feb 2009 16:16:36 -0800
Message-ID: <7v63j838gr.fsf@gitster.siamese.dyndns.org>
References: <200902171012.06176.johnflux@gmail.com>
 <7vvdr852nj.fsf@gitster.siamese.dyndns.org>
 <43d8ce650902171531r47bd79cco1524ec883e4c6114@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 01:18:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZa8j-0005zz-5o
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 01:18:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbZBRAQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 19:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbZBRAQp
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 19:16:45 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53265 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbZBRAQp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 19:16:45 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B65042B5AB;
	Tue, 17 Feb 2009 19:16:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id ED9F22B5A7; Tue,
 17 Feb 2009 19:16:37 -0500 (EST)
In-Reply-To: <43d8ce650902171531r47bd79cco1524ec883e4c6114@mail.gmail.com>
 (John Tapsell's message of "Wed, 18 Feb 2009 08:31:08 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6AD1FAFE-FD51-11DD-8F99-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110484>

John Tapsell <johnflux@gmail.com> writes:

> 2009/2/18 Junio C Hamano <gitster@pobox.com>:
>
> Btw, google seems to show other programs using the description file,
> not just gitweb.  How about changing it to "Unnamed repository: edit
> the file 'description' to name the repository" ?

Sure.

I also think "edit this file 'description' to name..." (not "the", but
"this") would give a bit more hint to a user with a better intuition that
the message is not something that is given by an individual program
(e.g. gitweb or the sample hook) but is a product of catting a file that
exists somewhere in the repository in question, and may reduce unnecessary
requests for help saying "The program tells me to edit 'description' file,
but where should I *create* one?"
