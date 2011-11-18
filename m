From: "Bernhard R. Link" <brl+git@mail.brlink.eu>
Subject: Re: [PATCH 8/8] Enable GIT_DEBUG_MEMCHECK on git_pathname()
Date: Fri, 18 Nov 2011 13:50:56 +0100
Message-ID: <20111118125056.GA32599@server.brlink.eu>
References: <1321522335-24193-1-git-send-email-pclouds@gmail.com>
 <1321522335-24193-9-git-send-email-pclouds@gmail.com>
 <CALkWK0ndE1Q_jNSV7CBB5W2NyVhcy7kgNO5woWWOw6CXx3cxcA@mail.gmail.com>
 <20111117134201.GA30718@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 18 14:18:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RROKj-0005l2-Ds
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 14:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756258Ab1KRNSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 08:18:16 -0500
Received: from pcpool00.mathematik.uni-freiburg.de ([132.230.30.150]:46620
	"EHLO pcpool00.mathematik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755940Ab1KRNSP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2011 08:18:15 -0500
X-Greylist: delayed 1637 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Nov 2011 08:18:15 EST
Received: from pcpool08.mathematik.uni-freiburg.de ([132.230.30.158])
	by pcpool00.mathematik.uni-freiburg.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1RRNuB-00038j-3X; Fri, 18 Nov 2011 13:50:55 +0100
Received: from brl by pcpool08.mathematik.uni-freiburg.de with local (Exim 4.72)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1RRNuC-00006g-Ke; Fri, 18 Nov 2011 13:50:56 +0100
Content-Disposition: inline
In-Reply-To: <20111117134201.GA30718@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185657>

* Jeff King <peff@peff.net> [111117 14:42]:
> Variable-argument macros were definitely introduced in C99 (and were a
> gcc extension for a while before then).

Though AFAIK not that long. Before that gcc had it's own variadic
syntax a la

#define eprintf(args...) fprintf (stderr, args)

	Bernhard R. Link
