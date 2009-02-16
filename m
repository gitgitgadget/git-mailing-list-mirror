From: Junio C Hamano <gitster@pobox.com>
Subject: Re: disallowing push to currently checked-out branch
Date: Mon, 16 Feb 2009 00:51:49 -0800
Message-ID: <7veixybw7u.fsf@gitster.siamese.dyndns.org>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org>
 <20090215232013.GA11543@zakalwe.fi>
 <20090216000443.GB3503@coredump.intra.peff.net>
 <alpine.DEB.1.10.0902151727330.14911@asgard.lang.hm>
 <alpine.DEB.1.10.0902151738450.14911@asgard.lang.hm>
 <alpine.LNX.1.00.0902160322530.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: david@lang.hm, Jeff King <peff@peff.net>,
	Heikki Orsila <shdl@zakalwe.fi>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Feb 16 09:53:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYzEH-0005pq-3F
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 09:53:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754649AbZBPIwB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 03:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754582AbZBPIwA
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 03:52:00 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49406 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753756AbZBPIwA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 03:52:00 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 959709AECD;
	Mon, 16 Feb 2009 03:51:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 870549AECC; Mon,
 16 Feb 2009 03:51:52 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0902160322530.19665@iabervon.org> (Daniel
 Barkalow's message of "Mon, 16 Feb 2009 03:33:29 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1279320A-FC07-11DD-B4C5-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110148>

Daniel Barkalow <barkalow@iabervon.org> writes:

> In fact, if you expect to be pushing to a non-bare repository, you
> probably want to have HEAD contain the actual commit currently checked
> out (instead of a reference to externally mutable storage), which you
> can do with "git checkout refs/heads/master".

"git checkout master^0" is shorter ;-)

For people who do not follow the git list regularly, a "HEAD contain the
actual commit" is often called "detached".
