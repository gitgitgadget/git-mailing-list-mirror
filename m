From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] builtin-apply: use warning() instead of
 fprintf(stderr, "warning: ")
Date: Thu, 19 Feb 2009 22:11:24 -0800
Message-ID: <7viqn5iqnn.fsf@gitster.siamese.dyndns.org>
References: <200902190736.49161.johnflux@gmail.com>
 <20090219081725.GB7774@coredump.intra.peff.net>
 <20090219120708.GM4371@genesis.frugalware.org>
 <20090219122104.GA4602@sigill.intra.peff.net>
 <4f61642d10063adbff86094e91b1b6e90efabe8e.1235047192.git.vmiklos@frugalware.org> <20090220030245.GC22419@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 20 07:13:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaOdB-0005M8-Dl
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 07:13:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbZBTGLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 01:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752331AbZBTGLd
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 01:11:33 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54073 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626AbZBTGLd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 01:11:33 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C5E5C9BC82;
	Fri, 20 Feb 2009 01:11:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4D5879BC81; Fri,
 20 Feb 2009 01:11:26 -0500 (EST)
In-Reply-To: <20090220030245.GC22419@coredump.intra.peff.net> (Jeff King's
 message of "Thu, 19 Feb 2009 22:02:45 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 51823602-FF15-11DD-A009-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110801>

Jeff King <peff@peff.net> writes:

> Other than that, these all look pretty straightforward. Probably the
> shell scripts should be switched to match, too. But it would be nice to
> hear from Junio first that this cleanup is even desired (so you don't
> waste time).

I think it is a good thing to do.  If the pre-release-freeze is a good
time to do so it is a different matter.  A good way to judge would be 
how much of these overlap with "git diff master next" (smaller the better,
obviously).
