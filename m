From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git 1.6.1-rc4 testing dependency
Date: Mon, 22 Dec 2008 12:50:49 -0800
Message-ID: <7vzliogcie.fsf@gitster.siamese.dyndns.org>
References: <20081222100637.716c5b8a@montecarlo.grandprix.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter van der Does <peter@ourvirtualhome.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 21:52:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LErl7-0002TL-1J
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 21:52:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754259AbYLVUuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 15:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754239AbYLVUuy
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 15:50:54 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355AbYLVUuy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 15:50:54 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E3B6B8911A;
	Mon, 22 Dec 2008 15:50:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3391789118; Mon,
 22 Dec 2008 15:50:51 -0500 (EST)
In-Reply-To: <20081222100637.716c5b8a@montecarlo.grandprix.int> (Peter van
 der Does's message of "Mon, 22 Dec 2008 10:06:37 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3967CF3E-D06A-11DD-97DB-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103767>

Peter van der Does <peter@ourvirtualhome.com> writes:

> On my building machine I don't have any locales installed, making the
> LC_ALL=C.
> Not everybody will have this locale installed nor would they want it
> installed on their machines.

I think some tests play nicer than this one and skip tests that want UTF-8
locales; you may want to teach this script the same trick.

In the meantime, perhaps "GIT_SKIP_TETS='t9129' make test" would help.
