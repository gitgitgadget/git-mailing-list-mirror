From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Add "partial commit" tests during a conflicted merge
Date: Thu, 22 Jan 2009 23:39:39 -0800
Message-ID: <7vskna1nes.fsf@gitster.siamese.dyndns.org>
References: <4978202C.3090703@viscovery.net>
 <alpine.DEB.2.00.0901211549070.15860@vellum.laroia.net>
 <49779521.9040208@drmicha.warpmail.net>
 <c1a864630901211346j4b702fb3tcc5a098ed7e1541d@mail.gmail.com>
 <20090123094509.6117@nanako3.lavabit.com>
 <7viqo64kfo.fsf@gitster.siamese.dyndns.org>
 <7vbpty4kby.fsf_-_@gitster.siamese.dyndns.org>
 <49796D0C.5070408@viscovery.net> <7vab9i331g.fsf@gitster.siamese.dyndns.org>
 <4979727F.80007@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Nathan Yergler <nathan@creativecommons.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Asheesh Laroia <asheesh@asheesh.org>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jan 23 08:41:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQGfE-0002Nq-FH
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 08:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363AbZAWHjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 02:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753043AbZAWHjv
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 02:39:51 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37165 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753013AbZAWHjv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 02:39:51 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1AD3A9342F;
	Fri, 23 Jan 2009 02:39:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 257CC9342C; Fri,
 23 Jan 2009 02:39:40 -0500 (EST)
In-Reply-To: <4979727F.80007@viscovery.net> (Johannes Sixt's message of "Fri,
 23 Jan 2009 08:32:15 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0362978C-E921-11DD-9B80-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106850>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Read again what I said: 'file' is the *ONLY* file that is different from
> HEAD. Why should an explicit --only not work in this case?

I know what you said.

If you study the codepath, the code does not know nor care if 'file' is
the only one or if there are other changed paths.

Too much additional code is needed and for too little gain.
