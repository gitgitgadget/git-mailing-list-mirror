From: Stefan Sperling <stsp@elego.de>
Subject: Re: [GSoC update] git-remote-svn: Week 11
Date: Mon, 12 Jul 2010 17:24:03 +0200
Message-ID: <20100712152403.GH1931@jack.stsp.name>
References: <20100712143546.GA17630@debian>
 <4C3B2B48.4070408@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Greg Stein <gstein@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Will Palmer <wmpalmer@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Bert Huijben <rhuijben@collab.net>,
	Sam Vilain <sam@vilain.net>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jul 12 17:24:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYKs9-0003dk-L6
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 17:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756044Ab0GLPYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 11:24:31 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:39012 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537Ab0GLPYa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 11:24:30 -0400
X-Envelope-From: stsp@stsp.name
Received: from jack.stsp.name (i577B6896.versanet.de [87.123.104.150])
	(authenticated bits=128)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o6CFOB70008281
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 12 Jul 2010 17:24:11 +0200
Received: from jack.stsp.name (stsp@localhost [127.0.0.1])
	by jack.stsp.name (8.14.3/8.14.3) with ESMTP id o6CFOBIl002039;
	Mon, 12 Jul 2010 17:24:11 +0200 (CEST)
Received: (from stsp@localhost)
	by jack.stsp.name (8.14.3/8.14.3/Submit) id o6CFO3JV028079;
	Mon, 12 Jul 2010 17:24:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C3B2B48.4070408@drmicha.warpmail.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150820>

On Mon, Jul 12, 2010 at 04:48:40PM +0200, Michael J Gruber wrote:
> Ramkumar Ramachandra venit, vidit, dixit 12.07.2010 16:35:
> > it will be pretty painful for Git developers to compile the SVN trunk
> 
> While this is certainly true for the "compilation" part, at least
> getting the source is a snap for us:
> 
> git://git.apache.org/subversion.git
> git://github.com/apache/subversion.git

Regarding compilation, take a look at tools/dev/unix-build/Makefile.svn
in the Subversion tree. Possibly the most painful thing for git devs is
that you'll need an svn binary somewhere in PATH, but any version will do.
Then create an empty directory (say, ~/svn), copy the Makefile in there,
and run make (requires GNU make). That will download and compile Subversion
from trunk, including various dependencies.
If all goes well, binaries (with debug symbols) end up in ~/svn/prefix/

On Linux, -devel packages for a couple of libaries may be needed
(most likely openssl, zlib, expat, libproxy).

Stefan
