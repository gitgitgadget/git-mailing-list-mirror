From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible bug: "git log" ignores "--encoding=UTF-8" option if
 --pretty=format:%e%n%s%n is used
Date: Wed, 12 Nov 2008 17:38:47 -0800
Message-ID: <7vvdusjtg8.fsf@gitster.siamese.dyndns.org>
References: <85647ef50811111112o5449c12elfc571e46e607cfd0@mail.gmail.com>
 <20081112104318.GA20120@coredump.intra.peff.net>
 <85647ef50811120311q7bc5451x7c084fd2a7864177@mail.gmail.com>
 <20081112112654.GA20640@coredump.intra.peff.net>
 <85647ef50811120508j5074f892p1e2a95acfae8c0a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org
To: "Constantine Plotnikov" <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 02:40:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0RC8-0003pm-Jj
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 02:40:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683AbYKMBjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 20:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbYKMBjI
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 20:39:08 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54731 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbYKMBjH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 20:39:07 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E0E15168CA;
	Wed, 12 Nov 2008 20:39:02 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DBD9D168BF; Wed, 12 Nov 2008 20:38:49 -0500 (EST)
In-Reply-To: <85647ef50811120508j5074f892p1e2a95acfae8c0a8@mail.gmail.com>
 (Constantine Plotnikov's message of "Wed, 12 Nov 2008 16:08:38 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D9EC0BB6-B123-11DD-80E1-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100840>

"Constantine Plotnikov" <constantine.plotnikov@gmail.com> writes:

> BTW for some reason --pretty=raw is affected by encoding option on the
> command line.

Unfortunately, that is what you get for reading from a Porcelain output,
which is meant for, and are subject to improvement for, human consumption.

If you want bit-for-bit information, you can always ask "git cat-file".
