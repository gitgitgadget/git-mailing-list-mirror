From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] add basic http clone/fetch tests
Date: Sun, 15 Feb 2009 00:01:07 -0800
Message-ID: <7vmyconn7g.fsf@gitster.siamese.dyndns.org>
References: <20090215060815.GA7473@coredump.intra.peff.net>
 <20090215061217.GB30414@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 15 09:02:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYbxc-0006Mz-Hm
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 09:02:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbZBOIBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 03:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbZBOIBQ
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 03:01:16 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35588 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbZBOIBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 03:01:16 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2F81A996C0;
	Sun, 15 Feb 2009 03:01:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 99CBA996BF; Sun,
 15 Feb 2009 03:01:09 -0500 (EST)
In-Reply-To: <20090215061217.GB30414@coredump.intra.peff.net> (Jeff King's
 message of "Sun, 15 Feb 2009 01:12:17 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D16EF324-FB36-11DD-B8E1-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109973>

Jeff King <peff@peff.net> writes:

> ... Of
> course, one must use GIT_TEST_HTTPD to enable them. Junio, is that part
> of your usual integration testing?

No.  I do not run server tests myself.  I could enable it for tests run on
my private machine, but the final pre-pushout testing don at k.org is more
or less unattended, and it is a shared machine where I do not want to run
server-ish tests.
