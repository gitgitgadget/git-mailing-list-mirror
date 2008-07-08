From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [take 2] revision parsing made incremental
Date: Tue, 08 Jul 2008 15:57:27 -0700
Message-ID: <7vk5fwq90o.fsf@gitster.siamese.dyndns.org>
References: <1215523175-28436-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@linux-foundation.org, peff@peff.net,
	Johannes.Schindelin@gmx.de
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Jul 09 00:58:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGM8w-0002v9-Ie
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 00:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754003AbYGHW5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 18:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753930AbYGHW5o
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 18:57:44 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48516 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871AbYGHW5n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 18:57:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1BDCB15F65;
	Tue,  8 Jul 2008 18:57:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4B84A15F64; Tue,  8 Jul 2008 18:57:35 -0400 (EDT)
In-Reply-To: <1215523175-28436-1-git-send-email-madcoder@debian.org> (Pierre
 Habouzit's message of "Tue, 8 Jul 2008 15:19:32 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 453FF7F2-4D41-11DD-858A-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87805>

Pierre Habouzit <madcoder@debian.org> writes:

> Following Dscho's remarks, I reworked the series to avoid changing
> setup_revisions semantics for now, and only exposed the part that groks
> options (and keep pseudo revision arguments out).
>
> It indeed makes the series smaller, even if the first patch is quite
> long to read, and is just enough for simplifying git-blame in a very
> satisfying way.

All looks good and the result looks much more readable.
Thanks.
