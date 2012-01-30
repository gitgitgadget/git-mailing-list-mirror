From: "Bernhard R. Link" <brl+git@mail.brlink.eu>
Subject: Re: [PATCH v5 2/5] gitweb: add project_filter to limit project list
 to a subdirectory
Date: Mon, 30 Jan 2012 21:48:31 +0100
Message-ID: <20120130204831.GA4701@server.brlink.eu>
References: <20120128165606.GA6770@server.brlink.eu>
 <20120130095252.GA6183@server.brlink.eu>
 <20120130114557.GB9267@server.brlink.eu>
 <201201301657.12944.jnareb@gmail.com>
 <20120130200355.GA2584@server.brlink.eu>
 <7v39axaq0v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 21:48:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rry9D-0005Lm-KX
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 21:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359Ab2A3UsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 15:48:15 -0500
Received: from server.brlink.eu ([78.46.187.186]:54124 "EHLO server.brlink.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753293Ab2A3UsO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 15:48:14 -0500
Received: from mfs.mathematik.uni-freiburg.de ([132.230.30.170] helo=client.brlink.eu)
	by server.brlink.eu with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <brl@mail.brlink.eu>)
	id 1Rry97-0005z0-4x; Mon, 30 Jan 2012 21:48:13 +0100
Received: from brl by client.brlink.eu with local (Exim 4.77)
	(envelope-from <brl@mail.brlink.eu>)
	id 1Rry9Q-0001ET-0Y; Mon, 30 Jan 2012 21:48:32 +0100
Content-Disposition: inline
In-Reply-To: <7v39axaq0v.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189421>

* Junio C Hamano <gitster@pobox.com> [120130 21:34]:
> "Bernhard R. Link" <brl@mail.brlink.eu> writes:
> Regarding the first patch in the series, while it may be a valid perl to
> introduce a new variable, assign to it and then munge its contents with
> s///, all inside a parameter list of a function call, it is doing a bit
> too much and makes it hard to see if the variable may or may not later be
> used in the same scope (in this case, it is not).

I'm fine either way.
I had interpreted <201201301442.06707.jnareb@gmail.com> to be meant this
way, but rereading it I am not sure it was meant this way at all.
I thought this was to express that those variables are not used outside
this scope.

        Bernhard R. Link
