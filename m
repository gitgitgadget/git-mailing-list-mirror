From: Stefan Sperling <stsp@elego.de>
Subject: Re: [GSoC update] git-remote-svn: Week 11
Date: Wed, 14 Jul 2010 10:58:22 +0200
Message-ID: <20100714085822.GC25630@jack.stsp.name>
References: <20100712143546.GA17630@debian>
 <4C3B2B48.4070408@drmicha.warpmail.net>
 <20100712152403.GH1931@jack.stsp.name>
 <1278949191.1611.5.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Greg Stein <gstein@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Bert Huijben <rhuijben@collab.net>,
	Sam Vilain <sam@vilain.net>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 10:58:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYxnl-0003hu-HK
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 10:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752787Ab0GNI6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 04:58:45 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:56122 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264Ab0GNI6n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 04:58:43 -0400
X-Envelope-From: stsp@stsp.name
Received: from jack.stsp.name (i577B52DC.versanet.de [87.123.82.220])
	(authenticated bits=128)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o6E8wTM9015013
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 14 Jul 2010 10:58:29 +0200
Received: from jack.stsp.name (stsp@localhost [127.0.0.1])
	by jack.stsp.name (8.14.3/8.14.3) with ESMTP id o6E8wSp1008714;
	Wed, 14 Jul 2010 10:58:28 +0200 (CEST)
Received: (from stsp@localhost)
	by jack.stsp.name (8.14.3/8.14.3/Submit) id o6E8wMFt026501;
	Wed, 14 Jul 2010 10:58:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1278949191.1611.5.camel@wpalmer.simply-domain>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150972>

On Mon, Jul 12, 2010 at 04:39:51PM +0100, Will Palmer wrote:
> On Mon, 2010-07-12 at 17:24 +0200, Stefan Sperling wrote:
> > Regarding compilation, take a look at tools/dev/unix-build/Makefile.svn
> This is all moot, because the whole point is that svndumpr compiles
> against libsvn, so you don't need the whole svn source-tree.

It's not moot. svndumpr may now or in the future be using API calls which
are specific to the Subversion 1.7 libraries, in which case you'll need
to compile Subversion from trunk to get compatible libraries until
1.7 is released. Maybe Ramkumar wants to maintain a 1.6.x-specific
version you can use, but that won't be living in our repository anyway.

Stefan
