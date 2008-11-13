From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git ls-files -m --with-tree does double output
Date: Thu, 13 Nov 2008 14:39:46 -0800
Message-ID: <7vk5b7fdxp.fsf@gitster.siamese.dyndns.org>
References: <37512.N1gUGH5fRhE=.1226613228.squirrel@webmail.hotelhot.dk>
 <7vod0jfe51.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: "Anders Melchiorsen" <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Thu Nov 13 23:41:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0ksf-0001Rc-KV
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 23:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbYKMWk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 17:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752060AbYKMWk1
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 17:40:27 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63039 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbYKMWk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 17:40:26 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D93607D56D;
	Thu, 13 Nov 2008 17:40:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9F70A7D569; Thu,
 13 Nov 2008 17:39:53 -0500 (EST)
In-Reply-To: <7vod0jfe51.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 13 Nov 2008 14:35:22 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 107CBB84-B1D4-11DD-B795-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100924>

Junio C Hamano <gitster@pobox.com> writes:

> What's the use case of using -m together with --with-tree to begin with?
> I think the only sensible other option that makes sense with --with-tree
> is --error-unmatch.

The reason I ask this question is that the cleanest fix to the issue might
turn out to be to forbid that combination of the options, if it turns out
that it does not make any sense.
