From: Junio C Hamano <gitster@pobox.com>
Subject: Re: orthogonal cases of log --date option
Date: Thu, 05 Mar 2009 22:50:42 -0800
Message-ID: <7vmybzw3el.fsf@gitster.siamese.dyndns.org>
References: <buo8wnnrpcf.fsf@dhlpc061.dev.necel.com>
 <7vtz6bdmfi.fsf@gitster.siamese.dyndns.org>
 <20090305104304.GA17760@coredump.intra.peff.net>
 <76718490903051304j6d8138f7qa5492ac15edd6460@mail.gmail.com>
 <20090305211120.GB20157@coredump.intra.peff.net>
 <7vy6vjy5js.fsf@gitster.siamese.dyndns.org>
 <20090306052318.GB3426@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 06 07:52:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfTvC-0005DM-BM
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 07:52:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756857AbZCFGu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 01:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756514AbZCFGu6
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 01:50:58 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60500 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756908AbZCFGu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 01:50:57 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4967B9F51C;
	Fri,  6 Mar 2009 01:50:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 724139F512; Fri,
  6 Mar 2009 01:50:44 -0500 (EST)
In-Reply-To: <20090306052318.GB3426@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 6 Mar 2009 00:23:18 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 23722EDC-0A1B-11DE-8BBC-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112392>

Jeff King <peff@peff.net> writes:

> Because from the user's perspective --foo={bar,baz,bleep} is about
> selecting exactly one of {bar,baz,bleep}.

I do not feel very strongly about this either way, and without any prior
end user "Huh?" input, I would probably have argued like you myself, but
I saw the original message from Miles about giving more than one --date
and getting perplexed to see that it did not work, so...

I am not likely to use --tz=Indian/Christmas myself; GMT and local might
however be useful in some situations, though.
