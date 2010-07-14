From: Stefan Sperling <stsp@elego.de>
Subject: Re: [PATCH 0/9] Get svnrdump merged into git.git
Date: Wed, 14 Jul 2010 14:55:05 +0200
Message-ID: <20100714125505.GF25630@jack.stsp.name>
References: <1279064176-6645-1-git-send-email-artagnon@gmail.com>
 <20100713235825.GC12639@debian>
 <20100714001530.GB2308@burratino>
 <20100714002235.GF12639@debian>
 <20100714002843.GC2308@burratino>
 <20100714004959.GG12639@debian>
 <20100714070323.GB25630@jack.stsp.name>
 <20100714112620.GC3496@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, avarab@gmail.com,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Will Palmer <wpalmer@gmail.com>, Greg Stein <gstein@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 14:56:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ1VY-00075D-3d
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 14:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756654Ab0GNM4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 08:56:11 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:58455 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754703Ab0GNM4J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 08:56:09 -0400
X-Envelope-From: stsp@stsp.name
Received: from jack.stsp.name (i577B52DC.versanet.de [87.123.82.220])
	(authenticated bits=128)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o6ECtDSN005533
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 14 Jul 2010 14:55:13 +0200
Received: from jack.stsp.name (stsp@localhost [127.0.0.1])
	by jack.stsp.name (8.14.3/8.14.3) with ESMTP id o6ECtCSl030769;
	Wed, 14 Jul 2010 14:55:12 +0200 (CEST)
Received: (from stsp@localhost)
	by jack.stsp.name (8.14.3/8.14.3/Submit) id o6ECt5AN028555;
	Wed, 14 Jul 2010 14:55:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100714112620.GC3496@debian>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150985>

On Wed, Jul 14, 2010 at 01:26:20PM +0200, Ramkumar Ramachandra wrote:
> Stefan Sperling writes:
> > I didn't catch any licensing discussion. What's the issue?
> 
> I guess there's no issue then- sorry, I know close to nothing about
> licensing.

Well, the only theoretical issue I can see is that the FSF says that
the GPLv2 was incompatible with the Apache 2.0 licence.
See http://www.apache.org/licenses/GPL-compatibility.html

So if git distributed their own version of svnrdump licensed under GPLv2,
depending on who you believe, distributors of Git binaries would violate
the GPLv2 by linking svnrdump to the Subversion libraries.

Mercurial recently switched to GPLv3 for this reason. They have code
that uses Subversion's Python bindings. They made this switch on their
own accord, however, after consulting the Software Freedom Law Center.
The Subversion project itself was not involved in that decision.

Possible workarounds are simply ignoring the FSF, or distributing all
copies of svnrdump under Apache 2.0 or GPLv3 (but the svnrdump included
in Subversion itself must be licensed under Apache 2.0).

Stefan
