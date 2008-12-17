From: Junio C Hamano <gitster@pobox.com>
Subject: Re: white spaces in a patch
Date: Tue, 16 Dec 2008 23:34:53 -0800
Message-ID: <7vej07p84i.fsf@gitster.siamese.dyndns.org>
References: <dac45060812162331k19272488r4e95e0555e7a6db9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Mark Ryden" <markryde@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 08:36:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCqxB-0008O4-IV
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 08:36:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbYLQHfC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 02:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbYLQHfC
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 02:35:02 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35664 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548AbYLQHfA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 02:35:00 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 296421A756;
	Wed, 17 Dec 2008 02:34:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1EFB91A753; Wed,
 17 Dec 2008 02:34:55 -0500 (EST)
In-Reply-To: <dac45060812162331k19272488r4e95e0555e7a6db9@mail.gmail.com>
 (Mark Ryden's message of "Wed, 17 Dec 2008 09:31:06 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 354894D0-CC0D-11DD-8CDB-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103309>

"Mark Ryden" <markryde@gmail.com> writes:

> 1) Is there a way to check whether there are white spaces in this
> file without running git-apply?

"sed -n -e '/^+.*[ 	]$/p' patch.txt" perhaps?

> 2) Is there a way to get some messages about that there are white spaces
> when creating a git patch?

Doesn't "git diff" highlight whitespace errors?  That way, you can catch
errors  before you make a commit that has them.
